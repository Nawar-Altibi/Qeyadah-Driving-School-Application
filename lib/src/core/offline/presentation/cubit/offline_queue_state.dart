part of 'offline_queue_cubit.dart';

@freezed
abstract class OfflineQueueState with _$OfflineQueueState {
  const factory OfflineQueueState({OfflineQueueStatusEntity? status}) =
      _OfflineQueueState;
}
