enum StudentPaymentStatus {
  pending,
  paid,
  failed;

  static StudentPaymentStatus? fromApi(String? value) {
    return switch (value?.toUpperCase()) {
      'PENDING' => StudentPaymentStatus.pending,
      'PAID' => StudentPaymentStatus.paid,
      'FAILED' => StudentPaymentStatus.failed,
      _ => null,
    };
  }

  String get apiValue => switch (this) {
    StudentPaymentStatus.pending => 'PENDING',
    StudentPaymentStatus.paid => 'PAID',
    StudentPaymentStatus.failed => 'FAILED',
  };
}
