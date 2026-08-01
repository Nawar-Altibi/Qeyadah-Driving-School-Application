import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';

abstract final class StudentPaymentConstants {
  static const int transactionIdLength = 9;
  static final RegExp transactionIdPattern = RegExp(r'^\d{9}$');
}

abstract final class StudentPaymentValidationRules {
  /// ShamCash transaction IDs are exactly 9 digits.
  static Either<Failure, String> validateTransactionId(String raw) {
    final transactionId = raw.trim();
    if (!StudentPaymentConstants.transactionIdPattern.hasMatch(transactionId)) {
      return left(
        const BusinessFailure(
          message: StudentPaymentValidationKeys.invalidTransactionId,
        ),
      );
    }
    return right(transactionId);
  }
}

abstract final class StudentPaymentValidationKeys {
  static const invalidTransactionId = 'student_payment.invalid_transaction_id';
}
