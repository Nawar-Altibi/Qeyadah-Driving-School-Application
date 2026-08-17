import 'package:coore/lib.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';

abstract final class CoreFailureMessageMapper {
  static String messageFor(Failure failure, AppLocalizations l10n) {
    return switch (failure) {
      NoInternetConnectionFailure() => l10n.errorNoInternet,
      UnauthorizedRequestFailure(:final message) ||
      AuthFailure(
        :final message,
      ) => message.isNotEmpty ? message : l10n.errorUnauthorized,
      ForbiddenFailure(:final message) =>
        message.isNotEmpty ? message : l10n.errorForbidden,
      ValidationFailure() => l10n.errorValidation,
      NotFoundFailure() => l10n.errorNotFound,
      RequestTimeoutFailure() => l10n.errorRequestTimeout,
      FormatFailure() => l10n.errorFormat,
      CacheFailure() => l10n.errorGeneric,
      BusinessFailure(:final message) =>
        message.isNotEmpty ? message : l10n.errorGeneric,
      InternalServerErrorFailure(:final message) ||
      BadGatewayFailure(:final message) ||
      ServiceUnavailableFailure(:final message) ||
      GatewayTimeoutFailure(
        :final message,
      ) => _usableServerMessage(message) ?? l10n.errorServer,
      _ => l10n.errorGeneric,
    };
  }

  static String? _usableServerMessage(String message) {
    final trimmed = message.trim();
    if (trimmed.isEmpty) return null;
    final normalized = trimmed.replaceAll('\u00a0', ' ').toLowerCase();
    if (normalized == 'error, please try again later' ||
        normalized == 'internal server error') {
      return null;
    }
    return trimmed;
  }
}
