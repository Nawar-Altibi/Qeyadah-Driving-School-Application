import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/services/student_certificate_write_validation_rules.dart';
import 'package:qeyadah_mobile_app/src/shared/payments/sham_cash_validation_rules.dart';

void main() {
  test('ShamCash validation preserves a leading zero', () {
    final result = ShamCashValidationRules.validateTransactionId('012345678');
    expect(result.fold((_) => null, (value) => value), '012345678');
  });

  test('ShamCash validation rejects non-nine-digit values', () {
    final result = ShamCashValidationRules.validateTransactionId('12345678');
    expect(
      result.fold((failure) => failure, (_) => null),
      isA<BusinessFailure>(),
    );
  });

  test('image validation accepts supported image extensions under 5MB', () {
    final file = File(
      '${Directory.systemTemp.path}/certificate-valid-${DateTime.now().microsecondsSinceEpoch}.webp',
    )..writeAsBytesSync([1, 2, 3]);
    addTearDown(file.deleteSync);

    expect(
      StudentCertificateWriteValidationRules.validateImage(file).isRight(),
      isTrue,
    );
  });

  test('image validation rejects unsupported extensions', () {
    final file = File(
      '${Directory.systemTemp.path}/certificate-invalid-${DateTime.now().microsecondsSinceEpoch}.gif',
    )..writeAsBytesSync([1]);
    addTearDown(file.deleteSync);

    final failure = StudentCertificateWriteValidationRules.validateImage(
      file,
    ).fold((value) => value, (_) => null);
    expect(
      (failure as BusinessFailure).message,
      StudentCertificateWriteValidationKeys.invalidImage,
    );
  });
}
