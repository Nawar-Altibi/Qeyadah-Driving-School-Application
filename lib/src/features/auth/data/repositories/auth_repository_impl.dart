import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';
import 'package:qeyadah_mobile_app/src/core/services/auth_token_coordinator.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_otp_challenge_entity.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_session_entity.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/params/login_params.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/params/password_reset_params.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/params/register_params.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  FutureEither<AuthSessionEntity> login(LoginParams params) async {
    final remote = await _remoteDataSource.login(params);
    return remote.fold((failure) async => left(failure), _persistMobileSession);
  }

  FutureEither<AuthSessionEntity> _persistMobileSession(
    AuthSessionEntity session,
  ) async {
    if (!session.canUseMobileApp) {
      await AuthTokenCoordinator.clear();
      return left(
        const BusinessFailure(
          message:
              'This account is not available in the mobile app. Please use the dashboard.',
        ),
      );
    }

    // Memory tokens first — login must succeed even if disk I/O hangs
    // (seen on some Android OEMs with secure storage / Hive).
    await AuthTokenCoordinator.persist(
      accessToken: session.accessToken,
      refreshToken: session.refreshToken,
    );
    try {
      final saved = await _localDataSource
          .saveSession(session)
          .timeout(const Duration(seconds: 2));
      // Ignore disk failures; in-memory session is enough to enter the app.
      saved.fold((_) {}, (_) {});
    } on Object {
      // Best-effort session disk write.
    }
    return right(session);
  }

  @override
  FutureEither<void> logout() async {
    String? refreshToken;
    final sessionResult = await _localDataSource.readSession();
    sessionResult.fold((_) {}, (session) {
      refreshToken = session?.refreshToken;
    });

    // Clear local credentials first so logout cannot leave a restorable session
    // if the process is killed while remote logout is in flight.
    await AuthTokenCoordinator.clear();
    final clearResult = await _localDataSource.clearSession();

    final token = refreshToken;
    if (token != null && token.isNotEmpty) {
      try {
        await _remoteDataSource
            .logout(token)
            .timeout(const Duration(seconds: 6));
      } on Object {
        // Remote logout is best-effort after local clear.
      }
    }
    return clearResult;
  }

  @override
  FutureEither<void> logoutAll() async {
    await AuthTokenCoordinator.clear();
    final clearResult = await _localDataSource.clearSession();
    try {
      await _remoteDataSource.logoutAll().timeout(const Duration(seconds: 6));
    } on Object {
      // Remote logout-all is best-effort after local clear.
    }
    return clearResult;
  }

  @override
  FutureEither<AuthSessionEntity?> getPersistedSession() async {
    await AuthTokenCoordinator.ensureInterceptorTokensFromLegacyStorage();
    final session = await _localDataSource.readSession();
    return session.fold((failure) async => left(failure), (value) async {
      if (value == null) return right(null);
      if (!value.canUseMobileApp) {
        await AuthTokenCoordinator.clear();
        await _localDataSource.clearSession();
        return right(null);
      }
      // Rehydrate the in-memory (and secure) token manager from the persisted
      // session. Required on web where secure storage is disabled, and as a
      // safety net when secure storage is empty but Hive still has the session.
      await AuthTokenCoordinator.persist(
        accessToken: value.accessToken,
        refreshToken: value.refreshToken,
      );
      return right(value);
    });
  }

  @override
  FutureEither<AuthSessionEntity> refreshProfile() async {
    final remote = await _remoteDataSource.me();
    return remote.fold((failure) async => left(failure), (profile) async {
      final sessionResult = await _localDataSource.readSession();
      return sessionResult.fold(left, (stored) async {
        if (stored == null) {
          return left(const UnknownFailure());
        }
        final merged = AuthSessionEntity(
          user: profile.user,
          accessToken: stored.accessToken,
          refreshToken: stored.refreshToken,
        );
        final saved = await _localDataSource.saveSession(merged);
        return saved.fold(left, (_) => right(merged));
      });
    });
  }

  @override
  FutureEither<AuthOtpChallengeEntity> requestRegistrationOtp(
    RequestRegistrationOtpParams params,
  ) {
    return _remoteDataSource.requestRegistrationOtp(
      name: params.name,
      phone: params.phone,
      email: params.email,
      password: params.password,
    );
  }

  @override
  FutureEither<AuthSessionEntity> registerStudent(
    RegisterStudentParams params,
  ) async {
    final remote = await _remoteDataSource.registerStudent(
      name: params.name,
      phone: params.phone,
      email: params.email,
      code: params.code,
      password: params.password,
      deviceName: params.deviceName,
      fcmToken: params.fcmToken,
      platform: params.platform,
    );
    return remote.fold((failure) async => left(failure), _persistMobileSession);
  }

  @override
  FutureEither<AuthOtpChallengeEntity> requestPasswordResetOtp(
    ForgotPasswordParams params,
  ) {
    return _remoteDataSource.forgotPassword(params.phone);
  }

  @override
  FutureEither<String> verifyPasswordResetOtp(
    VerifyPasswordResetOtpParams params,
  ) {
    return _remoteDataSource.verifyPasswordResetOtp(
      phone: params.phone,
      code: params.code,
    );
  }

  @override
  FutureEither<void> resetPassword(ResetPasswordParams params) async {
    final result = await _remoteDataSource.resetPassword(
      resetToken: params.resetToken,
      newPassword: params.newPassword,
    );
    return result.fold(left, (_) async {
      await AuthTokenCoordinator.clear();
      final cleared = await _localDataSource.clearSession();
      return cleared.fold(left, (_) => right(null));
    });
  }
}
