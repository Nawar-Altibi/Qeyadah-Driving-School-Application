import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/params/student_bookings_params.dart';

abstract interface class StudentBookingsRepository {
  FutureEither<StudentBookingsPageEntity> getBookings(
    LoadStudentBookingsParams params,
  );

  FutureEither<StudentBookingDetailEntity> getBookingDetail(int bookingId);

  FutureEither<void> cancelBooking(CancelStudentBookingParams params);
}
