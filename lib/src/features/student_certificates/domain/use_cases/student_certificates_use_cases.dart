import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/certificate_eligibility_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/repositories/student_certificates_repository.dart';

@injectable
class LoadCertificateEligibilityUseCase {
  const LoadCertificateEligibilityUseCase(this._repository);

  final StudentCertificatesRepository _repository;

  FutureEither<CertificateEligibilityEntity> call() {
    return _repository.getEligibility();
  }
}
