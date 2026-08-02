import 'package:coore/lib.dart';
import 'package:fpdart/fpdart.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/app_failures.dart';

abstract final class StudentBookingsCancelReasonRules {
  static const int minLength = 1;
  static const int maxLength = 255;

  /// The backend requires a 1-255 character cancellation reason. Validated
  /// client-side first so the student gets instant feedback.
  static Either<Failure, String> validateReason(String raw) {
    final reason = raw.trim();
    if (reason.length < minLength || reason.length > maxLength) {
      return left(
        const BusinessFailure(
          message: StudentBookingsValidationKeys.invalidCancellationReason,
        ),
      );
    }
    return right(reason);
  }
}

abstract final class StudentBookingsValidationKeys {
  static const invalidCancellationReason =
      'student_bookings.invalid_cancellation_reason';
}
