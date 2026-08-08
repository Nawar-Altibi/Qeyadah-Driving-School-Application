import 'dart:async';

import 'package:coore/lib.dart';

class AuthTokenManager {
  AuthTokenManager(
    this._secureDatabaseInterface, {
    this.secureStorageEnabled = false,
  });

  /// Samsung / some OEMs can hang indefinitely on
  /// `FlutterSecureStorage` writes. Keep memory tokens authoritative and
  /// treat disk I/O as fire-and-forget — `Future.timeout` alone has still
  /// let login look like a request timeout after HTTP 200/201.
  static const _secureWriteTimeout = Duration(seconds: 2);

  final SecureDatabaseInterface _secureDatabaseInterface;
  String? _accessToken;
  String? _refreshToken;
  final bool secureStorageEnabled;

  /// Optional hook after memory tokens are updated (e.g. sync app session disk).
  ///
  /// Not invoked from [clearTokens]. Callers should ignore empty/null pairs.
  FutureOr<void> Function({String? accessToken, String? refreshToken})?
  onTokensPersisted;

  /// Retrieves the access token.
  ///
  /// If secure storage is enabled, first checks if the token is already available
  /// in memory. If not, it reads the token from secure storage. In case of a failure
  /// (or an empty value), it returns an empty string.
  Future<String> get accessToken async {
    if (!secureStorageEnabled) return _accessToken ?? '';
    if (_accessToken != null && _accessToken!.isNotEmpty) {
      return _accessToken!;
    }

    try {
      final tokenFromStorage = await _secureDatabaseInterface
          .read('accessToken')
          .timeout(_secureWriteTimeout);
      return tokenFromStorage.fold((failure) => '', (token) {
        _accessToken = token;
        return token ?? '';
      });
    } on Object {
      return '';
    }
  }

  /// Retrieves the refresh token.
  ///
  /// If secure storage is enabled, first checks if the token is already available
  /// in memory. If not, it reads the token from secure storage. In case of a failure
  /// (or an empty value), it returns an empty string.
  Future<String> get refreshToken async {
    if (!secureStorageEnabled) return _refreshToken ?? '';
    if (_refreshToken != null && _refreshToken!.isNotEmpty) {
      return _refreshToken!;
    }

    try {
      final tokenFromStorage = await _secureDatabaseInterface
          .read('refreshToken')
          .timeout(_secureWriteTimeout);
      return tokenFromStorage.fold((failure) => '', (token) {
        _refreshToken = token;
        return token ?? '';
      });
    } on Object {
      return '';
    }
  }

  /// Sets the tokens in memory and, if secure storage is enabled, persists them.
  ///
  /// Memory is always updated synchronously before this returns. Disk writes and
  /// [onTokensPersisted] are fire-and-forget — never await them on auth
  /// critical paths (login / register / refresh).
  Future<void> setTokens({String? accessToken, String? refreshToken}) async {
    _accessToken = accessToken;
    _refreshToken = refreshToken;

    if (secureStorageEnabled) {
      unawaited(
        _bestEffortSecureWrite(() async {
          if (accessToken != null && accessToken.isNotEmpty) {
            await _secureDatabaseInterface.write('accessToken', accessToken);
          }
          if (refreshToken != null && refreshToken.isNotEmpty) {
            await _secureDatabaseInterface.write('refreshToken', refreshToken);
          }
        }),
      );
    }

    final hook = onTokensPersisted;
    final hasAccess = accessToken != null && accessToken.isNotEmpty;
    final hasRefresh = refreshToken != null && refreshToken.isNotEmpty;
    if (hook != null && (hasAccess || hasRefresh)) {
      unawaited(
        _runTokensPersistedHook(
          hook,
          accessToken: accessToken,
          refreshToken: refreshToken,
        ),
      );
    }
  }

  Future<void> _runTokensPersistedHook(
    FutureOr<void> Function({String? accessToken, String? refreshToken}) hook, {
    String? accessToken,
    String? refreshToken,
  }) async {
    try {
      await Future<void>(
        () => hook(accessToken: accessToken, refreshToken: refreshToken),
      ).timeout(_secureWriteTimeout);
    } on Object {
      // Session-disk sync is best-effort; memory tokens already updated.
    }
  }

  /// Clears tokens from memory and secure storage (if enabled).
  Future<void> clearTokens() async {
    _accessToken = null;
    _refreshToken = null;

    if (!secureStorageEnabled) return;

    unawaited(
      _bestEffortSecureWrite(() async {
        await _secureDatabaseInterface.delete('accessToken');
        await _secureDatabaseInterface.delete('refreshToken');
      }),
    );
  }

  Future<void> _bestEffortSecureWrite(Future<void> Function() action) async {
    try {
      await action().timeout(_secureWriteTimeout);
    } on Object {
      // Memory tokens already updated; disk persistence is optional.
    }
  }
}
