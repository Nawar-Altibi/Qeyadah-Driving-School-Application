import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/data/data_sources/notifications_remote_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_entity.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/repositories/notifications_repository.dart';

@LazySingleton(as: NotificationsRepository)
class NotificationsRepositoryImpl implements NotificationsRepository {
  NotificationsRepositoryImpl(this._remoteDataSource);

  final NotificationsRemoteDataSource _remoteDataSource;

  @override
  FutureEither<AppNotificationsPageEntity> getNotifications({
    int page = 1,
    int limit = 20,
  }) {
    return _remoteDataSource.fetchNotifications(page: page, limit: limit);
  }

  @override
  FutureEither<int> getUnreadCount() {
    return _remoteDataSource.fetchUnreadCount();
  }

  @override
  FutureEither<void> markRead(int id) {
    return _remoteDataSource.markRead(id);
  }

  @override
  FutureEither<void> markAllRead() {
    return _remoteDataSource.markAllRead();
  }

  @override
  FutureEither<void> registerDeviceToken({
    required String token,
    required String platform,
  }) {
    return _remoteDataSource.registerDeviceToken(
      token: token,
      platform: platform,
    );
  }

  @override
  FutureEither<void> unregisterDeviceToken(String token) {
    return _remoteDataSource.unregisterDeviceToken(token);
  }
}
