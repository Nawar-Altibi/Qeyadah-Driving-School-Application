enum InstructorInvoiceType {
  lessons,
  bonus;

  static InstructorInvoiceType? fromApi(String? value) {
    return switch (value?.toUpperCase()) {
      'LESSONS' => InstructorInvoiceType.lessons,
      'BONUS' => InstructorInvoiceType.bonus,
      _ => null,
    };
  }
}
