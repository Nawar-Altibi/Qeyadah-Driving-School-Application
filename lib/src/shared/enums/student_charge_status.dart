enum StudentChargeStatus {
  unpaid,
  partiallyPaid,
  paid,
  cancelled;

  static StudentChargeStatus? fromApi(String? value) {
    return switch (value?.toUpperCase()) {
      'UNPAID' => StudentChargeStatus.unpaid,
      'PARTIALLY_PAID' => StudentChargeStatus.partiallyPaid,
      'PAID' => StudentChargeStatus.paid,
      'CANCELLED' => StudentChargeStatus.cancelled,
      _ => null,
    };
  }

  String get apiValue => switch (this) {
    StudentChargeStatus.unpaid => 'UNPAID',
    StudentChargeStatus.partiallyPaid => 'PARTIALLY_PAID',
    StudentChargeStatus.paid => 'PAID',
    StudentChargeStatus.cancelled => 'CANCELLED',
  };
}
