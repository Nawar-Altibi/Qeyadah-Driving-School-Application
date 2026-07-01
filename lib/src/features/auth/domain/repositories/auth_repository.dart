import 'package:coore/lib.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_session_entity.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/params/login_params.dart';

abstract interface class AuthRepository {
  FutureEither<AuthSessionEntity> login(LoginParams params);
  FutureEither<void> logout();
  FutureEither<AuthSessionEntity?> getPersistedSession();
}
