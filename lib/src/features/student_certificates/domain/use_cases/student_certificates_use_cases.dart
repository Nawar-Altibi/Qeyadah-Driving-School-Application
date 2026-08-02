import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/certificate_eligibility_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/student_certificate_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/params/student_certificates_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/repositories/student_certificates_repository.dart';

@injectable
class LoadCertificateEligibilityUseCase {
  const LoadCertificateEligibilityUseCase(this._repository);

  final StudentCertificatesRepository _repository;

  FutureEither<CertificateEligibilityEntity> call() {
    return _repository.getEligibility();
  }
}

@injectable
class LoadStudentCertificatesUseCase {
  const LoadStudentCertificatesUseCase(this._repository);

  final StudentCertificatesRepository _repository;

  FutureEither<StudentCertificatesPageEntity> call(
    LoadStudentCertificatesParams params,
  ) {
    return _repository.getCertificates(params);
  }
}

@injectable
class LoadStudentCertificateDetailUseCase {
  const LoadStudentCertificateDetailUseCase(this._repository);

  final StudentCertificatesRepository _repository;

  FutureEither<StudentCertificateDetailEntity> call(String id) {
    return _repository.getCertificateDetail(id);
  }
}

@injectable
class SubmitStudentCertificateUseCase {
  const SubmitStudentCertificateUseCase(this._repository);

  final StudentCertificatesRepository _repository;

  FutureEither<void> call(SubmitStudentCertificateParams params) {
    return _repository.submitCertificate(params);
  }
}

@injectable
class SubmitStudentCertificateReexamUseCase {
  const SubmitStudentCertificateReexamUseCase(this._repository);

  final StudentCertificatesRepository _repository;

  FutureEither<void> call(SubmitStudentCertificateReexamParams params) {
    return _repository.submitReexam(params);
  }
}
