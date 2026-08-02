import 'dart:io';

import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';

abstract final class StudentCertificateWriteConstants {
  static const int maxImageBytes = 5 * 1024 * 1024;
  static const allowedImageExtensions = {'jpg', 'jpeg', 'png', 'webp'};
}

abstract final class StudentCertificateWriteValidationKeys {
  static const invalidImage = 'student_certificates.invalid_image';
  static const imageTooLarge = 'student_certificates.image_too_large';
}

abstract final class StudentCertificateWriteValidationRules {
  static Either<Failure, File> validateImage(File file) {
    final name = file.path.split(RegExp(r'[/\\]')).last;
    final dot = name.lastIndexOf('.');
    final extension = dot < 0 ? '' : name.substring(dot + 1).toLowerCase();
    if (!StudentCertificateWriteConstants.allowedImageExtensions.contains(
      extension,
    )) {
      return left(
        const BusinessFailure(
          message: StudentCertificateWriteValidationKeys.invalidImage,
        ),
      );
    }
    if (file.lengthSync() > StudentCertificateWriteConstants.maxImageBytes) {
      return left(
        const BusinessFailure(
          message: StudentCertificateWriteValidationKeys.imageTooLarge,
        ),
      );
    }
    return right(file);
  }
}
