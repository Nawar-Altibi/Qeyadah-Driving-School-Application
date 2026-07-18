part of 'instructor_leave_cubit.dart';

@freezed
abstract class InstructorLeaveState with _$InstructorLeaveState {
  const factory InstructorLeaveState({
    required ApiState<List<InstructorLeaveEntity>> apiState,
  }) = _InstructorLeaveState;
}
