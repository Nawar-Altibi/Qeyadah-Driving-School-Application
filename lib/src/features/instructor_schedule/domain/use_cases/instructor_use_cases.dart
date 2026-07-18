import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/repositories/instructor_repository.dart';

@injectable
class LoadInstructorScheduleUseCase {
  const LoadInstructorScheduleUseCase(this._repository);

  final InstructorRepository _repository;

  FutureEither<InstructorScheduleDashboardEntity> call(
    DateTime date,
    InstructorBookingsViewMode viewMode,
  ) {
    return _repository.loadScheduleDashboard(date, viewMode);
  }
}

@injectable
class LoadInstructorProfileUseCase {
  const LoadInstructorProfileUseCase(this._repository);

  final InstructorRepository _repository;

  FutureEither<InstructorProfileDashboardEntity> call() {
    return _repository.loadProfileDashboard();
  }
}

@injectable
class LoadInstructorLeavesUseCase {
  const LoadInstructorLeavesUseCase(this._repository);

  final InstructorRepository _repository;

  FutureEither<List<InstructorLeaveEntity>> call() {
    return _repository.getLeaves();
  }
}

@injectable
class LoadInstructorDayBookingsUseCase {
  const LoadInstructorDayBookingsUseCase(this._repository);

  final InstructorRepository _repository;

  FutureEither<List<InstructorBookingEntity>> call(DateTime date) {
    return _repository.getDayBookings(date);
  }
}
