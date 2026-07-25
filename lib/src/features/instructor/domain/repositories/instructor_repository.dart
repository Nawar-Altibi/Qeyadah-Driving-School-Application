import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';

abstract interface class InstructorRepository {
  FutureEither<InstructorProfileEntity> getProfile({bool forceRefresh = false});
  FutureEither<List<InstructorScheduleDayEntity>> getWeeklySchedule({
    bool forceRefresh = false,
  });
  FutureEither<void> invalidateWeeklyScheduleCache();
  FutureEither<List<InstructorBookingEntity>> getDayBookings(DateTime date);
  FutureEither<List<InstructorBookingEntity>> getWeekBookings(
    DateTime weekStart,
  );
  FutureEither<List<InstructorLeaveEntity>> getLeaves();
  FutureEither<InstructorDuesEntity> getDues();
  FutureEither<InstructorEarningsEntity> getEarningsForDate(DateTime date);
  FutureEither<InstructorEarningsEntity> getEarningsForMonth(String month);
  FutureEither<InstructorInvoicesPageEntity> getInvoices({
    DateTime? date,
    String? month,
    int page = 1,
    int limit = 20,
  });
  FutureEither<InstructorNotificationsPageEntity> getNotifications({
    int page = 1,
    int limit = 20,
  });
  FutureEither<InstructorScheduleDashboardEntity> loadScheduleDashboard(
    DateTime selectedDate,
    InstructorBookingsViewMode viewMode,
  );
  FutureEither<InstructorProfileDashboardEntity> loadProfileDashboard({
    bool forceRefresh = false,
  });
}
