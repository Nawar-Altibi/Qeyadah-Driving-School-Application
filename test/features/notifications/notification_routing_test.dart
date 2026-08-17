import 'package:flutter_test/flutter_test.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_type.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/navigation/notification_deep_link_router.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/user_role.dart';

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

  group('NotificationDeepLinkRouter.resolveDestination', () {
    test(
      'routes booking and payment types to detail when bookingId parses',
      () {
        for (final type in <AppNotificationType>[
          AppNotificationType.bookingConfirmed,
          AppNotificationType.bookingCancelled,
          AppNotificationType.bookingExpired,
          AppNotificationType.paymentAccepted,
          AppNotificationType.paymentRejected,
        ]) {
          final destination = NotificationDeepLinkRouter.resolveDestination(
            type: type,
            bookingIdRaw: '555',
          );
          expect(destination.kind, NotificationDeepLinkKind.bookingDetail);
          expect(destination.bookingId, 555);
        }
      },
    );

    test('falls back to bookings list when bookingId missing or invalid', () {
      for (final raw in <String?>[null, '', 'null', 'abc']) {
        final destination = NotificationDeepLinkRouter.resolveDestination(
          type: AppNotificationType.bookingConfirmed,
          bookingIdRaw: raw,
        );
        expect(destination.kind, NotificationDeepLinkKind.bookingsList);
        expect(destination.bookingId, isNull);
      }
    });

    test('routes certificate with id to detail and without id to hub', () {
      final withId = NotificationDeepLinkRouter.resolveDestination(
        type: AppNotificationType.certificateStatusChanged,
        certificateIdRaw: '42',
      );
      expect(withId.kind, NotificationDeepLinkKind.certificateDetail);
      expect(withId.certificateId, '42');

      final withoutId = NotificationDeepLinkRouter.resolveDestination(
        type: AppNotificationType.certificateStatusChanged,
        certificateIdRaw: 'null',
      );
      expect(withoutId.kind, NotificationDeepLinkKind.certificatesHub);
    });

    test('routes instructor schedule and general to known surfaces', () {
      expect(
        NotificationDeepLinkRouter.resolveDestination(
          type: AppNotificationType.instructorSchedule,
        ).kind,
        NotificationDeepLinkKind.instructorSchedule,
      );
      expect(
        NotificationDeepLinkRouter.resolveDestination(
          type: AppNotificationType.general,
        ).kind,
        NotificationDeepLinkKind.inbox,
      );
    });

    test(
      'instructor booking types open the instructor schedule, not student detail',
      () {
        for (final type in <AppNotificationType>[
          AppNotificationType.bookingConfirmed,
          AppNotificationType.bookingCancelled,
          AppNotificationType.bookingExpired,
          AppNotificationType.paymentAccepted,
          AppNotificationType.paymentRejected,
        ]) {
          final destination = NotificationDeepLinkRouter.resolveDestination(
            type: type,
            bookingIdRaw: '555',
            role: UserRole.instructor,
          );
          expect(destination.kind, NotificationDeepLinkKind.instructorHome);
          expect(destination.bookingId, isNull);
        }
      },
    );

    test('instructor general notifications open invoices', () {
      final destination = NotificationDeepLinkRouter.resolveDestination(
        type: AppNotificationType.general,
        role: UserRole.instructor,
      );
      expect(destination.kind, NotificationDeepLinkKind.instructorInvoices);
    });

    test(
      'instructor certificate notifications open the instructor schedule',
      () {
        final destination = NotificationDeepLinkRouter.resolveDestination(
          type: AppNotificationType.certificateStatusChanged,
          certificateIdRaw: '42',
          role: UserRole.instructor,
        );
        expect(destination.kind, NotificationDeepLinkKind.instructorHome);
        expect(destination.certificateId, isNull);
      },
    );

    test(
      'push type keys accept type or notificationType via fromApi input',
      () {
        expect(
          AppNotificationType.fromApi('PAYMENT_REJECTED'),
          AppNotificationType.paymentRejected,
        );
        final destination = NotificationDeepLinkRouter.resolveDestination(
          type: AppNotificationType.fromApi('PAYMENT_REJECTED'),
          bookingIdRaw: '9',
        );
        expect(destination.kind, NotificationDeepLinkKind.bookingDetail);
        expect(destination.bookingId, 9);
      },
    );
  });
}
