import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/cache/app_ttl_cache.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/network_failure_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/data/data_sources/student_certificates_remote_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/certificate_eligibility_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/student_certificate_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/failures/student_certificate_failures.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/params/student_certificates_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/repositories/student_certificates_repository.dart';

@LazySingleton(as: StudentCertificatesRepository)
class StudentCertificatesRepositoryImpl
    implements StudentCertificatesRepository {
  StudentCertificatesRepositoryImpl(this._remoteDataSource);

  final StudentCertificatesRemoteDataSource _remoteDataSource;

  static const _eligibilityKey = 'eligibility';
  final _eligibilityCache = AppTtlCache<CertificateEligibilityEntity>(
    ttl: const Duration(minutes: 3),
  );

  @override
  FutureEither<void> submitCertificate(
    SubmitStudentCertificateParams params,
  ) async {
    final response = await _remoteDataSource.submitCertificate(params);
    return response.fold(
      (failure) => left(
        failure is ConflictFailure
            ? ActiveCertificateConflictFailure(message: failure.message)
            : NetworkFailureMapper.toDomainFailure(failure),
      ),
      (value) {
        _eligibilityCache.invalidate(_eligibilityKey);
        return right(value);
      },
    );
  }

  @override
  FutureEither<void> submitReexam(
    SubmitStudentCertificateReexamParams params,
  ) async {
    final response = await _remoteDataSource.submitReexam(params);
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      (value) {
        _eligibilityCache.invalidate(_eligibilityKey);
        return right(value);
      },
    );
  }

  @override
  FutureEither<StudentCertificatesPageEntity> getCertificates(
    LoadStudentCertificatesParams params,
  ) async {
    final response = await _remoteDataSource.fetchCertificates(params);
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      right,
    );
  }

  @override
  FutureEither<StudentCertificateDetailEntity> getCertificateDetail(
    String id,
  ) async {
    final response = await _remoteDataSource.fetchCertificateDetail(id);
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      right,
    );
  }

  @override
  FutureEither<CertificateEligibilityEntity> getEligibility({
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cached = _eligibilityCache.getFresh(_eligibilityKey);
      if (cached != null) return right(cached);
    }

    final response = await _remoteDataSource.fetchEligibility();
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      (eligibility) {
        _eligibilityCache.set(_eligibilityKey, eligibility);
        return right(eligibility);
      },
    );
  }
}
