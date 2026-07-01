import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qeyadah_mobile_app/src/core/offline/data/offline_queue_local_data_source.dart';
import 'package:qeyadah_mobile_app/src/core/offline/domain/entities/queued_api_request_entity.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class OfflineQueueService {
  OfflineQueueService(
    this._localDataSource,
    this._apiHandler,
    this._networkStatus,
  );

  final OfflineQueueLocalDataSource _localDataSource;
  final ApiHandlerInterface _apiHandler;
  final NetworkStatusInterface _networkStatus;

  bool _isProcessing = false;

  Future<Either<Failure, void>> enqueue({
    required HttpMethod method,
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    if (await _networkStatus.isConnected) {
      return _execute(
        method: method,
        path: path,
        queryParameters: queryParameters,
        body: body,
      );
    }

    final item = QueuedApiRequestEntity(
      id: const Uuid().v4(),
      method: method,
      path: path,
      queryParameters: queryParameters,
      body: body,
      queuedAt: DateTime.now(),
    );
    return _localDataSource.enqueue(item);
  }

  Future<Either<Failure, OfflineQueueStatusEntity>> processPending() async {
    if (_isProcessing) {
      return right(
        const OfflineQueueStatusEntity(
          isOnline: true,
          pendingCount: 0,
          isProcessing: true,
        ),
      );
    }

    _isProcessing = true;
    try {
      final isOnline = await _networkStatus.isConnected;
      final pendingResult = await _localDataSource.getPending();
      return pendingResult.fold(left, (pending) async {
        if (!isOnline) {
          return right(
            OfflineQueueStatusEntity(
              isOnline: false,
              pendingCount: pending.length,
              isProcessing: false,
            ),
          );
        }

        for (final item in pending) {
          final processing = item.copyWith(
            status: OfflineQueueItemStatus.processing,
          );
          await _localDataSource.update(processing);

          final result = await _execute(
            method: item.method,
            path: item.path,
            queryParameters: item.queryParameters,
            body: item.body,
          );

          await result.fold(
            (failure) async {
              await _localDataSource.update(
                item.copyWith(
                  status: OfflineQueueItemStatus.failed,
                  retryCount: item.retryCount + 1,
                ),
              );
            },
            (_) async {
              await _localDataSource.remove(item.id);
            },
          );
        }

        final remaining = await _localDataSource.getPending();
        return remaining.fold(
          left,
          (items) => right(
            OfflineQueueStatusEntity(
              isOnline: true,
              pendingCount: items.length,
              isProcessing: false,
            ),
          ),
        );
      });
    } finally {
      _isProcessing = false;
    }
  }

  Future<Either<Failure, OfflineQueueStatusEntity>> getStatus() async {
    final isOnline = await _networkStatus.isConnected;
    final pending = await _localDataSource.getPending();
    return pending.fold(
      left,
      (items) => right(
        OfflineQueueStatusEntity(
          isOnline: isOnline,
          pendingCount: items.length,
          isProcessing: _isProcessing,
        ),
      ),
    );
  }

  Future<Either<Failure, void>> _execute({
    required HttpMethod method,
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final response = switch (method) {
      HttpMethod.get => await _apiHandler.get(
        path,
        queryParameters: queryParameters,
        isAuthorized: false,
      ),
      HttpMethod.post => await _apiHandler.post(
        path,
        body: body,
        queryParameters: queryParameters,
        isAuthorized: false,
      ),
      HttpMethod.put => await _apiHandler.put(
        path,
        body: body,
        queryParameters: queryParameters,
        isAuthorized: false,
      ),
      HttpMethod.patch => await _apiHandler.patch(
        path,
        body: body,
        queryParameters: queryParameters,
        isAuthorized: false,
      ),
      HttpMethod.delete => await _apiHandler.delete(
        path,
        queryParameters: queryParameters,
        isAuthorized: false,
      ),
    };

    return response.fold((failure) => left(failure), (_) => right(null));
  }
}
