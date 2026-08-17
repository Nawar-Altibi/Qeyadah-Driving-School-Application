import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';

void main() {
  group('CoreFailureMessageMapper ForbiddenFailure', () {
    late AppLocalizations l10n;

    setUp(() async {
      l10n = await AppLocalizations.delegate.load(const Locale('en'));
    });

    test('returns the server message when present', () {
      const message =
          'لا يمكنك حجز الدروس، يجب أن تتواصل مع الإدارة لرفع الحظر';
      final result = CoreFailureMessageMapper.messageFor(
        const ForbiddenFailure(message),
        l10n,
      );

      expect(result, message);
    });

    test('falls back to localized forbidden text when message is empty', () {
      final result = CoreFailureMessageMapper.messageFor(
        const ForbiddenFailure(''),
        l10n,
      );

      expect(result, l10n.errorForbidden);
    });
  });

  group('CoreFailureMessageMapper service errors', () {
    late AppLocalizations l10n;

    setUp(() async {
      l10n = await AppLocalizations.delegate.load(const Locale('en'));
    });

    test('shows the backend OTP delivery message for 503', () {
      const message = 'تعذر إرسال رمز التحقق، يرجى المحاولة مرة أخرى';
      final result = CoreFailureMessageMapper.messageFor(
        const ServiceUnavailableFailure(message),
        l10n,
      );

      expect(result, message);
    });

    test('falls back to localized server error for generic 5xx copy', () {
      final result = CoreFailureMessageMapper.messageFor(
        const InternalServerErrorFailure('Error, please try again later'),
        l10n,
      );

      expect(result, l10n.errorServer);
    });
  });
}
