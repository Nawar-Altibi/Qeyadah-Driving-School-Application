import 'dart:async';

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
  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource) {
    AuthTokenCoordinator.installSessionHiveSync(_localDataSource);
  }

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  /// Keep login/register well under the outer FutureEitherTimeout (25s).
  /// A hanging Hive open/flush must never look like a network timeout after
  /// HTTP 200 — succeed with memory tokens and retry disk in the background.
  static const _sessionSaveTimeout = Duration(seconds: 4);
  static const _tokenPersistTimeout = Duration(seconds: 3);
  static const _sessionSaveRetryDelays = <Duration>[
    Duration(milliseconds: 300),
    Duration(milliseconds: 600),
  ];

  @override
  FutureEither<AuthSessionEntity> login(LoginParams params) async {
    final remote = await _remoteDataSource.login(params);
    return remote.fold((failure) async => left(failure), _persistMobileSession);
  }

  FutureEither<AuthSessionEntity> _persistMobileSession(
    AuthSessionEntity session,
  ) async {
    if (!session.canUseMobileApp) {
      unawaited(AuthTokenCoordinator.clear());
      return left(
        const BusinessFailure(
          message:
              'This account is not available in the mobile app. Please use the dashboard.',
        ),
      );
    }

    // 1) Memory tokens immediately (AuthTokenManager) so interceptors work.
    // Secure-disk writes stay fire-and-forget — some OEMs hang on Keystore.
    try {
      await AuthTokenCoordinator.persist(
        accessToken: session.accessToken,
        refreshToken: session.refreshToken,
      ).timeout(_tokenPersistTimeout);
    } on Object {
      // Memory may already be updated inside setTokens.
    }

    // 2) Prefer durable Hive session_json, but never block UI login on OEM
    // disk hangs. AuthLocalDataSource still keeps an in-process memory copy.
    final saved = await _trySaveSession(session);
    if (!saved) {
      final recovered = await _retrySaveSessionQuick(session);
      if (!recovered) {
        unawaited(_retrySaveSession(session));
      }
    }

    return right(session);
  }

  Future<bool> _trySaveSession(AuthSessionEntity session) async {
    try {
      final result = await _localDataSource
          .saveSession(session)
          .timeout(_sessionSaveTimeout);
      return result.fold((_) => false, (_) => true);
    } on Object {
      return false;
    }
  }

  /// Bounded quick retries on the login path (keep well under ~3s total).
  Future<bool> _retrySaveSessionQuick(AuthSessionEntity session) async {
    for (final delay in _sessionSaveRetryDelays) {
      await Future<void>.delayed(delay);
      if (await _trySaveSession(session)) return true;
    }
    return false;
  }

  Future<void> _retrySaveSession(AuthSessionEntity session) async {
    const lateDelays = <Duration>[
      Duration(seconds: 2),
      Duration(seconds: 4),
      Duration(seconds: 8),
    ];
    for (final delay in lateDelays) {
      await Future<void>.delayed(delay);
      final access = await getIt<AuthTokenManager>().accessToken;
      // Stop if the user logged out or a different session took over.
      if (access.isEmpty || access != session.accessToken) {
        return;
      }
      if (await _trySaveSession(session)) {
        return;
      }
    }
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
    // Read the local Hive session before secure storage. Keystore reads can
    // block long enough to make the router's cold-start restore time out.
    final session = await _localDataSource.readSession();
    return session.fold(
      (failure) async {
        await AuthTokenCoordinator.ensureInterceptorTokensFromLegacyStorage();
        // Hive read failed — still try secure-storage tokens + /me.
        return _restoreSessionFromStoredTokens();
      },
      (value) async {
        if (value != null) {
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
        }
        await AuthTokenCoordinator.ensureInterceptorTokensFromLegacyStorage();
        // session_json missing (save raced with process kill) — rebuild from
        // secure-storage tokens via /auth/me when possible.
        return _restoreSessionFromStoredTokens();
      },
    );
  }

  FutureEither<AuthSessionEntity?> _restoreSessionFromStoredTokens() async {
    final manager = getIt<AuthTokenManager>();
    final access = (await manager.accessToken).trim();
    final refresh = (await manager.refreshToken).trim();
    if (access.isEmpty) {
      return right(null);
    }

    try {
      await AuthTokenCoordinator.persist(
        accessToken: access,
        refreshToken: refresh.isEmpty ? null : refresh,
      ).timeout(_tokenPersistTimeout);
    } on Object {
      // Interceptor may still see in-memory tokens set by setTokens.
    }

    final remote = await _remoteDataSource.me();
    return remote.fold(
      (failure) async {
        // Only wipe credentials on hard auth rejection. Transient network /
        // server errors must not force the user back to login when tokens
        // still exist — next launch can retry, and Hive may already have
        // session_json from a later successful save.
        if (failure is AuthFailure) {
          await AuthTokenCoordinator.clear();
        }
        return right(null);
      },
      (profile) async {
        final merged = AuthSessionEntity(
          user: profile.user,
          accessToken: access,
          refreshToken: refresh.isEmpty ? null : refresh,
        );
        if (!merged.canUseMobileApp) {
          await AuthTokenCoordinator.clear();
          return right(null);
        }
        final saved = await _trySaveSession(merged);
        if (!saved) {
          unawaited(_retrySaveSession(merged));
        }
        return right(merged);
      },
    );
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
