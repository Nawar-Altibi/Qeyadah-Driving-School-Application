import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/entities/student_booking_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/params/student_booking_params.dart';

abstract interface class StudentBookingRepository {
  FutureEither<StudentAvailableSlotsPageEntity> getAvailableSlots(
    LoadAvailableSlotsParams params,
  );

  FutureEither<StudentBookingHoldEntity> createBooking(
    CreateStudentBookingParams params,
  );

  /// Reads the locally cached pending booking hold, if any (e.g. to resume
  /// an interrupted ShamCash payment after the app was restarted).
  FutureEither<StudentBookingHoldEntity?> getPendingHold();

  /// Clears the locally cached hold once payment is confirmed or expires.
  FutureEither<void> clearPendingHold();
}
