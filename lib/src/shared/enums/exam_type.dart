enum ExamType {
  theory('THEORY'),
  practical('PRACTICAL');

  const ExamType(this.apiValue);

  final String apiValue;

  static ExamType? fromApi(String? value) {
    if (value == null || value.isEmpty) return null;
    final normalized = value.trim().toUpperCase();
    for (final type in ExamType.values) {
      if (type.apiValue == normalized) return type;
    }
    return null;
  }
}
