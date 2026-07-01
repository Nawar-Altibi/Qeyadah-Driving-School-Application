import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qeyadah_mobile_app/src/core/constants/raw_values.dart';
import 'package:qeyadah_mobile_app/src/core/constants/storage_keys.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/auth/data/mappers/auth_session_mapper.dart';
import 'package:qeyadah_mobile_app/src/features/auth/data/models/auth_session_model.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_session_entity.dart';
import 'package:injectable/injectable.dart';

abstract interface class AuthLocalDataSource {
  FutureEither<void> saveSession(AuthSessionEntity session);
  FutureEither<AuthSessionEntity?> readSession();
  FutureEither<void> clearSession();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(@Named(RawValues.authNamedInstance) this._database);

  final LocalDatabaseInterface _database;

  @override
  FutureEither<void> saveSession(AuthSessionEntity session) async {
    try {
      final model = authSessionEntityToModel(session);
      final result = await _database.save(
        StorageKeys.sessionJson,
        model.toJson(),
      );
      return result.fold(left, (_) => right(null));
    } on Exception catch (error, stackTrace) {
      return left(UnknownFailure(stackTrace: stackTrace));
    }
  }

  @override
  FutureEither<AuthSessionEntity?> readSession() async {
    try {
      final result = await _database.get<Map<dynamic, dynamic>>(
        StorageKeys.sessionJson,
      );
      return result.fold(left, (value) {
        if (value == null) return right(null);
        final map = Map<String, dynamic>.from(value);
        return right(authSessionModelToEntity(AuthSessionModel.fromJson(map)));
      });
    } on Exception catch (error, stackTrace) {
      return left(UnknownFailure(stackTrace: stackTrace));
    }
  }

  @override
  FutureEither<void> clearSession() async {
    final result = await _database.delete(StorageKeys.sessionJson);
    return result.fold(left, (_) => right(null));
  }
}
