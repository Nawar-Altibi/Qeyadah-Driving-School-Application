enum AppNotificationType {
  bookingConfirmed,
  bookingCancelled,
  bookingExpired,
  paymentAccepted,
  paymentRejected,
  certificateStatusChanged,
  instructorSchedule,
  general;

  static AppNotificationType fromApi(String? value) {
    return switch (value?.toUpperCase()) {
      'BOOKING_CONFIRMED' => AppNotificationType.bookingConfirmed,
      'BOOKING_CANCELLED' => AppNotificationType.bookingCancelled,
      'BOOKING_EXPIRED' => AppNotificationType.bookingExpired,
      'PAYMENT_ACCEPTED' => AppNotificationType.paymentAccepted,
      'PAYMENT_REJECTED' => AppNotificationType.paymentRejected,
      'CERTIFICATE_STATUS_CHANGED' =>
        AppNotificationType.certificateStatusChanged,
      'INSTRUCTOR_SCHEDULE' => AppNotificationType.instructorSchedule,
      'GENERAL' => AppNotificationType.general,
      _ => AppNotificationType.general,
    };
  }

  String get apiValue => switch (this) {
    AppNotificationType.bookingConfirmed => 'BOOKING_CONFIRMED',
    AppNotificationType.bookingCancelled => 'BOOKING_CANCELLED',
    AppNotificationType.bookingExpired => 'BOOKING_EXPIRED',
    AppNotificationType.paymentAccepted => 'PAYMENT_ACCEPTED',
    AppNotificationType.paymentRejected => 'PAYMENT_REJECTED',
    AppNotificationType.certificateStatusChanged =>
      'CERTIFICATE_STATUS_CHANGED',
    AppNotificationType.instructorSchedule => 'INSTRUCTOR_SCHEDULE',
    AppNotificationType.general => 'GENERAL',
  };
}
