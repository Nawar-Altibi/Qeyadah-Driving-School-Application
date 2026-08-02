import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/constants/endpoints.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/network_failure_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/auth/data/mappers/auth_session_mapper.dart';
import 'package:qeyadah_mobile_app/src/features/auth/data/models/auth_session_model.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_otp_challenge_entity.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_session_entity.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/params/login_params.dart';

abstract interface class AuthRemoteDataSource {
  FutureEither<AuthSessionEntity> login(LoginParams params);
  FutureEither<AuthTokenPair> refresh(String refreshToken);
  FutureEither<AuthSessionEntity> me();
  FutureEither<List<String>> mePermissions();
  FutureEither<void> logout(String refreshToken);
  FutureEither<void> logoutAll();
  FutureEither<AuthOtpChallengeEntity> requestRegistrationOtp({
    required String name,
    required String phone,
    required String email,
    required String password,
  });
  FutureEither<AuthSessionEntity> registerStudent({
    required String name,
    required String phone,
    required String email,
    required String code,
    required String password,
    String? deviceName,
    String? fcmToken,
    String? platform,
  });
  FutureEither<AuthOtpChallengeEntity> forgotPassword(String phone);
  FutureEither<String> verifyPasswordResetOtp({
    required String phone,
    required String code,
  });
  FutureEither<String> resetPassword({
    required String resetToken,
    required String newPassword,
  });
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._apiHandler);

  final ApiHandlerInterface _apiHandler;

  @override
  FutureEither<AuthSessionEntity> login(LoginParams params) async {
    final response = await _apiHandler.post(
      Endpoints.authLogin,
      body: {
        'phone': params.phone.trim(),
        'password': params.password,
        if (params.deviceName?.trim().isNotEmpty ?? false)
          'deviceName': params.deviceName!.trim(),
        if (params.fcmToken?.trim().isNotEmpty ?? false)
          'fcmToken': params.fcmToken!.trim(),
        if (params.platform?.trim().isNotEmpty ?? false)
          'platform': params.platform!.trim(),
      },
      cancelRequestAdapter: params.cancelRequestAdapter,
    );
    return response.fold(_networkFailure, _sessionFromResponse);
  }

  @override
  FutureEither<AuthTokenPair> refresh(String refreshToken) async {
    final response = await _apiHandler.post(
      Endpoints.authRefresh,
      body: {'refreshToken': refreshToken},
    );
    return response.fold(_networkFailure, (json) {
      final data = _unwrapData(json);
      final accessToken = data['accessToken']?.toString() ?? '';
      final rotatedRefreshToken = data['refreshToken']?.toString() ?? '';
      if (accessToken.isEmpty || rotatedRefreshToken.isEmpty) {
        return left(const FormatFailure(message: 'Invalid refresh response'));
      }
      return right(
        AuthTokenPair(
          accessToken: accessToken,
          refreshToken: rotatedRefreshToken,
        ),
      );
    });
  }

  @override
  FutureEither<AuthSessionEntity> me() async {
    final response = await _apiHandler.get(Endpoints.authMe);
    return response.fold(_networkFailure, (json) {
      try {
        final user = _unwrapData(json);
        return right(
          authSessionModelToEntity(
            AuthSessionModel.fromJson({
              'userId': user['id'],
              'phone': user['phone'],
              'displayName': user['name'],
              'roles': user['roles'],
              'permissions': user['permissions'],
              'mustChangePassword': user['mustChangePassword'],
              'accountStatus': user['accountStatus'],
              'accessToken': '',
            }),
          ),
        );
      } on Exception catch (error, stackTrace) {
        return left(
          FormatFailure(message: error.toString(), stackTrace: stackTrace),
        );
      }
    });
  }

  @override
  FutureEither<List<String>> mePermissions() async {
    final response = await _apiHandler.get(Endpoints.authMePermissions);
    return response.fold(_networkFailure, (json) {
      final data = json['data'];
      if (data is Iterable) {
        return right(data.map((item) => item.toString()).toList());
      }
      return left(const FormatFailure(message: 'Invalid permissions response'));
    });
  }

  @override
  FutureEither<void> logout(String refreshToken) async {
    final response = await _apiHandler.post(
      Endpoints.authLogout,
      body: {'refreshToken': refreshToken},
    );
    return response.fold(_networkFailure, (_) => right(null));
  }

  @override
  FutureEither<void> logoutAll() async {
    final response = await _apiHandler.post(Endpoints.authLogoutAll);
    return response.fold(_networkFailure, (_) => right(null));
  }

  @override
  FutureEither<AuthOtpChallengeEntity> requestRegistrationOtp({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    final response = await _apiHandler.post(
      Endpoints.authRegisterRequestOtp,
      body: {
        'name': name.trim(),
        'phone': phone.trim(),
        'email': email.trim(),
        'password': password,
      },
    );
    return response.fold(_networkFailure, _otpChallengeFromResponse);
  }

  @override
  FutureEither<AuthSessionEntity> registerStudent({
    required String name,
    required String phone,
    required String email,
    required String code,
    required String password,
    String? deviceName,
    String? fcmToken,
    String? platform,
  }) async {
    final response = await _apiHandler.post(
      Endpoints.authRegister,
      body: {
        'name': name.trim(),
        'phone': phone.trim(),
        'email': email.trim(),
        'code': code.trim(),
        'password': password,
        if (deviceName?.trim().isNotEmpty ?? false)
          'deviceName': deviceName!.trim(),
        if (fcmToken?.trim().isNotEmpty ?? false) 'fcmToken': fcmToken!.trim(),
        if (platform?.trim().isNotEmpty ?? false) 'platform': platform!.trim(),
      },
    );
    return response.fold(_networkFailure, _sessionFromResponse);
  }

  @override
  FutureEither<AuthOtpChallengeEntity> forgotPassword(String phone) async {
    final response = await _apiHandler.post(
      Endpoints.authForgotPassword,
      body: {'phone': phone},
    );
    return response.fold(_networkFailure, _otpChallengeFromResponse);
  }

  @override
  FutureEither<String> verifyPasswordResetOtp({
    required String phone,
    required String code,
  }) async {
    final response = await _apiHandler.post(
      Endpoints.authVerifyOtp,
      body: {'phone': phone, 'code': code},
    );
    return response.fold(_networkFailure, (json) {
      final resetToken = _unwrapData(json)['resetToken']?.toString();
      if (resetToken == null || resetToken.isEmpty) {
        return left(const FormatFailure(message: 'Missing reset token'));
      }
      return right(resetToken);
    });
  }

  @override
  FutureEither<String> resetPassword({
    required String resetToken,
    required String newPassword,
  }) async {
    final response = await _apiHandler.post(
      Endpoints.authResetPassword,
      body: {'resetToken': resetToken, 'newPassword': newPassword},
    );
    return response.fold(_networkFailure, (json) {
      final message = _unwrapData(json)['message']?.toString();
      return right(message ?? '');
    });
  }

  Either<Failure, AuthSessionEntity> _sessionFromResponse(
    Map<String, dynamic> json,
  ) {
    try {
      final data = _unwrapData(json);
      final user = Map<String, dynamic>.from(data['user'] as Map);
      final session = AuthSessionModel.fromJson({
        'userId': user['id'],
        'phone': user['phone'],
        'displayName': user['name'],
        'roles': user['roles'],
        'permissions': user['permissions'],
        'mustChangePassword': user['mustChangePassword'],
        'accountStatus': user['accountStatus'],
        'accessToken': data['accessToken'],
        'refreshToken': data['refreshToken'],
      });
      return right(authSessionModelToEntity(session));
    } on Exception catch (error, stackTrace) {
      return left(
        FormatFailure(message: error.toString(), stackTrace: stackTrace),
      );
    }
  }

  Either<Failure, AuthOtpChallengeEntity> _otpChallengeFromResponse(
    Map<String, dynamic> json,
  ) {
    final data = _unwrapData(json);
    return right(
      AuthOtpChallengeEntity(
        message: data['message']?.toString() ?? '',
        developmentCode: data['code']?.toString(),
      ),
    );
  }

  Map<String, dynamic> _unwrapData(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map) return Map<String, dynamic>.from(data);
    return json;
  }

  Either<Failure, T> _networkFailure<T>(NetworkFailure failure) {
    return left(NetworkFailureMapper.toDomainFailure(failure));
  }
}

class AuthTokenPair {
  const AuthTokenPair({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;
}
