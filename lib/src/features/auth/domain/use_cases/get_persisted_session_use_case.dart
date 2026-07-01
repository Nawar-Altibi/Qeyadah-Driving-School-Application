import 'package:coore/lib.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_session_entity.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetPersistedSessionUseCase
    extends FutureEitherUseCase<AuthSessionEntity?, NoParams> {
  GetPersistedSessionUseCase(this._repository);

  final AuthRepository _repository;

  @override
  FutureEither<AuthSessionEntity?> call(NoParams params) {
    return _repository.getPersistedSession();
  }
}
