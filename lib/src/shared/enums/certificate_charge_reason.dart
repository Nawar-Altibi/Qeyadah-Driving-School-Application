enum CertificateChargeReason {
  certificateFee('CERTIFICATE_FEE'),
  reexamTheory('REEXAM_THEORY'),
  reexamPractical('REEXAM_PRACTICAL');

  const CertificateChargeReason(this.apiValue);

  final String apiValue;

  static CertificateChargeReason? fromApi(String? value) {
    if (value == null || value.isEmpty) return null;
    final normalized = value.trim().toUpperCase();
    for (final reason in CertificateChargeReason.values) {
      if (reason.apiValue == normalized) return reason;
    }
    return null;
  }
}
