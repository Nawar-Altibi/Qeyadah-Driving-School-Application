import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/constants/endpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/data/parsers/certificate_json_parsers.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/certificate_eligibility_entity.dart';

abstract interface class StudentCertificatesRemoteDataSource {
  RemoteResponse<CertificateEligibilityEntity> fetchEligibility();
}

@LazySingleton(as: StudentCertificatesRemoteDataSource)
class StudentCertificatesRemoteDataSourceImpl
    implements StudentCertificatesRemoteDataSource {
  StudentCertificatesRemoteDataSourceImpl(this._apiHandler);

  final ApiHandlerInterface _apiHandler;

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
}
