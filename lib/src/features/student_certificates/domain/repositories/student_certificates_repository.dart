import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/certificate_eligibility_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/student_certificate_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/params/student_certificates_params.dart';

abstract interface class StudentCertificatesRepository {
  FutureEither<CertificateEligibilityEntity> getEligibility();

  FutureEither<StudentCertificatesPageEntity> getCertificates(
    LoadStudentCertificatesParams params,
  );

  FutureEither<StudentCertificateDetailEntity> getCertificateDetail(String id);
}
