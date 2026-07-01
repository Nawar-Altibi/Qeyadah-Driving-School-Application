import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_session_entity.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/params/login_params.dart';
import 'package:qeyadah_mobile_app/src/shared/entities/user_entity.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/user_role.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

abstract interface class AuthRemoteDataSource {
  FutureEither<AuthSessionEntity> login(LoginParams params);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  static const _demoPhone = '0999400001';
  static const _demoPassword = 'Test@12345';

  @override
  FutureEither<AuthSessionEntity> login(LoginParams params) async {
    final phone = params.phone.trim();
    final password = params.password;

    if (phone == _demoPhone && password == _demoPassword) {
      return right(
        AuthSessionEntity(
          user: const UserEntity(
            id: 'demo-user',
            email: 'demo@qeyadah.local',
            displayName: 'Demo Student',
            role: UserRole.user,
          ),
          accessToken: const Uuid().v4(),
          refreshToken: const Uuid().v4(),
        ),
      );
    }

    return left(const AuthFailure(message: 'Invalid phone or password'));
  }
}
