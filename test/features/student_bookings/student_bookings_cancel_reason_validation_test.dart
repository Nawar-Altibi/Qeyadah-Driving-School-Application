import 'package:flutter_test/flutter_test.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/failures/student_bookings_failures.dart';

void main() {
  group('StudentBookingsCancelReasonRules.validateReason', () {
    test('accepts a single-character trimmed reason', () {
      final result = StudentBookingsCancelReasonRules.validateReason('a');
      expect(result.isRight(), isTrue);
      expect(result.fold((_) => null, (value) => value), 'a');
    });

    test('accepts a reason at exactly the 255 character limit', () {
      final reason = 'a' * 255;
      final result = StudentBookingsCancelReasonRules.validateReason(reason);
      expect(result.isRight(), isTrue);
    });

    test('trims surrounding whitespace before validating and returning', () {
      final result = StudentBookingsCancelReasonRules.validateReason(
        '  Schedule conflict  ',
      );
      expect(result.fold((_) => null, (value) => value), 'Schedule conflict');
    });

    test('rejects an empty reason', () {
      final result = StudentBookingsCancelReasonRules.validateReason('');
      expect(result.isLeft(), isTrue);
    });

    test('rejects a reason that is only whitespace', () {
      final result = StudentBookingsCancelReasonRules.validateReason('   ');
      expect(result.isLeft(), isTrue);
    });

    test('rejects a reason longer than 255 characters', () {
      final reason = 'a' * 256;
      final result = StudentBookingsCancelReasonRules.validateReason(reason);

      expect(result.isLeft(), isTrue);
      final failure = result.fold((failure) => failure, (_) => null);
      expect(failure, isA<BusinessFailure>());
      expect(
        (failure! as BusinessFailure).message,
        StudentBookingsValidationKeys.invalidCancellationReason,
      );
    });
  });
}
