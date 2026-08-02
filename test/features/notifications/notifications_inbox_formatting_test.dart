import 'package:flutter_test/flutter_test.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_type.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/formatters/notifications_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/navigation/notification_deep_link_router.dart';

void main() {
  group('NotificationsFormatters', () {
    test('maps icons and tones for known types', () {
      expect(
        NotificationsFormatters.notificationTone(
          AppNotificationType.bookingConfirmed,
        ).name,
        'success',
      );
      expect(
        NotificationsFormatters.isCalendarIcon(
          AppNotificationType.instructorSchedule,
        ),
        isTrue,
      );
      expect(
        NotificationsFormatters.isCalendarIcon(AppNotificationType.general),
        isFalse,
      );
    });
  });

  group('NotificationDeepLinkRouter inbox fallback', () {
    test('general resolves to shared inbox', () {
      expect(
        NotificationDeepLinkRouter.resolveDestination(
          type: AppNotificationType.general,
        ).kind,
        NotificationDeepLinkKind.inbox,
      );
    });
  });
}
