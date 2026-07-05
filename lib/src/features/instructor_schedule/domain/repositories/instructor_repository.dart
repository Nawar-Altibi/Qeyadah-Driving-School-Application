import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';

abstract interface class InstructorRepository {
  FutureEither<InstructorProfileEntity> getProfile();
  FutureEither<List<InstructorScheduleDayEntity>> getWeeklySchedule();
  FutureEither<List<InstructorBookingEntity>> getDayBookings(DateTime date);
  FutureEither<List<InstructorLeaveEntity>> getLeaves();
  FutureEither<InstructorDuesEntity> getDues();
  FutureEither<InstructorEarningsEntity> getEarningsForDate(DateTime date);
  FutureEither<InstructorEarningsEntity> getEarningsForMonth(String month);
  FutureEither<InstructorScheduleDashboardEntity> loadScheduleDashboard(
    DateTime selectedDate,
  );
  FutureEither<InstructorProfileDashboardEntity> loadProfileDashboard();
}
