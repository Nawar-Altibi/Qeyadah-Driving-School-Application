import 'package:coore/lib.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/services/student_certificate_write_validation_rules.dart';
import 'package:qeyadah_mobile_app/src/shared/payments/sham_cash_validation_rules.dart';

abstract final class StudentCertificateWriteFailureMapper {
  static String messageFor(Failure failure, AppLocalizations l10n) {
    return switch (failure.message) {
      StudentCertificateWriteValidationKeys.invalidImage =>
        l10n.studentCertificatesInvalidImage,
      StudentCertificateWriteValidationKeys.imageTooLarge =>
        l10n.studentCertificatesImageTooLarge,
      ShamCashValidationKeys.invalidTransactionId =>
        l10n.studentPaymentInvalidTransactionId,
      _ => CoreFailureMessageMapper.messageFor(failure, l10n),
    };
  }
}
