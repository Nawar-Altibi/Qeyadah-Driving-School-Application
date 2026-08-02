import 'package:coore/lib.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/notifications/screens/instructor_notifications_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/screens/instructor_weekly_schedule_screen.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_entity.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_type.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/navigation/student_bookings_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/navigation/student_certificates_navigation.dart';

enum NotificationDeepLinkKind {
  bookingDetail,
  bookingsList,
  certificateDetail,
  certificatesHub,
  instructorSchedule,
  inbox,
}

/// Pure routing decision for push + inbox taps (testable without navigator).
@immutable
class NotificationDeepLinkDestination {
  const NotificationDeepLinkDestination({
    required this.kind,
    this.bookingId,
    this.certificateId,
  });

  final NotificationDeepLinkKind kind;
  final int? bookingId;
  final String? certificateId;
}

/// Defensive deep-link routing for push + inbox taps.
@lazySingleton
class NotificationDeepLinkRouter {
  const NotificationDeepLinkRouter();

  void openFromPushData(Map<String, dynamic> data) {
    final type = AppNotificationType.fromApi(
      (data['type'] ?? data['notificationType'])?.toString(),
    );
    final destination = resolveDestination(
      type: type,
      bookingIdRaw: data['bookingId']?.toString(),
      certificateIdRaw: data['certificateId']?.toString(),
    );
    _navigate(destination);
  }

  void openFromInboxItem(AppNotificationEntity item) {
    final destination = resolveDestination(
      type: item.notificationType,
      bookingIdRaw: item.data['bookingId'],
      certificateIdRaw: item.data['certificateId'],
    );
    _navigate(destination);
  }

  @visibleForTesting
  static NotificationDeepLinkDestination resolveDestination({
    required AppNotificationType type,
    String? bookingIdRaw,
    String? certificateIdRaw,
  }) {
    switch (type) {
      case AppNotificationType.instructorSchedule:
        return const NotificationDeepLinkDestination(
          kind: NotificationDeepLinkKind.instructorSchedule,
        );
      case AppNotificationType.bookingConfirmed:
      case AppNotificationType.bookingCancelled:
      case AppNotificationType.bookingExpired:
      case AppNotificationType.paymentAccepted:
      case AppNotificationType.paymentRejected:
        final bookingId = _parseBookingId(bookingIdRaw);
        if (bookingId != null) {
          return NotificationDeepLinkDestination(
            kind: NotificationDeepLinkKind.bookingDetail,
            bookingId: bookingId,
          );
        }
        return const NotificationDeepLinkDestination(
          kind: NotificationDeepLinkKind.bookingsList,
        );
      case AppNotificationType.certificateStatusChanged:
        final certificateId = _normalizeId(certificateIdRaw);
        if (certificateId != null) {
          return NotificationDeepLinkDestination(
            kind: NotificationDeepLinkKind.certificateDetail,
            certificateId: certificateId,
          );
        }
        return const NotificationDeepLinkDestination(
          kind: NotificationDeepLinkKind.certificatesHub,
        );
      case AppNotificationType.general:
        return const NotificationDeepLinkDestination(
          kind: NotificationDeepLinkKind.inbox,
        );
    }
  }

  void _navigate(NotificationDeepLinkDestination destination) {
    switch (destination.kind) {
      case NotificationDeepLinkKind.bookingDetail:
        final bookingId = destination.bookingId;
        if (bookingId == null) {
          StudentBookingsNavigation.goList();
          return;
        }
        StudentBookingsNavigation.goDetail(bookingId: bookingId);
      case NotificationDeepLinkKind.bookingsList:
        StudentBookingsNavigation.goList();
      case NotificationDeepLinkKind.certificateDetail:
        final certificateId = destination.certificateId;
        if (certificateId == null || certificateId.isEmpty) {
          StudentCertificatesNavigation.goHub();
          return;
        }
        StudentCertificatesNavigation.goDetail(certificateId: certificateId);
      case NotificationDeepLinkKind.certificatesHub:
        StudentCertificatesNavigation.goHub();
      case NotificationDeepLinkKind.instructorSchedule:
        CoreNavigator.pushNamed(InstructorWeeklyScheduleScreen.routeName);
      case NotificationDeepLinkKind.inbox:
        // Shared /notifications route lands in PR 4C; keep working path for now.
        CoreNavigator.pushNamed(InstructorNotificationsScreen.routeName);
    }
  }

  static int? _parseBookingId(String? raw) {
    final normalized = _normalizeId(raw);
    if (normalized == null) return null;
    return int.tryParse(normalized);
  }

  static String? _normalizeId(String? raw) {
    final value = raw?.trim();
    if (value == null || value.isEmpty || value == 'null') return null;
    return value;
  }
}
