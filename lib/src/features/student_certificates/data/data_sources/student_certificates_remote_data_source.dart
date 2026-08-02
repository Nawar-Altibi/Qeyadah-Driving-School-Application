import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/constants/endpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/data/parsers/certificate_json_parsers.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/certificate_eligibility_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/student_certificate_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/params/student_certificates_params.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/certificate_category.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/certificate_charge_reason.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/exam_result.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_charge_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';

abstract interface class StudentCertificatesRemoteDataSource {
  RemoteResponse<CertificateEligibilityEntity> fetchEligibility();

  RemoteResponse<StudentCertificatesPageEntity> fetchCertificates(
    LoadStudentCertificatesParams params,
  );

  RemoteResponse<StudentCertificateDetailEntity> fetchCertificateDetail(
    String id,
  );
}

@LazySingleton(as: StudentCertificatesRemoteDataSource)
class StudentCertificatesRemoteDataSourceImpl
    implements StudentCertificatesRemoteDataSource {
  StudentCertificatesRemoteDataSourceImpl(this._apiHandler);

  final ApiHandlerInterface _apiHandler;

  @override
  RemoteResponse<StudentCertificatesPageEntity> fetchCertificates(
    LoadStudentCertificatesParams params,
  ) async {
    final response = await _apiHandler.get(
      Endpoints.studentCertificates,
      queryParameters: {
        if (params.status != null) 'status': params.status!.apiValue,
        'page': params.page,
        'limit': params.limit,
      },
      isAuthorized: true,
    );
    return response.fold(left, (json) {
      try {
        return right(_pageFromJson(json));
      } on Exception {
        return left(
          const InternalServerErrorFailure(
            'Failed to parse certificates list response',
          ),
        );
      }
    });
  }

  @override
  RemoteResponse<StudentCertificateDetailEntity> fetchCertificateDetail(
    String id,
  ) async {
    final response = await _apiHandler.get(
      Endpoints.studentCertificateById(id),
      isAuthorized: true,
    );
    return response.fold(left, (json) {
      try {
        return right(_detailFromJson(json));
      } on Exception {
        return left(
          const InternalServerErrorFailure(
            'Failed to parse certificate detail response',
          ),
        );
      }
    });
  }

  @override
  RemoteResponse<CertificateEligibilityEntity> fetchEligibility() async {
    final response = await _apiHandler.get(
      Endpoints.studentCertificatesEligibility,
      isAuthorized: true,
    );
    return response.fold(left, (json) {
      try {
        return right(_eligibilityFromJson(json));
      } on Exception {
        return left(
          const InternalServerErrorFailure(
            'Failed to parse certificate eligibility response',
          ),
        );
      }
    });
  }

  CertificateEligibilityEntity _eligibilityFromJson(Map<String, dynamic> json) {
    final payload = CertificateJsonParsers.unwrapApiData(json);
    final newRequestJson = payload['newRequest'];
    final reexamJson = payload['reexam'];
    if (newRequestJson is! Map || reexamJson is! Map) {
      throw const FormatException('Invalid eligibility payload');
    }

    return CertificateEligibilityEntity(
      canSubmitNewRequest: payload['canSubmitNewRequest'] == true,
      activeCertificateId: CertificateJsonParsers.parseCertificateId(
        payload['activeCertificateId'],
      ),
      requestStatus: CertificateJsonParsers.parseRequestStatus(
        payload['requestStatus'],
      ),
      courseNumber: CertificateJsonParsers.parseCourseNumber(
        payload['courseNumber'],
      ),
      newRequest: _newRequestFromJson(
        Map<String, dynamic>.from(newRequestJson),
      ),
      reexam: _reexamFromJson(Map<String, dynamic>.from(reexamJson)),
    );
  }

  CertificateNewRequestEligibility _newRequestFromJson(
    Map<String, dynamic> json,
  ) {
    return CertificateNewRequestEligibility(
      allowed: json['allowed'] == true,
      availableTransmissionTypes: CertificateJsonParsers.parseTransmissionTypes(
        json['availableTransmissionTypes'],
      ),
      completedCategories: CertificateJsonParsers.parseCategories(
        json['completedCategories'],
      ),
      reason: json['reason']?.toString(),
      message: json['message']?.toString(),
    );
  }

  CertificateReexamEligibility _reexamFromJson(Map<String, dynamic> json) {
    return CertificateReexamEligibility(
      eligible: json['eligible'] == true,
      examType: CertificateJsonParsers.parseExamType(json['examType']),
      fee: json['fee'] == null
          ? null
          : CertificateJsonParsers.parseFee(json['fee']),
      examScheduledAt: CertificateJsonParsers.parseDateTime(
        json['examScheduledAt'],
      ),
      examScheduledLabel: json['examScheduledLabel']?.toString(),
      registrationClosesAt: CertificateJsonParsers.parseDateTime(
        json['registrationClosesAt'],
      ),
      registrationClosesLabel: json['registrationClosesLabel']?.toString(),
      courseNumber: CertificateJsonParsers.parseCourseNumber(
        json['courseNumber'],
      ),
      reason: json['reason']?.toString(),
      message: json['message']?.toString(),
    );
  }

  StudentCertificatesPageEntity _pageFromJson(Map<String, dynamic> json) {
    final payload = CertificateJsonParsers.unwrapApiData(json);
    final data = payload['data'];
    if (data is! Iterable) {
      throw const FormatException('Invalid certificates list response');
    }
    final meta = payload['meta'] is Map
        ? Map<String, dynamic>.from(payload['meta'] as Map)
        : const <String, dynamic>{};
    return StudentCertificatesPageEntity(
      items: data
          .map(
            (item) => _summaryFromJson(Map<String, dynamic>.from(item as Map)),
          )
          .toList(growable: false),
      total: CertificateJsonParsers.parseInt(meta['total']),
      page: CertificateJsonParsers.parseInt(meta['page'], fallback: 1),
      limit: CertificateJsonParsers.parseInt(
        meta['limit'],
        fallback: StudentCertificatesPagination.defaultLimit,
      ),
      totalPages: CertificateJsonParsers.parseInt(
        meta['totalPages'],
        fallback: 1,
      ),
    );
  }

  StudentCertificateListItemEntity _summaryFromJson(Map<String, dynamic> json) {
    final id = CertificateJsonParsers.parseCertificateId(json['id']);
    final status = CertificateJsonParsers.parseRequestStatus(
      json['requestStatus'],
    );
    if (id == null || status == null) {
      throw const FormatException('Invalid certificate summary');
    }
    return StudentCertificateListItemEntity(
      id: id,
      studentName: json['studentName']?.toString() ?? '',
      studentPhone: json['studentPhone']?.toString() ?? '',
      category: CertificateCategory.fromApi(json['category']?.toString()),
      transmissionType: TrainingType.fromApi(
        json['transmissionType']?.toString(),
      ),
      requestStatus: status,
      transportRequested: json['transportRequested'] == true,
      courseNumber: CertificateJsonParsers.parseCourseNumber(
        json['courseNumber'],
      ),
      governmentStudentNumber: json['governmentStudentNumber']?.toString(),
      requestedAt: CertificateJsonParsers.parseDateTime(json['requestedAt']),
      submittedToGovAt: CertificateJsonParsers.parseDateTime(
        json['submittedToGovAt'],
      ),
    );
  }

  StudentCertificateDetailEntity _detailFromJson(Map<String, dynamic> json) {
    final payload = CertificateJsonParsers.unwrapApiData(json);
    final certificateJson = payload['certificate'];
    final studentJson = payload['student'];
    if (certificateJson is! Map || studentJson is! Map) {
      throw const FormatException('Invalid certificate detail response');
    }

    final documentsJson = payload['documents'];
    final sessionsJson = payload['sessions'];
    final examsJson = payload['exams'];
    final chargesJson = payload['charges'];
    final actionsJson = payload['actions'];
    final exams = examsJson is Iterable
        ? examsJson
              .map(
                (item) => _examFromJson(Map<String, dynamic>.from(item as Map)),
              )
              .toList()
        : <StudentCertificateExamEntity>[];
    exams.sort(_compareExams);

    return StudentCertificateDetailEntity(
      certificate: _summaryFromJson(Map<String, dynamic>.from(certificateJson)),
      student: _studentFromJson(Map<String, dynamic>.from(studentJson)),
      documents: _documentsFromJson(
        documentsJson is Map
            ? Map<String, dynamic>.from(documentsJson)
            : const {},
      ),
      sessions: sessionsJson is Iterable
          ? sessionsJson
                .map(
                  (item) =>
                      _sessionFromJson(Map<String, dynamic>.from(item as Map)),
                )
                .toList(growable: false)
          : const [],
      exams: exams,
      charges: chargesJson is Iterable
          ? chargesJson
                .map(
                  (item) =>
                      _chargeFromJson(Map<String, dynamic>.from(item as Map)),
                )
                .toList(growable: false)
          : const [],
      actions: _actionsFromJson(
        actionsJson is Map ? Map<String, dynamic>.from(actionsJson) : const {},
      ),
    );
  }

  StudentCertificateStudentEntity _studentFromJson(Map<String, dynamic> json) {
    return StudentCertificateStudentEntity(
      id: CertificateJsonParsers.parseCertificateId(json['id']) ?? '',
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      studentStatus: json['studentStatus']?.toString(),
    );
  }

  StudentCertificateDocumentsEntity _documentsFromJson(
    Map<String, dynamic> json,
  ) {
    return StudentCertificateDocumentsEntity(
      personalPhotoUrl: CertificateJsonParsers.resolveDocumentUrl(
        json['personalPhotoUrl'],
      ),
      idFrontUrl: CertificateJsonParsers.resolveDocumentUrl(json['idFrontUrl']),
      idBackUrl: CertificateJsonParsers.resolveDocumentUrl(json['idBackUrl']),
    );
  }

  StudentCertificateSessionEntity _sessionFromJson(Map<String, dynamic> json) {
    return StudentCertificateSessionEntity(
      id: CertificateJsonParsers.parseCertificateId(json['id']) ?? '',
      sessionNumber: CertificateJsonParsers.parseInt(json['sessionNumber']),
      scheduledAt: CertificateJsonParsers.parseDateTime(json['scheduledAt']),
      label: json['label']?.toString() ?? '',
    );
  }

  StudentCertificateExamEntity _examFromJson(Map<String, dynamic> json) {
    final examType = CertificateJsonParsers.parseExamType(json['examType']);
    if (examType == null) {
      throw const FormatException('Invalid certificate exam type');
    }
    return StudentCertificateExamEntity(
      id: CertificateJsonParsers.parseCertificateId(json['id']) ?? '',
      examType: examType,
      attemptNumber: CertificateJsonParsers.parseInt(json['attemptNumber']),
      scheduledAt: CertificateJsonParsers.parseDateTime(json['scheduledAt']),
      examResult: ExamResult.fromApi(json['examResult']?.toString()),
      resultRecordedAt: CertificateJsonParsers.parseDateTime(
        json['resultRecordedAt'],
      ),
    );
  }

  int _compareExams(
    StudentCertificateExamEntity a,
    StudentCertificateExamEntity b,
  ) {
    final typeOrder = a.examType.index.compareTo(b.examType.index);
    if (typeOrder != 0) return typeOrder;
    final dateOrder = (a.scheduledAt ?? DateTime(9999)).compareTo(
      b.scheduledAt ?? DateTime(9999),
    );
    return dateOrder != 0
        ? dateOrder
        : a.attemptNumber.compareTo(b.attemptNumber);
  }

  StudentCertificateChargeEntity _chargeFromJson(Map<String, dynamic> json) {
    final paymentsJson = json['payments'];
    return StudentCertificateChargeEntity(
      id: CertificateJsonParsers.parseCertificateId(json['id']) ?? '',
      chargeReason: CertificateChargeReason.fromApi(
        json['chargeReason']?.toString(),
      ),
      amountDue: CertificateJsonParsers.parseMoneyString(json['amountDue']),
      chargeStatus:
          StudentChargeStatus.fromApi(json['chargeStatus']?.toString()) ??
          StudentChargeStatus.unpaid,
      payments: paymentsJson is Iterable
          ? paymentsJson
                .map(
                  (item) =>
                      _paymentFromJson(Map<String, dynamic>.from(item as Map)),
                )
                .toList(growable: false)
          : const [],
    );
  }

  StudentCertificateChargePaymentEntity _paymentFromJson(
    Map<String, dynamic> json,
  ) {
    return StudentCertificateChargePaymentEntity(
      id: CertificateJsonParsers.parseCertificateId(json['id']) ?? '',
      amountPaid: CertificateJsonParsers.parseMoneyString(json['amountPaid']),
      paymentMethod: json['paymentMethod']?.toString() ?? '',
      receivedAt: CertificateJsonParsers.parseDateTime(json['receivedAt']),
    );
  }

  StudentCertificateActionsEntity _actionsFromJson(Map<String, dynamic> json) {
    final reexamJson = json['reexam'];
    return StudentCertificateActionsEntity(
      reexam: _reexamFromJson(
        reexamJson is Map
            ? Map<String, dynamic>.from(reexamJson)
            : const <String, dynamic>{'eligible': false},
      ),
    );
  }
}
