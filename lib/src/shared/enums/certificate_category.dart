enum CertificateCategory {
  b('B'),
  b1('B1'),
  c('C'),
  d('D');

  const CertificateCategory(this.apiValue);

  final String apiValue;

  static CertificateCategory? fromApi(String? value) {
    if (value == null || value.isEmpty) return null;
    final normalized = value.trim().toUpperCase();
    for (final category in CertificateCategory.values) {
      if (category.apiValue == normalized) return category;
    }
    return null;
  }
}
