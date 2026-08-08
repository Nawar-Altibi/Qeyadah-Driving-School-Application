import 'package:intl/intl.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/formatters/app_date_formatters.dart';
import 'package:qeyadah_mobile_app/src/core/formatters/app_money_formatters.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_status_badge.dart';
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

  /// School wall-clock is fixed UTC+3 (no DST). Never use device [DateTime.toLocal].
  static DateTime schoolWallClock(DateTime value) {
    final school = value.toUtc().add(const Duration(hours: 3));
    return DateTime(
      school.year,
      school.month,
      school.day,
      school.hour,
      school.minute,
      school.second,
    );
  }

  static String date(DateTime value, {String localeName = 'ar'}) {
    return DateFormat('d MMMM yyyy', localeName).format(schoolWallClock(value));
  }

  static String dateTime(DateTime value, {String localeName = 'ar'}) {
    final wall = schoolWallClock(value);
    final datePart = DateFormat('d MMMM yyyy', localeName).format(wall);
    final timePart = DateFormat.Hm(localeName).format(wall);
    return '$datePart · $timePart';
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

  static AppBadgeTone requestStatusTone(CertificateRequestStatus status) {
    return switch (status) {
      CertificateRequestStatus.completed => AppBadgeTone.success,
      CertificateRequestStatus.failed => AppBadgeTone.danger,
      CertificateRequestStatus.cancelled => AppBadgeTone.neutral,
      CertificateRequestStatus.waitingForTrainingSchedule =>
        AppBadgeTone.warning,
      CertificateRequestStatus.inGovernmentTraining => AppBadgeTone.info,
      CertificateRequestStatus.waitingForTheoreticalExam => AppBadgeTone.info,
      CertificateRequestStatus.waitingForPracticalExam => AppBadgeTone.info,
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
