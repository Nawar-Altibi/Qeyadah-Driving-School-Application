import 'package:coore/lib.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/notifications/screens/instructor_notifications_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/screens/instructor_weekly_schedule_screen.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_entity.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_type.dart';

/// Defensive deep-link routing for push + inbox taps.
@lazySingleton
class NotificationDeepLinkRouter {
  const NotificationDeepLinkRouter();

  void openFromPushData(Map<String, dynamic> data) {
    final type = AppNotificationType.fromApi(data['type']?.toString());
    _open(
      type: type,
      bookingId: data['bookingId']?.toString(),
      certificateId: data['certificateId']?.toString(),
    );
  }

  void openFromInboxItem(AppNotificationEntity item) {
    _open(
      type: item.notificationType,
      bookingId: item.data['bookingId'],
      certificateId: item.data['certificateId'],
    );
  }

  void _open({
    required AppNotificationType type,
    String? bookingId,
    String? certificateId,
  }) {
    // Prefer entity screens when ids exist; otherwise open the shared inbox.
    switch (type) {
      case AppNotificationType.instructorSchedule:
        CoreNavigator.pushNamed(InstructorWeeklyScheduleScreen.routeName);
      case AppNotificationType.bookingConfirmed:
      case AppNotificationType.bookingCancelled:
      case AppNotificationType.bookingExpired:
      case AppNotificationType.certificateStatusChanged:
      case AppNotificationType.paymentAccepted:
      case AppNotificationType.paymentRejected:
      case AppNotificationType.general:
        CoreNavigator.pushNamed(InstructorNotificationsScreen.routeName);
    }

    // Keep identifiers available for future typed screens.
    assert(() {
      bookingId;
      certificateId;
      return true;
    }());
  }
}
