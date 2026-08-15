import 'dart:async';
import 'dart:collection';

import 'package:coore/lib.dart';
import 'package:dio/dio.dart';
import 'package:mutex/mutex.dart';

/// ---------------------------------------------------------------------------
/// AuthInterceptor
/// ---------------------------------------------------------------------------
/// Base abstract authentication interceptor that:
///  • Adds credentials to requests marked `isAuthorized`
///  • On 401 errors (except refresh or retries), runs a single refresh and
///    replays all pending requests
///  • Wraps *all* errors in the refresh flow as DioException.badResponse
abstract class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenManager);

  final AuthTokenManager _tokenManager;
  final Mutex _refreshMutex = Mutex();
  final Queue<MapEntry<RequestOptions, ErrorInterceptorHandler>> _pending =
      Queue();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.extra['isAuthorized'] == true) {
      unawaited(_attachAuthorizedRequest(options, handler));
      return;
    }
    handler.next(options);
  }

  Future<void> _attachAuthorizedRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      await _injectToken(options);
      handler.next(options);
    } on DioException catch (error) {
      handler.reject(error);
    } catch (error) {
      handler.reject(
        DioException.badResponse(
          statusCode: 401,
          requestOptions: options,
          response: Response(
            requestOptions: options,
            statusCode: 401,
            data: {
              'error': {'status': 401, 'message': 'Auth setup failed: $error'},
            },
          ),
        ),
      );
    }
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (_shouldHandle401(err)) {
      await _queueAndRefresh(err, handler);
    } else {
      handler.reject(err);
    }
  }

  bool _shouldHandle401(DioException err) {
    final opts = err.requestOptions;
    final isAuth = opts.extra['isAuthorized'] == true;
    final isRetry = opts.extra['isRetry'] == true;
    return err.response?.statusCode == 401 &&
        isAuth &&
        !isRetry &&
        !opts.path.contains('auth/refresh');
  }

  Future<void> _injectToken(RequestOptions options) async {
    final token = await _tokenManager.accessToken;
    if (token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
  }

  Future<Never> _clearTokensAndThrowException({
    required DioException err,
    required Object exception,
  }) async {
    await _tokenManager.clearTokens();

    // This new logic inspects the error 'e' from the refresh call
    Map<String, dynamic>? responseData;
    int statusCode = 401;

    if (exception is DioException && exception.response?.data != null) {
      // If the refresh call failed with a specific response from the backend, use it
      statusCode = exception.response!.statusCode ?? 401;
    } else {
      // Otherwise, fall back to a generic message
      responseData = {
        'error': {
          'status': 401,
          'message': 'Token refresh failed: ${exception.toString()}',
        },
      };
    }

    // Now, throw an exception that contains the real backend error message
    throw DioException.badResponse(
      statusCode: statusCode,
      requestOptions: err.requestOptions,
      response: Response(
        requestOptions: err.requestOptions,
        statusCode: statusCode,
        data: responseData,
      ),
    );
    // --- END OF FIX ---
  }

  Future<void> _queueAndRefresh(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    _pending.add(MapEntry(err.requestOptions, handler));

    await _refreshMutex.protect(() async {
      bool success = false;
      try {
        success = await handleRefresh(err);
      } catch (_) {
        success = false;
      }

      while (_pending.isNotEmpty) {
        final entry = _pending.removeFirst();
        if (success) {
          await _retry(entry.key, entry.value);
        } else {
          entry.value.reject(_makeRefreshFailure(entry.key, err));
        }
      }
    });
  }

  Future<void> _retry(
    RequestOptions requestOptions,
    ErrorInterceptorHandler handler,
  ) async {
    final dio = getIt<Dio>();
    requestOptions.extra['isRetry'] = true;
    try {
      final resp = await dio.fetch<Map<String, dynamic>>(requestOptions);
      handler.resolve(resp);
    } on DioException catch (e) {
      handler.reject(e);
    }
  }

  DioException _makeRefreshFailure(RequestOptions opts, DioException err) {
    final statusCode = err.response?.statusCode ?? 401;
    return DioException.badResponse(
      statusCode: statusCode,
      requestOptions: opts,
      response: Response(
        requestOptions: opts,
        statusCode: statusCode,
        data:
            err.response?.data ??
            {
              'error': {
                'status': statusCode,
                'message': 'Token refresh failed',
              },
            },
      ),
    );
  }

  /// Subclasses implement this to actually call your `auth/refresh` endpoint.
  /// Throw or return false on failure.
  Future<bool> handleRefresh(DioException err);
}

/// ---------------------------------------------------------------------------
/// TokenAuthInterceptor
/// ---------------------------------------------------------------------------
/// Sends Bearer tokens and refreshes via `auth/refresh`
class TokenAuthInterceptor extends AuthInterceptor {
  TokenAuthInterceptor(super._tokenManager);

  @override
  Future<bool> handleRefresh(DioException err) async {
    try {
      final rt = await _tokenManager.refreshToken;
      if (rt.isEmpty) return false;

      final api = getIt<ApiHandlerInterface>();
      final result = await api.post('auth/refresh', body: {'refreshToken': rt});

      return result.fold((l) => false, (data) async {
        final payload = data['data'] is Map
            ? Map<String, dynamic>.from(data['data'] as Map)
            : data;
        await _tokenManager.setTokens(
          accessToken:
              (payload['accessToken'] as String?) ??
              (payload['access_token'] as String?),
          refreshToken:
              (payload['refreshToken'] as String?) ??
              (payload['refresh_token'] as String?),
        );
        return true;
      });
    } catch (e) {
      await _clearTokensAndThrowException(err: err, exception: e);
    }
  }
}

/// ---------------------------------------------------------------------------
/// CookieAuthInterceptor
/// ---------------------------------------------------------------------------
/// Sends cookies + optional Bearer header, refreshes via `auth/refresh`
class CookieAuthInterceptor extends AuthInterceptor {
  CookieAuthInterceptor(super._tokenManager);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.extra['withCredentials'] = true;
    super.onRequest(options, handler);
  }

  @override
  Future<bool> handleRefresh(DioException err) async {
    try {
      final api = getIt<ApiHandlerInterface>();
      final result = await api.post('auth/refresh', isAuthorized: true);

      return result.fold((l) => false, (data) async {
        final payload = data['data'] is Map
            ? Map<String, dynamic>.from(data['data'] as Map)
            : data;
        // Server set new cookie; optionally update tokens too
        await _tokenManager.setTokens(
          accessToken:
              (payload['accessToken'] as String?) ??
              (payload['access_token'] as String?),
        );
        return true;
      });
    } catch (e) {
      await _clearTokensAndThrowException(err: err, exception: e);
    }
  }
}
