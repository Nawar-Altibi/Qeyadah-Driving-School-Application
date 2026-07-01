import 'package:equatable/equatable.dart';

enum HttpMethod { get, post, put, patch, delete }

enum OfflineQueueItemStatus { pending, processing, completed, failed }

class QueuedApiRequestEntity extends Equatable {
  const QueuedApiRequestEntity({
    required this.id,
    required this.method,
    required this.path,
    this.queryParameters,
    this.body,
    required this.queuedAt,
    this.retryCount = 0,
    this.status = OfflineQueueItemStatus.pending,
  });

  final String id;
  final HttpMethod method;
  final String path;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? body;
  final DateTime queuedAt;
  final int retryCount;
  final OfflineQueueItemStatus status;

  QueuedApiRequestEntity copyWith({
    OfflineQueueItemStatus? status,
    int? retryCount,
  }) {
    return QueuedApiRequestEntity(
      id: id,
      method: method,
      path: path,
      queryParameters: queryParameters,
      body: body,
      queuedAt: queuedAt,
      retryCount: retryCount ?? this.retryCount,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    id,
    method,
    path,
    queryParameters,
    body,
    queuedAt,
    retryCount,
    status,
  ];
}

class OfflineQueueStatusEntity extends Equatable {
  const OfflineQueueStatusEntity({
    required this.isOnline,
    required this.pendingCount,
    required this.isProcessing,
  });

  final bool isOnline;
  final int pendingCount;
  final bool isProcessing;

  @override
  List<Object?> get props => [isOnline, pendingCount, isProcessing];
}
