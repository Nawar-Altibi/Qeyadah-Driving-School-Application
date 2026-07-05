import 'package:coore/lib.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/services/auth_credentials_rules.dart';

abstract final class AuthFailureMessageMapper {
  static String messageFor(Failure failure, AppLocalizations l10n) {
    if (failure is BusinessFailure) {
      return switch (failure.message) {
        AuthValidationKeys.invalidPhoneLength => l10n.phoneValidationError,
        AuthValidationKeys.invalidPhoneFormat => l10n.phoneValidationError,
        AuthValidationKeys.invalidOtpLength => l10n.otpValidationError,
        AuthValidationKeys.invalidOtpFormat => l10n.otpValidationError,
        AuthValidationKeys.weakPassword => l10n.weakPasswordError,
        AuthValidationKeys.passwordMismatch => l10n.passwordMismatchError,
        AuthValidationKeys.nameRequired => l10n.nameRequiredError,
        AuthValidationKeys.nameTooLong => l10n.nameTooLongError,
        AuthValidationKeys.emailRequired => l10n.emailValidationError,
        AuthValidationKeys.invalidEmail => l10n.emailValidationError,
        _ => failure.message.isEmpty ? l10n.errorGeneric : failure.message,
      };
    }
    return CoreFailureMessageMapper.messageFor(failure, l10n);
  }
}
