import 'package:intl/intl.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/formatters/app_date_formatters.dart';
import 'package:qeyadah_mobile_app/src/core/formatters/app_money_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/formatters/student_bookings_formatters.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/certificate_charge_reason.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/certificate_request_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/exam_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_charge_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';

abstract final class StudentCertificatesFormatters {
  static String fee(int amount) {
    return AppMoneyFormatters.formatGroupedInt(amount);
  }

  static String moneyAmount(String raw) {
    return AppMoneyFormatters.formatGrouped(raw);
  }

  static String countdown(Duration remaining) {
    return AppDateFormatters.countdown(remaining);
  }

  static String date(DateTime value) {
    return DateFormat('yyyy-MM-dd').format(value.toLocal());
  }

  static String dateTime(DateTime value) {
    return DateFormat('yyyy-MM-dd HH:mm').format(value.toLocal());
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

  static String chargeReasonLabel(
    AppLocalizations l10n,
    CertificateChargeReason? reason,
  ) {
    return switch (reason) {
      CertificateChargeReason.certificateFee =>
        l10n.studentCertificatesChargeReasonCertificateFee,
      CertificateChargeReason.reexamTheory =>
        l10n.studentCertificatesChargeReasonReexamTheory,
      CertificateChargeReason.reexamPractical =>
        l10n.studentCertificatesChargeReasonReexamPractical,
      null => l10n.studentCertificatesChargesTitle,
    };
  }

  static String chargeStatusLabel(
    AppLocalizations l10n,
    StudentChargeStatus status,
  ) {
    return StudentBookingsFormatters.chargeStatusLabel(l10n, status);
  }
}
