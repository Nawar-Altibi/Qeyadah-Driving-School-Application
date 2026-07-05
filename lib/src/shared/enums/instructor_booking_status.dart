enum InstructorBookingStatus {
  booked,
  completed,
  noShow,
  cancelled,
  expired,
  pendingPayment;

  static InstructorBookingStatus? fromApi(String? value) {
    return switch (value?.toUpperCase()) {
      'BOOKED' => InstructorBookingStatus.booked,
      'COMPLETED' => InstructorBookingStatus.completed,
      'NO_SHOW' => InstructorBookingStatus.noShow,
      'CANCELLED' => InstructorBookingStatus.cancelled,
      'EXPIRED' => InstructorBookingStatus.expired,
      'PENDING_PAYMENT' => InstructorBookingStatus.pendingPayment,
      _ => null,
    };
  }
}
