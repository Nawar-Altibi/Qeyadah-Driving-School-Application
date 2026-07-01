import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qeyadah_mobile_app/src/core/utils/global_functions.dart';

abstract final class ErrorHandler {
  static Future<Either<Failure, T>> safeUseCaseCall<T>({
    required Future<Either<Failure, T>> Function() onConnect,
    Future<Either<Failure, T>> Function()? onDisconnect,
    bool shouldLog = true,
  }) async {
    try {
      if (!await getIt<NetworkStatusInterface>().isConnected) {
        if (onDisconnect != null) {
          final response = await onDisconnect();
          return response.fold((failure) {
            if (shouldLog) {
              logger.error(
                failure.runtimeType,
                failure.message,
                failure.stackTrace,
              );
            }
            return left(failure);
          }, right);
        }
        return left(
          const NoInternetConnectionFailure(
            'Check your internet connection and try again',
          ),
        );
      }

      final response = await onConnect();
      return response.fold((failure) {
        if (shouldLog) {
          logger.error(
            failure.runtimeType,
            failure.message,
            failure.stackTrace,
          );
        }
        return left(failure);
      }, right);
    } on Exception catch (error, stackTrace) {
      logger.error(error.runtimeType, error, stackTrace);
      return left(UnknownFailure(stackTrace: stackTrace));
    }
  }
}
