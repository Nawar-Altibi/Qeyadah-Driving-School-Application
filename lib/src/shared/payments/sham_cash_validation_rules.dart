import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';

abstract final class ShamCashConstants {
  static const int transactionIdLength = 9;
  static final RegExp transactionIdPattern = RegExp(r'^\d{9}$');
}

abstract final class ShamCashValidationRules {
  static Either<Failure, String> validateTransactionId(String raw) {
    final transactionId = raw.trim();
    if (!ShamCashConstants.transactionIdPattern.hasMatch(transactionId)) {
      return left(
        const BusinessFailure(
          message: ShamCashValidationKeys.invalidTransactionId,
        ),
      );
    }
    return right(transactionId);
  }
}

abstract final class ShamCashValidationKeys {
  static const invalidTransactionId = 'student_payment.invalid_transaction_id';
}
