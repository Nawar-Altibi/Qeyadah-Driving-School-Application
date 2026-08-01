import 'package:flutter_test/flutter_test.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/domain/services/student_payment_validation_rules.dart';

void main() {
  group('StudentPaymentValidationRules.validateTransactionId', () {
    test('accepts exactly 9 digits', () {
      final result = StudentPaymentValidationRules.validateTransactionId(
        '123456789',
      );

      expect(result.isRight(), isTrue);
      expect(result.fold((_) => null, (value) => value), '123456789');
    });

    test('trims surrounding whitespace before validating', () {
      final result = StudentPaymentValidationRules.validateTransactionId(
        '  123456789  ',
      );

      expect(result.fold((_) => null, (value) => value), '123456789');
    });

    for (final invalid in [
      '12345678',
      '1234567890',
      'abcdefghi',
      '',
      '12345678a',
    ]) {
      test('rejects "$invalid"', () {
        final result = StudentPaymentValidationRules.validateTransactionId(
          invalid,
        );

        expect(result.isLeft(), isTrue);
        final failure = result.fold((failure) => failure, (_) => null);
        expect(failure, isA<BusinessFailure>());
        expect(
          (failure! as BusinessFailure).message,
          StudentPaymentValidationKeys.invalidTransactionId,
        );
      });
    }
  });

  group('StudentPaymentConstants', () {
    test('transactionIdPattern matches the 9-digit contract', () {
      expect(
        StudentPaymentConstants.transactionIdPattern.hasMatch('123456789'),
        isTrue,
      );
      expect(
        StudentPaymentConstants.transactionIdPattern.hasMatch('1234567890'),
        isFalse,
      );
      expect(StudentPaymentConstants.transactionIdLength, 9);
    });
  });
}
