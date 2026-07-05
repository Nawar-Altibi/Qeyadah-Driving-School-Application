part of 'instructor_leave_cubit.dart';

@freezed
abstract class InstructorLeaveState with _$InstructorLeaveState {
  const factory InstructorLeaveState({
    @Default(ApiState<List<InstructorLeaveEntity>>.initial())
    ApiState<List<InstructorLeaveEntity>> apiState,
    @Default(false) bool isSilentRefresh,
    @Default(true) bool showFullDayOnly,
  }) = _InstructorLeaveState;
}
