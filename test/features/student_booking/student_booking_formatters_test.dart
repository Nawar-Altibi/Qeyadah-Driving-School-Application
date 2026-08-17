import 'package:flutter_test/flutter_test.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/formatters/student_booking_formatters.dart';

void main() {
  group('StudentBookingFormatters.dayPeriod', () {
    test('groups morning, afternoon, and evening by start hour', () {
      expect(
        StudentBookingFormatters.dayPeriod('08:00'),
        SlotDayPeriod.morning,
      );
      expect(
        StudentBookingFormatters.dayPeriod('11:50'),
        SlotDayPeriod.morning,
      );
      expect(
        StudentBookingFormatters.dayPeriod('12:00'),
        SlotDayPeriod.afternoon,
      );
      expect(
        StudentBookingFormatters.dayPeriod('16:59'),
        SlotDayPeriod.afternoon,
      );
      expect(
        StudentBookingFormatters.dayPeriod('17:00'),
        SlotDayPeriod.evening,
      );
    });
  });
}
