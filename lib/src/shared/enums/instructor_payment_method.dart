enum InstructorPaymentMethod {
  cash,
  shamCash;

  static InstructorPaymentMethod? fromApi(String? value) {
    return switch (value?.toUpperCase()) {
      'CASH' => InstructorPaymentMethod.cash,
      'SHAM_CASH' => InstructorPaymentMethod.shamCash,
      _ => null,
    };
  }
}
