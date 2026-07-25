import 'package:coore/lib.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_entity.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/use_cases/notifications_use_cases.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/cubit/notifications_unread_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/navigation/notification_deep_link_router.dart';

class NotificationsInboxState {
  const NotificationsInboxState({
    this.apiState = const ApiState<AppNotificationsPageEntity>.initial(),
    this.isLoadingMore = false,
    this.isMarkingAll = false,
  });

  final ApiState<AppNotificationsPageEntity> apiState;
  final bool isLoadingMore;
  final bool isMarkingAll;

  NotificationsInboxState copyWith({
    ApiState<AppNotificationsPageEntity>? apiState,
    bool? isLoadingMore,
    bool? isMarkingAll,
  }) => NotificationsInboxState(
    apiState: apiState ?? this.apiState,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    isMarkingAll: isMarkingAll ?? this.isMarkingAll,
  );
}

@injectable
class NotificationsInboxCubit
    extends
        AppCoreCoreCubit<NotificationsInboxState, AppNotificationsPageEntity> {
  NotificationsInboxCubit(
    this._loadNotifications,
    this._markRead,
    this._markAllRead,
    this._unreadCubit,
    this._deepLinkRouter,
  ) : super(const NotificationsInboxState());

  final LoadNotificationsUseCase _loadNotifications;
  final MarkNotificationReadUseCase _markRead;
  final MarkAllNotificationsReadUseCase _markAllRead;
  final NotificationsUnreadCubit _unreadCubit;
  final NotificationDeepLinkRouter _deepLinkRouter;

  @override
  ApiState<AppNotificationsPageEntity> getApiState(
    NotificationsInboxState state,
  ) => state.apiState;

  @override
  NotificationsInboxState setApiState(
    NotificationsInboxState state,
    ApiState<AppNotificationsPageEntity> apiState,
  ) => state.copyWith(apiState: apiState);

  Future<void> load() async {
    emit(
      state.copyWith(apiState: const ApiState.loading(), isLoadingMore: false),
    );
    final result = await _loadNotifications();
    result.fold(
      (failure) => emit(
        state.copyWith(apiState: ApiState.failed(failure, retryFunction: load)),
      ),
      (page) {
        emit(state.copyWith(apiState: ApiState.succeeded(page)));
        _unreadCubit.refresh();
      },
    );
  }

  Future<void> loadMore() async {
    final current = state.apiState.maybeWhen(
      succeeded: (value) => value,
      orElse: () => null,
    );
    if (current == null || !current.hasMorePages || state.isLoadingMore) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));
    final result = await _loadNotifications(page: current.page + 1);
    result.fold(
      (_) => emit(state.copyWith(isLoadingMore: false)),
      (nextPage) => emit(
        state.copyWith(
          isLoadingMore: false,
          apiState: ApiState.succeeded(current.appendPage(nextPage)),
        ),
      ),
    );
  }

  Future<void> openNotification(AppNotificationEntity notification) async {
    if (!notification.isRead) {
      final current = state.apiState.maybeWhen(
        succeeded: (value) => value,
        orElse: () => null,
      );
      if (current != null) {
        final updated = current.mapNotifications((item) {
          if (item.id != notification.id) return item;
          return item.copyWith(isRead: true, readAt: DateTime.now());
        });
        emit(state.copyWith(apiState: ApiState.succeeded(updated)));
        _unreadCubit.decrementLocally();
      }
      await _markRead(notification.id);
      await _unreadCubit.refresh();
    }
    _deepLinkRouter.openFromInboxItem(notification);
  }

  Future<void> markAllRead() async {
    emit(state.copyWith(isMarkingAll: true));
    final result = await _markAllRead();
    result.fold((_) => emit(state.copyWith(isMarkingAll: false)), (_) {
      final current = state.apiState.maybeWhen(
        succeeded: (value) => value,
        orElse: () => null,
      );
      if (current != null) {
        final updated = current.mapNotifications(
          (item) => item.copyWith(isRead: true, readAt: DateTime.now()),
        );
        emit(
          state.copyWith(
            isMarkingAll: false,
            apiState: ApiState.succeeded(updated),
          ),
        );
      } else {
        emit(state.copyWith(isMarkingAll: false));
      }
      _unreadCubit.clearLocally();
    });
  }
}
