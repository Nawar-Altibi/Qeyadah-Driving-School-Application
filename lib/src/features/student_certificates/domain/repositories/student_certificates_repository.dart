import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/certificate_eligibility_entity.dart';

abstract interface class StudentCertificatesRepository {
  FutureEither<CertificateEligibilityEntity> getEligibility();
}
