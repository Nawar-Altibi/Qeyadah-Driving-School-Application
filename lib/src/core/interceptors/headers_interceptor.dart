import 'package:coore/lib.dart';
import 'package:dio/dio.dart';
import 'package:qeyadah_mobile_app/src/core/constants/raw_values.dart';
import 'package:qeyadah_mobile_app/src/core/constants/storage_keys.dart';

class HeadersInterceptor extends Interceptor {
  static String? _cachedVisitorToken;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final language = await getIt<ConfigService>().getLanguageCode();
    options.headers['Accept-Language'] = language.isEmpty ? 'en' : language;
    options.headers['X-Requested-With'] = 'XMLHttpRequest';

    final visitorToken = await _getVisitorToken();
    if (visitorToken != null && visitorToken.isNotEmpty) {
      options.headers['X-Visitor-Session-Token'] = visitorToken;
    }

    super.onRequest(options, handler);
  }

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    await _updateVisitorTokenFromHeaders(response.headers);
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final headers = err.response?.headers;
    if (headers != null) {
      await _updateVisitorTokenFromHeaders(headers);
    }
    super.onError(err, handler);
  }

  Future<String?> _getVisitorToken() async {
    if (_cachedVisitorToken != null && _cachedVisitorToken!.isNotEmpty) {
      return _cachedVisitorToken;
    }
    try {
      final authDatabase = getIt.get<LocalDatabaseInterface>(
        param1: RawValues.authNamedInstance,
      );
      final response = await authDatabase.get<String>(
        StorageKeys.visitorSessionToken,
      );
      final token = response.fold((_) => null, (value) => value)?.trim();
      if (token != null && token.isNotEmpty) {
        _cachedVisitorToken = token;
      }
      return token;
    } on Object {
      return null;
    }
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
      final authDatabase = getIt.get<LocalDatabaseInterface>(
        param1: RawValues.authNamedInstance,
      );
      await authDatabase.save(StorageKeys.visitorSessionToken, latestToken);
    } on Object {
      // Best-effort persistence.
    }
  }
}
