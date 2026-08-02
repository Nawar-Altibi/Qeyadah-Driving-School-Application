enum CertificateRequestStatus {
  waitingForTrainingSchedule('WAITING_FOR_TRAINING_SCHEDULE'),
  inGovernmentTraining('IN_GOVERNMENT_TRAINING'),
  waitingForTheoreticalExam('WAITING_FOR_THEORETICAL_EXAM'),
  waitingForPracticalExam('WAITING_FOR_PRACTICAL_EXAM'),
  completed('COMPLETED'),
  failed('FAILED'),
  cancelled('CANCELLED');

  const CertificateRequestStatus(this.apiValue);

  final String apiValue;

  static CertificateRequestStatus? fromApi(String? value) {
    if (value == null || value.isEmpty) return null;
    final normalized = value.trim().toUpperCase();
    for (final status in CertificateRequestStatus.values) {
      if (status.apiValue == normalized) return status;
    }
    return null;
  }

  bool get isTerminal =>
      this == CertificateRequestStatus.completed ||
      this == CertificateRequestStatus.failed ||
      this == CertificateRequestStatus.cancelled;
}
