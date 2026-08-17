import 'package:coore/src/api_handler/models/error_response_model.dart';
import 'package:coore/src/error_handling/exception_mapper/network_exception_mapper.dart';
import 'package:coore/src/error_handling/failures/network_failure.dart';
import 'package:dio/dio.dart';

class DioNetworkExceptionMapper implements NetworkExceptionMapper {
  final Map<int, NetworkFailure Function(ErrorResponseModel, StackTrace?)>
  _codeToFailureMap = {
    400: (ErrorResponseModel error, StackTrace? stackTrace) =>
        BadRequestFailure(error.message, stackTrace: stackTrace),
    401: (ErrorResponseModel error, StackTrace? stackTrace) =>
        UnauthorizedRequestFailure(error.message, stackTrace: stackTrace),

    403: (ErrorResponseModel error, StackTrace? stackTrace) =>
        ForbiddenFailure(error.message, stackTrace: stackTrace),

    404: (ErrorResponseModel error, StackTrace? stackTrace) =>
        NotFoundFailure(error.message, stackTrace: stackTrace),

    405: (ErrorResponseModel error, StackTrace? stackTrace) =>
        MethodNotAllowedFailure(_defaultErrorMessage, stackTrace: stackTrace),

    406: (ErrorResponseModel error, StackTrace? stackTrace) =>
        NotAcceptableFailure(_defaultErrorMessage, stackTrace: stackTrace),

    409: (ErrorResponseModel error, StackTrace? stackTrace) =>
        ConflictFailure(error.message, stackTrace: stackTrace),

    413: (ErrorResponseModel error, StackTrace? stackTrace) =>
        PayloadTooLargeFailure(_defaultErrorMessage, stackTrace: stackTrace),
    422: (ErrorResponseModel error, StackTrace? stackTrace) =>
        ValidationFailure(
          errors: error.errorsMap,
          message: error.message,
          stackTrace: stackTrace,
        ),

    429: (ErrorResponseModel error, StackTrace? stackTrace) =>
        TooManyRequestsFailure(error.message, stackTrace: stackTrace),

    418: (ErrorResponseModel error, StackTrace? stackTrace) =>
        TeapotFailure(_defaultErrorMessage, stackTrace: stackTrace),

    451: (ErrorResponseModel error, StackTrace? stackTrace) =>
        UnavailableForLegalReasonsFailure(
          error.message,
          stackTrace: stackTrace,
        ),

    500: (ErrorResponseModel error, StackTrace? stackTrace) =>
        InternalServerErrorFailure(
          _messageOrDefault(error.message),
          stackTrace: stackTrace,
        ),

    502: (ErrorResponseModel error, StackTrace? stackTrace) =>
        BadGatewayFailure(
          _messageOrDefault(error.message),
          stackTrace: stackTrace,
        ),

    503: (ErrorResponseModel error, StackTrace? stackTrace) =>
        ServiceUnavailableFailure(
          _messageOrDefault(error.message),
          stackTrace: stackTrace,
        ),

    504: (ErrorResponseModel error, StackTrace? stackTrace) =>
        GatewayTimeoutFailure(
          _messageOrDefault(error.message),
          stackTrace: stackTrace,
        ),

    505: (ErrorResponseModel error, StackTrace? stackTrace) =>
        HttpVersionNotSupportedFailure(
          _defaultErrorMessage,
          stackTrace: stackTrace,
        ),
  };

  @override
  NetworkFailure mapException(Exception exception, StackTrace? stackTrace) {
    if (exception is! DioException) {
      return NoInternetConnectionFailure(
        _defaultErrorMessage,
        stackTrace: stackTrace,
      );
    }
    switch (exception.type) {
      case DioExceptionType.cancel:
        return RequestCancelledFailure(
          'Request cancelled',
          stackTrace: stackTrace,
        );

      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return RequestTimeoutFailure(
          'Request timed out',
          stackTrace: stackTrace,
        );

      case DioExceptionType.unknown:
        return NoInternetConnectionFailure(
          'No internet connection',
          stackTrace: stackTrace,
        );

      case DioExceptionType.badCertificate:
        return UnableToProcessFailure(
          'Invalid or expired SSL certificate',
          stackTrace: stackTrace,
        );

      case DioExceptionType.connectionError:
        return ConnectionErrorFailure(
          'Unable to establish a connection with the server',
          stackTrace: stackTrace,
        );

      case DioExceptionType.badResponse:
        return _mapBadResponse(exception.response, stackTrace);
    }
  }

  NetworkFailure _mapBadResponse(Response? response, StackTrace? stackTrace) {
    final errorModel = response?.data is Map
        ? ErrorResponseModel.fromJson(
            _normalizeErrorJson(response?.data as Map),
          )
        : ErrorResponseModel(errorsMap: {}, message: _defaultErrorMessage);
    final statusCode = response?.statusCode ?? 0;
    if (_codeToFailureMap[statusCode] != null) {
      return _codeToFailureMap[statusCode]!.call(errorModel, stackTrace);
    }
    return InvalidStatusCodeFailure(
      'Invalid status code',
      stackTrace: stackTrace,
    );
  }

  Map<String, dynamic> _normalizeErrorJson(Map<dynamic, dynamic> json) {
    final normalized = Map<String, dynamic>.from(json);
    final message = normalized['message'];
    if (message is List) {
      normalized['message'] = message.map((item) => item.toString()).join('\n');
    } else if (message == null) {
      normalized['message'] = _defaultErrorMessage;
    } else {
      normalized['message'] = message.toString();
    }
    normalized['errors'] = normalized['errors'] is Map
        ? Map<String, dynamic>.from(normalized['errors'] as Map)
        : <String, String>{};
    return normalized;
  }

  static String _messageOrDefault(String message) {
    final trimmed = message.trim();
    return trimmed.isEmpty ? _defaultErrorMessage : trimmed;
  }

  static String get _defaultErrorMessage => 'Error, please try again later';
}
