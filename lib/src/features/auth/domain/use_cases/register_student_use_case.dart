import 'package:coore/lib.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_session_entity.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/params/register_params.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class RegisterStudentUseCase
    extends FutureEitherUseCase<AuthSessionEntity, RegisterStudentParams> {
  RegisterStudentUseCase(this._repository);

  final AuthRepository _repository;

  @override
  FutureEither<AuthSessionEntity> call(RegisterStudentParams params) {
    return _repository.registerStudent(params);
  }
}
