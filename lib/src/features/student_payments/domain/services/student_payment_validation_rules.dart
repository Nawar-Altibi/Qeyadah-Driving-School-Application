import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qeyadah_mobile_app/src/shared/payments/sham_cash_validation_rules.dart';

abstract final class StudentPaymentConstants {
  static const int transactionIdLength = ShamCashConstants.transactionIdLength;
  static final RegExp transactionIdPattern =
      ShamCashConstants.transactionIdPattern;
}

abstract final class StudentPaymentValidationRules {
  static Either<Failure, String> validateTransactionId(String raw) {
    return ShamCashValidationRules.validateTransactionId(raw);
  }
}

abstract final class StudentPaymentValidationKeys {
  static const invalidTransactionId =
      ShamCashValidationKeys.invalidTransactionId;
}
