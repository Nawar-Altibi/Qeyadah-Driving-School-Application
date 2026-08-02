import 'package:equatable/equatable.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/certificate_request_status.dart';

abstract final class StudentCertificatesPagination {
  static const int defaultLimit = 20;
  static const int maxLimit = 50;
}

class LoadStudentCertificatesParams extends Equatable {
  LoadStudentCertificatesParams({
    this.status,
    this.page = 1,
    int limit = StudentCertificatesPagination.defaultLimit,
  }) : limit = limit.clamp(1, StudentCertificatesPagination.maxLimit);

  final CertificateRequestStatus? status;
  final int page;
  final int limit;

  @override
  List<Object?> get props => [status, page, limit];
}
