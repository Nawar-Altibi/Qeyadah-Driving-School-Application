import 'package:coore/lib.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/params/password_reset_params.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class ResetPasswordUseCase
    extends FutureEitherUseCase<void, ResetPasswordParams> {
  ResetPasswordUseCase(this._repository);

  final AuthRepository _repository;

  @override
  FutureEither<void> call(ResetPasswordParams params) {
    return _repository.resetPassword(params);
  }
}
