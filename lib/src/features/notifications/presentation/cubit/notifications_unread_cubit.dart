import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/use_cases/notifications_use_cases.dart';

@lazySingleton
class NotificationsUnreadCubit extends Cubit<int> {
  NotificationsUnreadCubit(this._loadUnreadCount) : super(0);

  final LoadUnreadNotificationsCountUseCase _loadUnreadCount;

  Future<void> refresh() async {
    final result = await _loadUnreadCount();
    result.fold((_) {}, (count) => emit(count < 0 ? 0 : count));
  }

  void reset() => emit(0);

  void decrementLocally() {
    if (state <= 0) return;
    emit(state - 1);
  }

  void clearLocally() => emit(0);
}
