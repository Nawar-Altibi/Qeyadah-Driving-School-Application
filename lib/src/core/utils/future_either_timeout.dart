import 'dart:async';

import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';

abstract final class FutureEitherTimeout {
  static const defaultTimeout = Duration(seconds: 15);

  static FutureEither<T> guard<T>(
    FutureEither<T> operation, {
    Duration timeout = defaultTimeout,
  }) async {
    try {
      return await operation.timeout(timeout);
    } on TimeoutException {
      return left(const RequestTimeoutFailure('Request timed out'));
    }
  }
}
