import 'package:coore/lib.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';

abstract final class NetworkFailureMapper {
  static Failure toDomainFailure(NetworkFailure failure) {
    return switch (failure) {
      NoInternetConnectionFailure() => failure,
      BadRequestFailure() ||
      ConflictFailure() ||
      TooManyRequestsFailure() => BusinessFailure(
        message: failure.message,
        stackTrace: failure.stackTrace,
      ),
      UnauthorizedRequestFailure() => AuthFailure(
        message: failure.message,
        stackTrace: failure.stackTrace,
      ),
      ForbiddenFailure() => failure,
      ValidationFailure() => failure,
      NotFoundFailure() => failure,
      RequestCancelledFailure() => OperationCancelledFailure(
        message: failure.message,
        stackTrace: failure.stackTrace,
      ),
      RequestTimeoutFailure() => failure,
      _ => failure,
    };
  }
}
