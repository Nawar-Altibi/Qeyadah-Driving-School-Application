import 'package:flutter_test/flutter_test.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';
import 'package:qeyadah_mobile_app/src/shared/payments/sham_cash_validation_rules.dart';

void main() {
  group('ShamCashValidationRules.validateTransactionId', () {
    test('accepts exactly 9 digits', () {
      final result = ShamCashValidationRules.validateTransactionId('123456789');

      expect(result.isRight(), isTrue);
      expect(result.fold((_) => null, (value) => value), '123456789');
    });

    test('trims surrounding whitespace before validating', () {
      final result = ShamCashValidationRules.validateTransactionId(
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
        final result = ShamCashValidationRules.validateTransactionId(invalid);

        expect(result.isLeft(), isTrue);
        final failure = result.fold((failure) => failure, (_) => null);
        expect(failure, isA<BusinessFailure>());
        expect(
          (failure! as BusinessFailure).message,
          ShamCashValidationKeys.invalidTransactionId,
        );
      });
    }
  });

  group('ShamCashConstants', () {
    test('transactionIdPattern matches the 9-digit contract', () {
      expect(
        ShamCashConstants.transactionIdPattern.hasMatch('123456789'),
        isTrue,
      );
      expect(
        ShamCashConstants.transactionIdPattern.hasMatch('1234567890'),
        isFalse,
      );
      expect(ShamCashConstants.transactionIdLength, 9);
    });
  });
}
