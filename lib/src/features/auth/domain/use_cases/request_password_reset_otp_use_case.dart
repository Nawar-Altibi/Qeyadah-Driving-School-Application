import 'package:coore/lib.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_otp_challenge_entity.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/params/password_reset_params.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class RequestPasswordResetOtpUseCase
    extends FutureEitherUseCase<AuthOtpChallengeEntity, ForgotPasswordParams> {
  RequestPasswordResetOtpUseCase(this._repository);

  final AuthRepository _repository;

  @override
  FutureEither<AuthOtpChallengeEntity> call(ForgotPasswordParams params) {
    return _repository.requestPasswordResetOtp(params);
  }
}
