enum InstructorNotificationType {
  bookingConfirmed,
  bookingCancelled,
  bookingExpired,
  paymentAccepted,
  paymentRejected,
  certificateStatusChanged,
  instructorSchedule,
  general;

  static InstructorNotificationType fromApi(String? value) {
    return switch (value?.toUpperCase()) {
      'BOOKING_CONFIRMED' => InstructorNotificationType.bookingConfirmed,
      'BOOKING_CANCELLED' => InstructorNotificationType.bookingCancelled,
      'BOOKING_EXPIRED' => InstructorNotificationType.bookingExpired,
      'PAYMENT_ACCEPTED' => InstructorNotificationType.paymentAccepted,
      'PAYMENT_REJECTED' => InstructorNotificationType.paymentRejected,
      'CERTIFICATE_STATUS_CHANGED' =>
        InstructorNotificationType.certificateStatusChanged,
      'INSTRUCTOR_SCHEDULE' => InstructorNotificationType.instructorSchedule,
      'GENERAL' => InstructorNotificationType.general,
      _ => InstructorNotificationType.general,
    };
  }
}
