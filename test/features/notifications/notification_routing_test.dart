import 'package:flutter_test/flutter_test.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_type.dart';

void main() {
  group('AppNotificationType.fromApi', () {
    test('maps known types', () {
      expect(
        AppNotificationType.fromApi('BOOKING_CONFIRMED'),
        AppNotificationType.bookingConfirmed,
      );
      expect(
        AppNotificationType.fromApi('INSTRUCTOR_SCHEDULE'),
        AppNotificationType.instructorSchedule,
      );
    });

    test('falls back to general', () {
      expect(
        AppNotificationType.fromApi('UNKNOWN'),
        AppNotificationType.general,
      );
      expect(AppNotificationType.fromApi(null), AppNotificationType.general);
    });
  });
}
