import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_otp_challenge_entity.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_session_entity.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/params/login_params.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/params/password_reset_params.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/params/register_params.dart';

abstract interface class AuthRepository {
  FutureEither<AuthSessionEntity> login(LoginParams params);

  FutureEither<void> logout();

  FutureEither<void> logoutAll();

  FutureEither<AuthSessionEntity?> getPersistedSession();

  FutureEither<AuthSessionEntity> refreshProfile();

  FutureEither<AuthOtpChallengeEntity> requestRegistrationOtp(
    RequestRegistrationOtpParams params,
  );

  FutureEither<AuthSessionEntity> registerStudent(RegisterStudentParams params);

  FutureEither<AuthOtpChallengeEntity> requestPasswordResetOtp(
    ForgotPasswordParams params,
  );

  FutureEither<String> verifyPasswordResetOtp(
    VerifyPasswordResetOtpParams params,
  );

  FutureEither<void> resetPassword(ResetPasswordParams params);
}
