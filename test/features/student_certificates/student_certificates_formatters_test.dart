import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/formatters/student_certificates_formatters.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('ar');
  });

  test('formats school wall-clock date and time separately', () {
    final utc = DateTime.utc(2026, 8, 18, 19, 22);

    expect(StudentCertificatesFormatters.time(utc, localeName: 'ar'), '22:22');
    expect(
      StudentCertificatesFormatters.weekdayDate(utc, localeName: 'ar'),
      'الثلاثاء، 18 أغسطس 2026',
    );
    expect(
      StudentCertificatesFormatters.dateTime(utc, localeName: 'ar'),
      'الثلاثاء، 18 أغسطس 2026 · 22:22',
    );
  });
}
