import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_type.dart';

class AppNotificationEntity {
  const AppNotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.notificationType,
    required this.data,
    required this.isRead,
    this.readAt,
    required this.createdAt,
  });

  final int id;
  final String title;
  final String body;
  final AppNotificationType notificationType;
  final Map<String, String> data;
  final bool isRead;
  final DateTime? readAt;
  final DateTime createdAt;

  AppNotificationEntity copyWith({bool? isRead, DateTime? readAt}) {
    return AppNotificationEntity(
      id: id,
      title: title,
      body: body,
      notificationType: notificationType,
      data: data,
      isRead: isRead ?? this.isRead,
      readAt: readAt ?? this.readAt,
      createdAt: createdAt,
    );
  }
}

class AppNotificationsPageEntity {
  const AppNotificationsPageEntity({
    required this.notifications,
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });

  factory AppNotificationsPageEntity.empty() =>
      const AppNotificationsPageEntity(
        notifications: [],
        page: 1,
        limit: 20,
        total: 0,
        totalPages: 1,
      );

  final List<AppNotificationEntity> notifications;
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  bool get hasMorePages => page < totalPages;

  AppNotificationsPageEntity appendPage(AppNotificationsPageEntity next) {
    return AppNotificationsPageEntity(
      notifications: [...notifications, ...next.notifications],
      page: next.page,
      limit: next.limit,
      total: next.total,
      totalPages: next.totalPages,
    );
  }

  AppNotificationsPageEntity mapNotifications(
    AppNotificationEntity Function(AppNotificationEntity item) transform,
  ) {
    return AppNotificationsPageEntity(
      notifications: notifications.map(transform).toList(),
      page: page,
      limit: limit,
      total: total,
      totalPages: totalPages,
    );
  }
}
