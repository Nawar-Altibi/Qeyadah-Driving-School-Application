import 'package:coore/lib.dart';
import 'package:qeyadah_mobile_app/src/core/constants/raw_values.dart';
import 'package:qeyadah_mobile_app/src/core/constants/storage_keys.dart';

abstract final class AuthTokenCoordinator {
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
