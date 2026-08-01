enum StudentBookingStatus {
  pendingPayment,
  depositPaid,
  booked,
  completed,
  cancelled,
  expired,
  noShow;

  static StudentBookingStatus? fromApi(String? value) {
    return switch (value?.toUpperCase()) {
      'PENDING_PAYMENT' => StudentBookingStatus.pendingPayment,
      'DEPOSIT_PAID' => StudentBookingStatus.depositPaid,
      'BOOKED' => StudentBookingStatus.booked,
      'COMPLETED' => StudentBookingStatus.completed,
      'CANCELLED' => StudentBookingStatus.cancelled,
      'EXPIRED' => StudentBookingStatus.expired,
      'NO_SHOW' => StudentBookingStatus.noShow,
      _ => null,
    };
  }

  String get apiValue => switch (this) {
    StudentBookingStatus.pendingPayment => 'PENDING_PAYMENT',
    StudentBookingStatus.depositPaid => 'DEPOSIT_PAID',
    StudentBookingStatus.booked => 'BOOKED',
    StudentBookingStatus.completed => 'COMPLETED',
    StudentBookingStatus.cancelled => 'CANCELLED',
    StudentBookingStatus.expired => 'EXPIRED',
    StudentBookingStatus.noShow => 'NO_SHOW',
  };
}
