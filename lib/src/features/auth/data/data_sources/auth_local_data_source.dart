import 'dart:convert';

import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/constants/raw_values.dart';
import 'package:qeyadah_mobile_app/src/core/constants/storage_keys.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/auth/data/mappers/auth_session_mapper.dart';
import 'package:qeyadah_mobile_app/src/features/auth/data/models/auth_session_model.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_session_entity.dart';

abstract interface class AuthLocalDataSource {
  FutureEither<void> saveSession(AuthSessionEntity session);
  FutureEither<AuthSessionEntity?> readSession();
  FutureEither<void> clearSession();
}

@LazySingleton(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl(@Named(RawValues.authNamedInstance) this._database);

  final LocalDatabaseInterface _database;

  /// Same-process cache (mirrors muntaji). Survives Hive transient failures
  /// within one launch; durable across force-kill still requires disk write.
  AuthSessionEntity? _memorySession;

  @override
  FutureEither<void> saveSession(AuthSessionEntity session) async {
    _memorySession = session;
    try {
      final model = authSessionEntityToModel(session);
      final result = await _database.save(
        StorageKeys.sessionJson,
        // Persist a primitive instead of a Hive Map. This makes the session
        // portable across launches and avoids runtime generic-map casts while
        // restoring it after Android has killed the process.
        jsonEncode(model.toJson()),
      );
      return result.fold(left, (_) => right(null));
    } on Exception catch (_, stackTrace) {
      return left(UnknownFailure(stackTrace: stackTrace));
    }
  }

  @override
  FutureEither<AuthSessionEntity?> readSession() async {
    try {
      final result = await _database.get<Object>(StorageKeys.sessionJson);
      return result.fold(
        (failure) {
          // Disk failed — still return hot memory if this process had login.
          if (_memorySession != null) {
            return right(_memorySession);
          }
          return left(failure);
        },
        (value) {
          if (value == null) {
            return right(_memorySession);
          }
          final map = _sessionJsonToMap(value);
          if (map == null) {
            return right(_memorySession);
          }
          final session = authSessionModelToEntity(
            AuthSessionModel.fromJson(map),
          );
          _memorySession = session;
          return right(session);
        },
      );
    } on Exception catch (_, stackTrace) {
      if (_memorySession != null) {
        return right(_memorySession);
      }
      return left(UnknownFailure(stackTrace: stackTrace));
    }
  }

  /// Supports the previous Hive Map format so users do not lose an existing
  /// signed-in session when upgrading to the JSON representation.
  Map<String, dynamic>? _sessionJsonToMap(Object value) {
    if (value is String) {
      final decoded = jsonDecode(value);
      return decoded is Map ? Map<String, dynamic>.from(decoded) : null;
    }
    if (value is Map) return Map<String, dynamic>.from(value);
    return null;
  }

  @override
  FutureEither<void> clearSession() async {
    _memorySession = null;
    final sessionResult = await _database.delete(StorageKeys.sessionJson);
    // Instructor caches are session-scoped; drop them with the auth session.
    await _database.delete(StorageKeys.instructorProfileCache);
    await _database.delete(StorageKeys.instructorWeeklyScheduleCache);
    return sessionResult.fold(left, (_) => right(null));
  }
}
