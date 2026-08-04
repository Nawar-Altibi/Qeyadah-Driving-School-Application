import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/repositories/instructor_repository.dart';

@injectable
class LoadInstructorScheduleUseCase {
  const LoadInstructorScheduleUseCase(this._repository);

  final InstructorRepository _repository;

  FutureEither<InstructorScheduleDashboardEntity> call(
    DateTime date,
    InstructorBookingsViewMode viewMode, {
    bool forceRefresh = false,
  }) {
    return _repository.loadScheduleDashboard(
      date,
      viewMode,
      forceRefresh: forceRefresh,
    );
  }
}

@injectable
class LoadInstructorProfileUseCase {
  const LoadInstructorProfileUseCase(this._repository);

  final InstructorRepository _repository;

  FutureEither<InstructorProfileDashboardEntity> call({
    bool forceRefresh = false,
  }) {
    return _repository.loadProfileDashboard(forceRefresh: forceRefresh);
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
class LoadInstructorWeeklyScheduleUseCase {
  const LoadInstructorWeeklyScheduleUseCase(this._repository);

  final InstructorRepository _repository;

  FutureEither<List<InstructorScheduleDayEntity>> call({
    bool forceRefresh = false,
  }) {
    return _repository.getWeeklySchedule(forceRefresh: forceRefresh);
  }
}

@injectable
class InvalidateInstructorWeeklyScheduleCacheUseCase {
  const InvalidateInstructorWeeklyScheduleCacheUseCase(this._repository);

  final InstructorRepository _repository;

  FutureEither<void> call() {
    return _repository.invalidateWeeklyScheduleCache();
  }
}

@injectable
class LoadInstructorDuesUseCase {
  const LoadInstructorDuesUseCase(this._repository);

  final InstructorRepository _repository;

  FutureEither<InstructorDuesEntity> call() {
    return _repository.getDues();
  }
}

@injectable
class LoadInstructorEarningsUseCase {
  const LoadInstructorEarningsUseCase(this._repository);

  final InstructorRepository _repository;

  FutureEither<InstructorEarningsEntity> forDate(DateTime date) {
    return _repository.getEarningsForDate(date);
  }

  FutureEither<InstructorEarningsEntity> forMonth(String month) {
    return _repository.getEarningsForMonth(month);
  }
}

@injectable
class LoadInstructorDayBookingsUseCase {
  const LoadInstructorDayBookingsUseCase(this._repository);

  final InstructorRepository _repository;

  FutureEither<List<InstructorBookingEntity>> call(
    DateTime date, {
    bool forceRefresh = false,
  }) {
    return _repository.getDayBookings(date, forceRefresh: forceRefresh);
  }
}

@injectable
class LoadInstructorInvoicesUseCase {
  const LoadInstructorInvoicesUseCase(this._repository);

  final InstructorRepository _repository;

  FutureEither<InstructorInvoicesPageEntity> forDate(
    DateTime date, {
    int page = 1,
    int limit = 20,
  }) {
    return _repository.getInvoices(date: date, page: page, limit: limit);
  }

  FutureEither<InstructorInvoicesPageEntity> forMonth(
    String month, {
    int page = 1,
    int limit = 20,
  }) {
    return _repository.getInvoices(month: month, page: page, limit: limit);
  }
}
