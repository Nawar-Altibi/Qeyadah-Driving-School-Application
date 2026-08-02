import 'package:equatable/equatable.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/certificate_eligibility_entity.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/certificate_category.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/certificate_charge_reason.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/certificate_request_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/exam_result.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/exam_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_charge_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';

class StudentCertificateListItemEntity extends Equatable {
  const StudentCertificateListItemEntity({
    required this.id,
    required this.studentName,
    required this.studentPhone,
    required this.requestStatus,
    required this.transportRequested,
    this.category,
    this.transmissionType,
    this.courseNumber,
    this.governmentStudentNumber,
    this.requestedAt,
    this.submittedToGovAt,
  });

  final String id;
  final String studentName;
  final String studentPhone;
  final CertificateCategory? category;
  final TrainingType? transmissionType;
  final CertificateRequestStatus requestStatus;
  final bool transportRequested;
  final int? courseNumber;
  final String? governmentStudentNumber;
  final DateTime? requestedAt;
  final DateTime? submittedToGovAt;

  @override
  List<Object?> get props => [
    id,
    studentName,
    studentPhone,
    category,
    transmissionType,
    requestStatus,
    transportRequested,
    courseNumber,
    governmentStudentNumber,
    requestedAt,
    submittedToGovAt,
  ];
}

class StudentCertificatesPageEntity extends Equatable {
  const StudentCertificatesPageEntity({
    required this.items,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  final List<StudentCertificateListItemEntity> items;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  bool get hasMorePages => page < totalPages;

  StudentCertificatesPageEntity appendPage(StudentCertificatesPageEntity next) {
    return StudentCertificatesPageEntity(
      items: [...items, ...next.items],
      total: next.total,
      page: next.page,
      limit: next.limit,
      totalPages: next.totalPages,
    );
  }

  @override
  List<Object?> get props => [items, total, page, limit, totalPages];
}

class StudentCertificateStudentEntity extends Equatable {
  const StudentCertificateStudentEntity({
    required this.id,
    required this.name,
    required this.phone,
    this.studentStatus,
  });

  final String id;
  final String name;
  final String phone;
  final String? studentStatus;

  @override
  List<Object?> get props => [id, name, phone, studentStatus];
}

class StudentCertificateDocumentsEntity extends Equatable {
  const StudentCertificateDocumentsEntity({
    this.personalPhotoUrl,
    this.idFrontUrl,
    this.idBackUrl,
  });

  final String? personalPhotoUrl;
  final String? idFrontUrl;
  final String? idBackUrl;

  @override
  List<Object?> get props => [personalPhotoUrl, idFrontUrl, idBackUrl];
}

class StudentCertificateSessionEntity extends Equatable {
  const StudentCertificateSessionEntity({
    required this.id,
    required this.sessionNumber,
    required this.label,
    this.scheduledAt,
  });

  final String id;
  final int sessionNumber;
  final DateTime? scheduledAt;
  final String label;

  @override
  List<Object?> get props => [id, sessionNumber, scheduledAt, label];
}

class StudentCertificateExamEntity extends Equatable {
  const StudentCertificateExamEntity({
    required this.id,
    required this.examType,
    required this.attemptNumber,
    this.scheduledAt,
    this.examResult,
    this.resultRecordedAt,
  });

  final String id;
  final ExamType examType;
  final int attemptNumber;
  final DateTime? scheduledAt;
  final ExamResult? examResult;
  final DateTime? resultRecordedAt;

  @override
  List<Object?> get props => [
    id,
    examType,
    attemptNumber,
    scheduledAt,
    examResult,
    resultRecordedAt,
  ];
}

class StudentCertificateChargePaymentEntity extends Equatable {
  const StudentCertificateChargePaymentEntity({
    required this.id,
    required this.amountPaid,
    required this.paymentMethod,
    this.receivedAt,
  });

  final String id;
  final String amountPaid;
  final String paymentMethod;
  final DateTime? receivedAt;

  @override
  List<Object?> get props => [id, amountPaid, paymentMethod, receivedAt];
}

class StudentCertificateChargeEntity extends Equatable {
  const StudentCertificateChargeEntity({
    required this.id,
    required this.amountDue,
    required this.chargeStatus,
    required this.payments,
    this.chargeReason,
  });

  final String id;
  final CertificateChargeReason? chargeReason;
  final String amountDue;
  final StudentChargeStatus chargeStatus;
  final List<StudentCertificateChargePaymentEntity> payments;

  @override
  List<Object?> get props => [
    id,
    chargeReason,
    amountDue,
    chargeStatus,
    payments,
  ];
}

class StudentCertificateActionsEntity extends Equatable {
  const StudentCertificateActionsEntity({required this.reexam});

  final CertificateReexamEligibility reexam;

  @override
  List<Object?> get props => [reexam];
}

class StudentCertificateDetailEntity extends Equatable {
  const StudentCertificateDetailEntity({
    required this.certificate,
    required this.student,
    required this.documents,
    required this.sessions,
    required this.exams,
    required this.charges,
    required this.actions,
  });

  final StudentCertificateListItemEntity certificate;
  final StudentCertificateStudentEntity student;
  final StudentCertificateDocumentsEntity documents;
  final List<StudentCertificateSessionEntity> sessions;
  final List<StudentCertificateExamEntity> exams;
  final List<StudentCertificateChargeEntity> charges;
  final StudentCertificateActionsEntity actions;

  @override
  List<Object?> get props => [
    certificate,
    student,
    documents,
    sessions,
    exams,
    charges,
    actions,
  ];
}
