part of 'instructor_schedule_cubit.dart';

@freezed
abstract class InstructorScheduleState with _$InstructorScheduleState {
  const factory InstructorScheduleState({
    @Default(ApiState<InstructorScheduleDashboardEntity>.initial())
    ApiState<InstructorScheduleDashboardEntity> apiState,
    @Default(false) bool isSilentRefresh,
    @Default(InstructorBookingsViewMode.day)
    InstructorBookingsViewMode viewMode,
  }) = _InstructorScheduleState;
}
