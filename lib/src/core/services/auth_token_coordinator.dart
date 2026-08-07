import 'package:coore/lib.dart';
import 'package:qeyadah_mobile_app/src/core/constants/raw_values.dart';
import 'package:qeyadah_mobile_app/src/core/constants/storage_keys.dart';
import 'package:qeyadah_mobile_app/src/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/entities/auth_session_entity.dart';

abstract final class AuthTokenCoordinator {
  static bool _sessionHiveSyncInstalled = false;

  /// Wire AuthTokenManager refreshes into Hive `session_json` so cold starts
  /// rehydrate rotated tokens instead of stale ones.
  static void installSessionHiveSync(AuthLocalDataSource localDataSource) {
    if (_sessionHiveSyncInstalled) return;
    _sessionHiveSyncInstalled = true;
    getIt<AuthTokenManager>().onTokensPersisted =
        ({String? accessToken, String? refreshToken}) {
          return _syncSessionTokens(
            localDataSource,
            accessToken: accessToken,
            refreshToken: refreshToken,
          );
        };
  }

  static Future<void> persist({
    String? accessToken,
    String? refreshToken,
  }) async {
    final access = accessToken?.trim();
    final refresh = refreshToken?.trim();
    await getIt<AuthTokenManager>().setTokens(
      accessToken: access != null && access.isNotEmpty ? access : null,
      refreshToken: refresh != null && refresh.isNotEmpty ? refresh : null,
    );
  }

  static Future<void> clear() async {
    await getIt<AuthTokenManager>().clearTokens();
    await _clearLegacyHiveTokens();
  }

  static Future<void> ensureInterceptorTokensFromLegacyStorage() async {
    final manager = getIt<AuthTokenManager>();
    final existing = await manager.accessToken;
    if (existing.isNotEmpty) return;

    try {
      final db = getIt<LocalDatabaseInterface>(
        instanceName: RawValues.authNamedInstance,
      );
      final accessResult = await db.get<String>(StorageKeys.authToken);
      final refreshResult = await db.get<String>(StorageKeys.authRefreshToken);
      final access = accessResult.fold((_) => null, (v) => v)?.trim();
      final refresh = refreshResult.fold((_) => null, (v) => v)?.trim();
      if ((access == null || access.isEmpty) &&
          (refresh == null || refresh.isEmpty)) {
        return;
      }
      await manager.setTokens(accessToken: access, refreshToken: refresh);
    } on Object {
      // Best-effort migration.
    }
  }

  static Future<void> _syncSessionTokens(
    AuthLocalDataSource localDataSource, {
    String? accessToken,
    String? refreshToken,
  }) async {
    try {
      final sessionResult = await localDataSource.readSession();
      await sessionResult.fold((_) async {}, (session) async {
        if (session == null) return;
        final access = accessToken?.trim();
        final refresh = refreshToken?.trim();
        final nextAccess = (access != null && access.isNotEmpty)
            ? access
            : session.accessToken;
        final nextRefresh = (refresh != null && refresh.isNotEmpty)
            ? refresh
            : session.refreshToken;
        if (nextAccess == session.accessToken &&
            nextRefresh == session.refreshToken) {
          return;
        }
        await localDataSource.saveSession(
          AuthSessionEntity(
            user: session.user,
            accessToken: nextAccess,
            refreshToken: nextRefresh,
          ),
        );
      });
    } on Object {
      // Best-effort Hive token sync after refresh.
    }
  }

  static Future<void> _clearLegacyHiveTokens() async {
    try {
      final db = getIt<LocalDatabaseInterface>(
        instanceName: RawValues.authNamedInstance,
      );
      await db.delete(StorageKeys.authToken);
      await db.delete(StorageKeys.authRefreshToken);
    } on Object {
      // Best-effort cleanup.
    }
  }
}
