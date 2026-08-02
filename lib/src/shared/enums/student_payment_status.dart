enum StudentPaymentStatus {
  pendingDeposit,
  depositPaid,
  fullyPaid,
  depositNonRefundable,
  depositAvailableForRebooking,
  depositUsedInRebooking;

  static StudentPaymentStatus? fromApi(String? value) {
    return switch (value?.toUpperCase()) {
      'PENDING_DEPOSIT' => StudentPaymentStatus.pendingDeposit,
      'DEPOSIT_PAID' => StudentPaymentStatus.depositPaid,
      'FULLY_PAID' => StudentPaymentStatus.fullyPaid,
      'DEPOSIT_NON_REFUNDABLE' => StudentPaymentStatus.depositNonRefundable,
      'DEPOSIT_AVAILABLE_FOR_REBOOKING' =>
        StudentPaymentStatus.depositAvailableForRebooking,
      'DEPOSIT_USED_IN_REBOOKING' =>
        StudentPaymentStatus.depositUsedInRebooking,
      _ => null,
    };
  }

  String get apiValue => switch (this) {
    StudentPaymentStatus.pendingDeposit => 'PENDING_DEPOSIT',
    StudentPaymentStatus.depositPaid => 'DEPOSIT_PAID',
    StudentPaymentStatus.fullyPaid => 'FULLY_PAID',
    StudentPaymentStatus.depositNonRefundable => 'DEPOSIT_NON_REFUNDABLE',
    StudentPaymentStatus.depositAvailableForRebooking =>
      'DEPOSIT_AVAILABLE_FOR_REBOOKING',
    StudentPaymentStatus.depositUsedInRebooking => 'DEPOSIT_USED_IN_REBOOKING',
  };
}
