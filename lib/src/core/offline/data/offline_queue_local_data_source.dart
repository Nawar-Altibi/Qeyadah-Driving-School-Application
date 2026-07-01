import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qeyadah_mobile_app/src/core/constants/raw_values.dart';
import 'package:qeyadah_mobile_app/src/core/offline/domain/entities/queued_api_request_entity.dart';
import 'package:injectable/injectable.dart';

abstract interface class OfflineQueueLocalDataSource {
  Future<Either<Failure, void>> enqueue(QueuedApiRequestEntity item);
  Future<Either<Failure, List<QueuedApiRequestEntity>>> getPending();
  Future<Either<Failure, void>> update(QueuedApiRequestEntity item);
  Future<Either<Failure, void>> remove(String id);
}

@LazySingleton(as: OfflineQueueLocalDataSource)
class OfflineQueueLocalDataSourceImpl implements OfflineQueueLocalDataSource {
  OfflineQueueLocalDataSourceImpl(
    @Named(RawValues.offlineQueueBox) this._database,
  );

  static const _storageKey = 'offline_queue_items';

  final LocalDatabaseInterface _database;

  @override
  Future<Either<Failure, void>> enqueue(QueuedApiRequestEntity item) async {
    final pending = await getPending();
    return pending.fold(left, (items) async {
      final updated = [...items, item];
      final save = await _database.save(_storageKey, _serialize(updated));
      return save.fold(left, (_) => right(null));
    });
  }

  @override
  Future<Either<Failure, List<QueuedApiRequestEntity>>> getPending() async {
    final result = await _database.get<List<dynamic>>(_storageKey);
    return result.fold(left, (value) {
      if (value == null) return right(const []);
      final items =
          value
              .map((e) => _deserialize(Map<String, dynamic>.from(e as Map)))
              .where((item) => item.status == OfflineQueueItemStatus.pending)
              .toList()
            ..sort((a, b) => a.queuedAt.compareTo(b.queuedAt));
      return right(items);
    });
  }

  @override
  Future<Either<Failure, void>> update(QueuedApiRequestEntity item) async {
    final all = await _readAll();
    return all.fold(left, (items) async {
      final index = items.indexWhere((element) => element.id == item.id);
      if (index == -1) return right(null);
      final updated = [...items]..[index] = item;
      final save = await _database.save(_storageKey, _serialize(updated));
      return save.fold(left, (_) => right(null));
    });
  }

  @override
  Future<Either<Failure, void>> remove(String id) async {
    final all = await _readAll();
    return all.fold(left, (items) async {
      final updated = items.where((item) => item.id != id).toList();
      final save = await _database.save(_storageKey, _serialize(updated));
      return save.fold(left, (_) => right(null));
    });
  }

  Future<Either<Failure, List<QueuedApiRequestEntity>>> _readAll() async {
    final result = await _database.get<List<dynamic>>(_storageKey);
    return result.fold(left, (value) {
      if (value == null) return right(const []);
      return right(
        value
            .map((e) => _deserialize(Map<String, dynamic>.from(e as Map)))
            .toList(),
      );
    });
  }

  List<Map<String, dynamic>> _serialize(List<QueuedApiRequestEntity> items) {
    return items
        .map(
          (item) => {
            'id': item.id,
            'method': item.method.name,
            'path': item.path,
            'queryParameters': item.queryParameters,
            'body': item.body,
            'queuedAt': item.queuedAt.toIso8601String(),
            'retryCount': item.retryCount,
            'status': item.status.name,
          },
        )
        .toList();
  }

  QueuedApiRequestEntity _deserialize(Map<String, dynamic> json) {
    return QueuedApiRequestEntity(
      id: json['id'] as String,
      method: HttpMethod.values.byName(json['method'] as String),
      path: json['path'] as String,
      queryParameters: json['queryParameters'] == null
          ? null
          : Map<String, dynamic>.from(json['queryParameters'] as Map),
      body: json['body'] == null
          ? null
          : Map<String, dynamic>.from(json['body'] as Map),
      queuedAt: DateTime.parse(json['queuedAt'] as String),
      retryCount: json['retryCount'] as int? ?? 0,
      status: OfflineQueueItemStatus.values.byName(json['status'] as String),
    );
  }
}
