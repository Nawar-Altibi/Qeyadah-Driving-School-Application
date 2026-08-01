import 'dart:async';

import 'package:coore/lib.dart';
import 'package:dio/dio.dart';
import 'package:qeyadah_mobile_app/src/core/constants/raw_values.dart';
import 'package:qeyadah_mobile_app/src/core/constants/storage_keys.dart';

class HeadersInterceptor extends Interceptor {
  static String? _cachedVisitorToken;
  static String _cachedLanguageCode = 'ar';
  static LocalDatabaseInterface? _authDatabase;

  static void resetForStartup() {
    _authDatabase = null;
    HiveLocalDatabase.resetOpeningFutures();
  }

  static Future<void> warmUp() async {
    resetForStartup();

    try {
      final language = await getIt<ConfigService>().getLanguageCode().timeout(
        const Duration(seconds: 3),
      );
      if (language.isNotEmpty) {
        _cachedLanguageCode = language;
      }
    } on Object {
      // Keep default language.
    }

    try {
      final authDatabase = getIt<LocalDatabaseInterface>(
        param1: RawValues.authNamedInstance,
      );
      _authDatabase = authDatabase;

      final initResult = await authDatabase.initialize().timeout(
        const Duration(seconds: 3),
      );
      if (initResult.isLeft()) return;

      final response = await authDatabase
          .get<String>(StorageKeys.visitorSessionToken)
          .timeout(const Duration(seconds: 3));
      final token = response.fold((_) => null, (value) => value)?.trim();
      if (token != null && token.isNotEmpty) {
        _cachedVisitorToken = token;
      }
    } on Object {
      // Visitor token is optional for auth endpoints.
    }
  }

  static void setLanguageCode(String languageCode) {
    if (languageCode.isNotEmpty) {
      _cachedLanguageCode = languageCode;
    }
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Accept-Language'] = _cachedLanguageCode;
    options.headers['X-Requested-With'] = 'XMLHttpRequest';

    final visitorToken = _cachedVisitorToken;
    if (visitorToken != null && visitorToken.isNotEmpty) {
      options.headers['X-Visitor-Session-Token'] = visitorToken;
    }

    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    unawaited(_updateVisitorTokenFromHeaders(response.headers));
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final headers = err.response?.headers;
    if (headers != null) {
      unawaited(_updateVisitorTokenFromHeaders(headers));
    }
    handler.next(err);
  }

  Future<void> _updateVisitorTokenFromHeaders(Headers headers) async {
    final tokens =
        headers['X-Visitor-Session-Token'] ??
        headers['x-visitor-session-token'];
    final latestToken = (tokens != null && tokens.isNotEmpty)
        ? tokens.first.trim()
        : null;
    if (latestToken == null || latestToken.isEmpty) return;

    _cachedVisitorToken = latestToken;
    try {
      final authDatabase =
          _authDatabase ??
          getIt<LocalDatabaseInterface>(param1: RawValues.authNamedInstance);
      _authDatabase = authDatabase;
      await authDatabase.save(StorageKeys.visitorSessionToken, latestToken);
    } on Object {
      // Best-effort persistence.
    }
  }
}
