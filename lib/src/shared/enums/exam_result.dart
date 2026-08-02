enum ExamResult {
  pass('PASS'),
  fail('FAIL'),
  absent('ABSENT');

  const ExamResult(this.apiValue);

  final String apiValue;

  static ExamResult? fromApi(String? value) {
    if (value == null || value.isEmpty) return null;
    final normalized = value.trim().toUpperCase();
    for (final result in ExamResult.values) {
      if (result.apiValue == normalized) return result;
    }
    return null;
  }
}
