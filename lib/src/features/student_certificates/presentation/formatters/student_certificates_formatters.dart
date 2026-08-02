import 'package:intl/intl.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/formatters/student_booking_formatters.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/certificate_request_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/exam_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';

abstract final class StudentCertificatesFormatters {
  static String fee(int amount) {
    return NumberFormat('#,###').format(amount);
  }

  static String countdown(Duration remaining) {
    return StudentBookingFormatters.countdown(remaining);
  }

  static String examTypeLabel(AppLocalizations l10n, ExamType type) {
    return switch (type) {
      ExamType.theory => l10n.studentCertificatesExamTypeTheory,
      ExamType.practical => l10n.studentCertificatesExamTypePractical,
    };
  }

  static String transmissionTypeLabel(
    AppLocalizations l10n,
    TrainingType type,
  ) {
    return switch (type) {
      TrainingType.manual => l10n.studentCertificatesTransmissionManual,
      TrainingType.automatic => l10n.studentCertificatesTransmissionAutomatic,
    };
  }

  static String requestStatusLabel(
    AppLocalizations l10n,
    CertificateRequestStatus status,
  ) {
    return switch (status) {
      CertificateRequestStatus.waitingForTrainingSchedule =>
        l10n.studentCertificatesStatusWaitingForTrainingSchedule,
      CertificateRequestStatus.inGovernmentTraining =>
        l10n.studentCertificatesStatusInGovernmentTraining,
      CertificateRequestStatus.waitingForTheoreticalExam =>
        l10n.studentCertificatesStatusWaitingForTheoreticalExam,
      CertificateRequestStatus.waitingForPracticalExam =>
        l10n.studentCertificatesStatusWaitingForPracticalExam,
      CertificateRequestStatus.completed =>
        l10n.studentCertificatesStatusCompleted,
      CertificateRequestStatus.failed => l10n.studentCertificatesStatusFailed,
      CertificateRequestStatus.cancelled =>
        l10n.studentCertificatesStatusCancelled,
    };
  }
}
