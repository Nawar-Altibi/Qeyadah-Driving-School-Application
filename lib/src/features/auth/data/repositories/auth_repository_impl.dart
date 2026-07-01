import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qeyadah_mobile_app/src/core/services/auth_token_coordinator.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_session_entity.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/params/login_params.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  @override
  FutureEither<AuthSessionEntity> login(LoginParams params) async {
    final remote = await _remoteDataSource.login(params);
    return remote.fold(left, (session) async {
      await AuthTokenCoordinator.persist(
        accessToken: session.accessToken,
        refreshToken: session.refreshToken,
      );
      final saved = await _localDataSource.saveSession(session);
      return saved.fold(left, (_) => right(session));
    });
  }

  @override
  FutureEither<void> logout() async {
    await AuthTokenCoordinator.clear();
    return _localDataSource.clearSession();
  }

  @override
  FutureEither<AuthSessionEntity?> getPersistedSession() async {
    await AuthTokenCoordinator.ensureInterceptorTokensFromLegacyStorage();
    return _localDataSource.readSession();
  }
}
