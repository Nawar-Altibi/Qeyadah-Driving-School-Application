import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/network_failure_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/data/data_sources/instructor_local_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/data/data_sources/instructor_remote_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/repositories/instructor_repository.dart';

@LazySingleton(as: InstructorRepository)
class InstructorRepositoryImpl implements InstructorRepository {
  InstructorRepositoryImpl(this._remoteDataSource, this._localDataSource);

  final InstructorRemoteDataSource _remoteDataSource;
  final InstructorLocalDataSource _localDataSource;

  @override
  FutureEither<InstructorProfileEntity> getProfile({
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cachedResult = await _localDataSource.readProfile();
      final fresh = cachedResult.fold((_) => null, (cached) {
        if (cached == null || !cached.isFresh) return null;
        return cached.profile;
      });
      if (fresh != null) return right(fresh);
    }

    final response = await _remoteDataSource.fetchProfile();
    return response.fold(
      (failure) async {
        final cachedResult = await _localDataSource.readProfile();
        return cachedResult.fold(
          (_) => left(NetworkFailureMapper.toDomainFailure(failure)),
          (cached) {
            if (cached != null) return right(cached.profile);
            return left(NetworkFailureMapper.toDomainFailure(failure));
          },
        );
      },
      (profile) async {
        await _localDataSource.saveProfile(profile);
        return right(profile);
      },
    );
  }

  @override
  FutureEither<List<InstructorScheduleDayEntity>> getWeeklySchedule({
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cachedResult = await _localDataSource.readWeeklySchedule();
      final fresh = cachedResult.fold((_) => null, (cached) {
        if (cached == null || !cached.isFresh) return null;
        return cached.schedule;
      });
      if (fresh != null) return right(fresh);
    }

    final response = await _remoteDataSource.fetchWeeklySchedule();
    return response.fold(
      (failure) async {
        final cachedResult = await _localDataSource.readWeeklySchedule();
        return cachedResult.fold(
          (_) => left(NetworkFailureMapper.toDomainFailure(failure)),
          (cached) {
            if (cached != null) return right(cached.schedule);
            return left(NetworkFailureMapper.toDomainFailure(failure));
          },
        );
      },
      (schedule) async {
        await _localDataSource.saveWeeklySchedule(schedule);
        return right(schedule);
      },
    );
  }

  @override
  FutureEither<void> invalidateWeeklyScheduleCache() {
    return _localDataSource.clearWeeklySchedule();
  }

  @override
  FutureEither<List<InstructorBookingEntity>> getDayBookings(
    DateTime date,
  ) async {
    final response = await _remoteDataSource.fetchDayBookings(date);
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      right,
    );
  }

  @override
  FutureEither<List<InstructorBookingEntity>> getWeekBookings(
    DateTime weekStart,
  ) async {
    final response = await _remoteDataSource.fetchWeekBookings(weekStart);
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      right,
    );
  }

  @override
  FutureEither<List<InstructorLeaveEntity>> getLeaves() async {
    final response = await _remoteDataSource.fetchLeaves();
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      right,
    );
  }

  @override
  FutureEither<InstructorDuesEntity> getDues() async {
    final response = await _remoteDataSource.fetchDues();
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      right,
    );
  }

  @override
  FutureEither<InstructorEarningsEntity> getEarningsForDate(
    DateTime date,
  ) async {
    final response = await _remoteDataSource.fetchEarningsForDate(date);
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      right,
    );
  }

  @override
  FutureEither<InstructorEarningsEntity> getEarningsForMonth(
    String month,
  ) async {
    final response = await _remoteDataSource.fetchEarningsForMonth(month);
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      right,
    );
  }

  @override
  FutureEither<InstructorInvoicesPageEntity> getInvoices({
    DateTime? date,
    String? month,
    int page = 1,
    int limit = 20,
  }) async {
    final response = await _remoteDataSource.fetchInvoices(
      date: date,
      month: month,
      page: page,
      limit: limit,
    );
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      right,
    );
  }

  @override
  FutureEither<InstructorScheduleDashboardEntity> loadScheduleDashboard(
    DateTime selectedDate,
    InstructorBookingsViewMode viewMode,
  ) async {
    final profileResult = await getProfile();
    return profileResult.fold(left, (profile) async {
      final scheduleResult = await getWeeklySchedule();
      return scheduleResult.fold(left, (weeklySchedule) async {
        final bookingsResult = await switch (viewMode) {
          InstructorBookingsViewMode.day => getDayBookings(selectedDate),
          InstructorBookingsViewMode.week => getWeekBookings(selectedDate),
        };
        return bookingsResult.fold(
          left,
          (bookings) => right(
            InstructorScheduleDashboardEntity(
              profile: profile,
              selectedDate: selectedDate,
              viewMode: viewMode,
              bookings: bookings,
              weeklySchedule: weeklySchedule,
            ),
          ),
        );
      });
    });
  }

  @override
  FutureEither<InstructorProfileDashboardEntity> loadProfileDashboard({
    bool forceRefresh = false,
  }) async {
    final profileResult = await getProfile(forceRefresh: forceRefresh);
    return profileResult.map(
      (profile) => InstructorProfileDashboardEntity(profile: profile),
    );
  }
}
