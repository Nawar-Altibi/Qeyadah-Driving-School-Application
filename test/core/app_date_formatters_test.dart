import 'package:flutter_test/flutter_test.dart';
import 'package:qeyadah_mobile_app/src/core/formatters/app_date_formatters.dart';

void main() {
  group('AppDateFormatters.countdownHms', () {
    test('omits days under 24 hours and uses unit labels', () {
      expect(
        AppDateFormatters.countdownHms(
          const Duration(hours: 16, minutes: 30, seconds: 23),
          daysUnit: 'يوم',
          hoursUnit: 'س',
          minutesUnit: 'د',
          secondsUnit: 'ث',
        ),
        '16 س · 30 د · 23 ث',
      );
    });

    test('splits durations over 24 hours into days', () {
      expect(
        AppDateFormatters.countdownHms(
          const Duration(hours: 328, minutes: 30, seconds: 23),
          daysUnit: 'يوم',
          hoursUnit: 'س',
          minutesUnit: 'د',
          secondsUnit: 'ث',
        ),
        '13 يوم · 16 س · 30 د · 23 ث',
      );
    });

    test('clamps negative remaining time to zero', () {
      expect(
        AppDateFormatters.countdownHms(
          const Duration(seconds: -12),
          hoursUnit: 'س',
          minutesUnit: 'د',
          secondsUnit: 'ث',
        ),
        '00 س · 00 د · 00 ث',
      );
    });
  });
}
