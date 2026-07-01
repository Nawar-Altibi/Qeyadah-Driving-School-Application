import 'package:coore/lib.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';

abstract final class SampleItemsFailureMessageMapper {
  static String messageFor(Failure failure, AppLocalizations l10n) {
    return switch (failure) {
      BusinessFailure(:final message) =>
        message != null && message.isNotEmpty ? message : l10n.errorGeneric,
      FormatFailure() => l10n.errorFormat,
      _ => l10n.errorGeneric,
    };
  }
}
