import 'package:coore/lib.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/domain/services/student_payment_validation_rules.dart';

abstract final class StudentPaymentFailureMessageMapper {
  static String messageFor(Failure failure, AppLocalizations l10n) {
    if (failure is BusinessFailure) {
      return switch (failure.message) {
        StudentPaymentValidationKeys.invalidTransactionId =>
          l10n.studentPaymentInvalidTransactionId,
        _ => failure.message.isEmpty ? l10n.errorGeneric : failure.message,
      };
    }
    return CoreFailureMessageMapper.messageFor(failure, l10n);
  }
}
