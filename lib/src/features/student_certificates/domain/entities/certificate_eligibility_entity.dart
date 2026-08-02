import 'package:equatable/equatable.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/certificate_category.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/certificate_request_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/exam_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';

class CertificateNewRequestEligibility extends Equatable {
  const CertificateNewRequestEligibility({
    required this.allowed,
    required this.availableTransmissionTypes,
    required this.completedCategories,
    this.reason,
    this.message,
  });

  final bool allowed;
  final List<TrainingType> availableTransmissionTypes;
  final List<CertificateCategory> completedCategories;
  final String? reason;
  final String? message;

  bool get isFirstRequest => completedCategories.isEmpty;

  @override
  List<Object?> get props => [
    allowed,
    availableTransmissionTypes,
    completedCategories,
    reason,
    message,
  ];
}

class CertificateReexamEligibility extends Equatable {
  const CertificateReexamEligibility({
    required this.eligible,
    this.examType,
    this.fee,
    this.examScheduledAt,
    this.examScheduledLabel,
    this.registrationClosesAt,
    this.registrationClosesLabel,
    this.courseNumber,
    this.reason,
    this.message,
  });

  final bool eligible;
  final ExamType? examType;
  final int? fee;
  final DateTime? examScheduledAt;
  final String? examScheduledLabel;
  final DateTime? registrationClosesAt;
  final String? registrationClosesLabel;
  final int? courseNumber;
  final String? reason;
  final String? message;

  bool get isRegistrationOpen {
    final closesAt = registrationClosesAt;
    if (closesAt == null) return eligible;
    return eligible && closesAt.toUtc().isAfter(DateTime.now().toUtc());
  }

  Duration remainingUntilRegistrationCloses() {
    final closesAt = registrationClosesAt;
    if (closesAt == null) return Duration.zero;
    final remaining = closesAt.toUtc().difference(DateTime.now().toUtc());
    return remaining.isNegative ? Duration.zero : remaining;
  }

  @override
  List<Object?> get props => [
    eligible,
    examType,
    fee,
    examScheduledAt,
    examScheduledLabel,
    registrationClosesAt,
    registrationClosesLabel,
    courseNumber,
    reason,
    message,
  ];
}

class CertificateEligibilityEntity extends Equatable {
  const CertificateEligibilityEntity({
    required this.canSubmitNewRequest,
    required this.newRequest,
    required this.reexam,
    this.activeCertificateId,
    this.requestStatus,
    this.courseNumber,
  });

  final bool canSubmitNewRequest;
  final String? activeCertificateId;
  final CertificateRequestStatus? requestStatus;
  final int? courseNumber;
  final CertificateNewRequestEligibility newRequest;
  final CertificateReexamEligibility reexam;

  bool get hasActiveCertificate =>
      activeCertificateId != null && activeCertificateId!.isNotEmpty;

  @override
  List<Object?> get props => [
    canSubmitNewRequest,
    activeCertificateId,
    requestStatus,
    courseNumber,
    newRequest,
    reexam,
  ];
}
