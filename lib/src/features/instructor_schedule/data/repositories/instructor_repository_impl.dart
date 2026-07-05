import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:qeyadah_mobile_app/src/core/error_handling/network_failure_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/data/data_sources/instructor_remote_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/repositories/instructor_repository.dart';

@LazySingleton(as: InstructorRepository)
class InstructorRepositoryImpl implements InstructorRepository {
  InstructorRepositoryImpl(this._remoteDataSource);

  final InstructorRemoteDataSource _remoteDataSource;

  @override
  FutureEither<InstructorProfileEntity> getProfile() async {
    final response = await _remoteDataSource.fetchProfile();
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      right,
    );
  }

  @override
  FutureEither<List<InstructorScheduleDayEntity>> getWeeklySchedule() async {
    final response = await _remoteDataSource.fetchWeeklySchedule();
    return response.fold(
      (failure) => left(NetworkFailureMapper.toDomainFailure(failure)),
      right,
    );
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
  FutureEither<InstructorScheduleDashboardEntity> loadScheduleDashboard(
    DateTime selectedDate,
  ) async {
    final profileResult = await getProfile();
    return profileResult.fold(left, (profile) async {
      final scheduleResult = await getWeeklySchedule();
      return scheduleResult.fold(left, (weeklySchedule) async {
        final bookingsResult = await getDayBookings(selectedDate);
        return bookingsResult.fold(
          left,
          (bookings) => right(
            InstructorScheduleDashboardEntity(
              profile: profile,
              selectedDate: selectedDate,
              bookings: bookings,
              weeklySchedule: weeklySchedule,
            ),
          ),
        );
      });
    });
  }

  @override
  FutureEither<InstructorProfileDashboardEntity> loadProfileDashboard() async {
    final profileResult = await getProfile();
    return profileResult.fold(left, (profile) async {
      final scheduleResult = await getWeeklySchedule();
      return scheduleResult.fold(left, (weeklySchedule) async {
        final duesResult = await getDues();
        return duesResult.fold(left, (dues) async {
          final month = DateFormat('yyyy-MM').format(DateTime.now());
          final earningsResult = await getEarningsForMonth(month);
          return earningsResult.fold(left, (monthEarnings) async {
            final leavesResult = await getLeaves();
            return leavesResult.fold(
              left,
              (leaves) => right(
                InstructorProfileDashboardEntity(
                  profile: profile,
                  weeklySchedule: weeklySchedule,
                  dues: dues,
                  monthEarnings: monthEarnings,
                  leaves: leaves,
                ),
              ),
            );
          });
        });
      });
    });
  }
}
