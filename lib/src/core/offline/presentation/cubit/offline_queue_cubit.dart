import 'dart:async';

import 'package:coore/lib.dart';
import 'package:qeyadah_mobile_app/src/core/constants/environment_variables.dart';
import 'package:qeyadah_mobile_app/src/core/offline/domain/entities/queued_api_request_entity.dart';
import 'package:qeyadah_mobile_app/src/core/offline/domain/offline_queue_service.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'offline_queue_state.dart';
part 'offline_queue_cubit.freezed.dart';

@lazySingleton
class OfflineQueueCubit extends AppCoreCubit<OfflineQueueState> {
  OfflineQueueCubit(this._offlineQueueService, this._networkStatus)
    : super(const OfflineQueueState());

  final OfflineQueueService _offlineQueueService;
  final NetworkStatusInterface _networkStatus;
  StreamSubscription<ConnectionStatus>? _subscription;

  Future<void> initialize() async {
    if (!EnvironmentVariables.enableOfflineQueue) return;

    await refreshStatus();
    _subscription = _networkStatus.connectionStream.listen((connection) async {
      if (connection != ConnectionStatus.connected) return;

      final statusResult = await _offlineQueueService.getStatus();
      statusResult.fold((_) {}, (value) async {
        emit(state.copyWith(status: value));
        if (value.isOnline && value.pendingCount > 0) {
          await _offlineQueueService.processPending();
          await refreshStatus();
        }
      });
    });
  }

  Future<void> refreshStatus() async {
    final status = await _offlineQueueService.getStatus();
    status.fold((_) {}, (value) => emit(state.copyWith(status: value)));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
