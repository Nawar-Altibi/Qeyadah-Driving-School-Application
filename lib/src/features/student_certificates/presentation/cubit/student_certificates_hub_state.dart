import 'package:coore/lib.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/certificate_eligibility_entity.dart';

class StudentCertificatesHubState {
  const StudentCertificatesHubState({
    this.apiState = const ApiState<CertificateEligibilityEntity>.initial(),
    this.isRefreshing = false,
    this.reexamRemaining = Duration.zero,
    this.reexamRegistrationExpired = false,
  });

  final ApiState<CertificateEligibilityEntity> apiState;
  final bool isRefreshing;
  final Duration reexamRemaining;
  final bool reexamRegistrationExpired;

  StudentCertificatesHubState copyWith({
    ApiState<CertificateEligibilityEntity>? apiState,
    bool? isRefreshing,
    Duration? reexamRemaining,
    bool? reexamRegistrationExpired,
  }) {
    return StudentCertificatesHubState(
      apiState: apiState ?? this.apiState,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      reexamRemaining: reexamRemaining ?? this.reexamRemaining,
      reexamRegistrationExpired:
          reexamRegistrationExpired ?? this.reexamRegistrationExpired,
    );
  }
}
