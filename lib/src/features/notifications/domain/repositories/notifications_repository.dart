import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_entity.dart';

abstract interface class NotificationsRepository {
  FutureEither<AppNotificationsPageEntity> getNotifications({
    int page = 1,
    int limit = 20,
  });

  FutureEither<int> getUnreadCount();

  FutureEither<void> markRead(int id);

  FutureEither<void> markAllRead();

  FutureEither<void> registerDeviceToken({
    required String token,
    required String platform,
  });

  FutureEither<void> unregisterDeviceToken(String token);
}
