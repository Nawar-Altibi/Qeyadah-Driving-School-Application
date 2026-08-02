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
      InternalServerErrorFailure() ||
      BadGatewayFailure() ||
      ServiceUnavailableFailure() ||
      GatewayTimeoutFailure() => l10n.errorServer,
      _ => l10n.errorGeneric,
    };
  }
}
