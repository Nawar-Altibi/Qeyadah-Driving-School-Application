import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/src/core/formatters/app_date_formatters.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_status_badge.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_type.dart';

abstract final class NotificationsFormatters {
  static IconData notificationIcon(AppNotificationType type) {
    return switch (type) {
      AppNotificationType.bookingConfirmed => PhosphorIconsBold.calendarCheck,
      AppNotificationType.bookingCancelled => PhosphorIconsBold.calendarX,
      AppNotificationType.bookingExpired => PhosphorIconsBold.clockCountdown,
      AppNotificationType.paymentAccepted => PhosphorIconsBold.wallet,
      AppNotificationType.paymentRejected => PhosphorIconsBold.xCircle,
      AppNotificationType.certificateStatusChanged =>
        PhosphorIconsBold.identificationCard,
      AppNotificationType.instructorSchedule => PhosphorIconsBold.calendar,
      AppNotificationType.general => PhosphorIconsBold.megaphone,
    };
  }

  static AppBadgeTone notificationTone(AppNotificationType type) {
    return switch (type) {
      AppNotificationType.bookingConfirmed => AppBadgeTone.success,
      AppNotificationType.bookingCancelled => AppBadgeTone.danger,
      AppNotificationType.bookingExpired => AppBadgeTone.warning,
      AppNotificationType.paymentAccepted => AppBadgeTone.success,
      AppNotificationType.paymentRejected => AppBadgeTone.danger,
      AppNotificationType.certificateStatusChanged => AppBadgeTone.info,
      AppNotificationType.instructorSchedule => AppBadgeTone.info,
      AppNotificationType.general => AppBadgeTone.neutral,
    };
  }

  static String notificationTimestampLabel(
    DateTime createdAt,
    String localeName,
  ) {
    return AppDateFormatters.dateTimeLabel(createdAt, localeName);
  }

  static bool isCalendarIcon(AppNotificationType type) {
    return type == AppNotificationType.bookingConfirmed ||
        type == AppNotificationType.bookingCancelled ||
        type == AppNotificationType.instructorSchedule;
  }
}
