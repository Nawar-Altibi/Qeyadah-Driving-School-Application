import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/certificate_request_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';

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

class SubmitStudentCertificateParams extends Equatable {
  const SubmitStudentCertificateParams({
    required this.transmissionType,
    required this.transportRequested,
    required this.transactionId,
    required this.personalPhoto,
    required this.idFront,
    required this.idBack,
  });

  final TrainingType transmissionType;
  final bool transportRequested;
  final String transactionId;
  final File personalPhoto;
  final File idFront;
  final File idBack;

  @override
  List<Object?> get props => [
    transmissionType,
    transportRequested,
    transactionId,
    personalPhoto.path,
    idFront.path,
    idBack.path,
  ];
}

class SubmitStudentCertificateReexamParams extends Equatable {
  const SubmitStudentCertificateReexamParams({
    required this.certificateId,
    required this.transactionId,
  });

  final String certificateId;
  final String transactionId;

  @override
  List<Object?> get props => [certificateId, transactionId];
}
