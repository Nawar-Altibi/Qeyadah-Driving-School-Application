import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/entities/student_booking_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/params/student_booking_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/repositories/student_booking_repository.dart';

@injectable
class LoadStudentAvailableSlotsUseCase {
  const LoadStudentAvailableSlotsUseCase(this._repository);

  final StudentBookingRepository _repository;

  FutureEither<StudentAvailableSlotsPageEntity> call(
    LoadAvailableSlotsParams params,
  ) {
    return _repository.getAvailableSlots(params);
  }
}

@injectable
class CreateStudentBookingUseCase {
  const CreateStudentBookingUseCase(this._repository);

  final StudentBookingRepository _repository;

  FutureEither<StudentBookingHoldEntity> call(
    CreateStudentBookingParams params,
  ) {
    return _repository.createBooking(params);
  }
}

@injectable
class GetStudentBookingCreditUseCase {
  const GetStudentBookingCreditUseCase(this._repository);

  final StudentBookingRepository _repository;

  FutureEither<StudentBookingCreditEntity> call() {
    return _repository.getMyCredit();
  }
}

@injectable
class GetPendingStudentBookingHoldUseCase {
  const GetPendingStudentBookingHoldUseCase(this._repository);

  final StudentBookingRepository _repository;

  FutureEither<StudentBookingHoldEntity?> call() {
    return _repository.getPendingHold();
  }
}
