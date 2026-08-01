import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/params/student_bookings_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/repositories/student_bookings_repository.dart';

@injectable
class LoadStudentBookingsUseCase {
  const LoadStudentBookingsUseCase(this._repository);

  final StudentBookingsRepository _repository;

  FutureEither<StudentBookingsPageEntity> call(
    LoadStudentBookingsParams params,
  ) {
    return _repository.getBookings(params);
  }
}

@injectable
class LoadStudentBookingDetailUseCase {
  const LoadStudentBookingDetailUseCase(this._repository);

  final StudentBookingsRepository _repository;

  FutureEither<StudentBookingDetailEntity> call(int bookingId) {
    return _repository.getBookingDetail(bookingId);
  }
}

@injectable
class CancelStudentBookingUseCase {
  const CancelStudentBookingUseCase(this._repository);

  final StudentBookingsRepository _repository;

  FutureEither<void> call(CancelStudentBookingParams params) {
    return _repository.cancelBooking(params);
  }
}
