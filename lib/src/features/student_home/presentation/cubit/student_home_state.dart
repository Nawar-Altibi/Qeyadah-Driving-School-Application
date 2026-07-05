part of 'student_home_cubit.dart';

@freezed
abstract class StudentHomeState with _$StudentHomeState {
  const factory StudentHomeState({
    @Default(ApiState<StudentHomeDashboardEntity>.initial())
    ApiState<StudentHomeDashboardEntity> apiState,
    @Default(false) bool isSilentRefresh,
  }) = _StudentHomeState;
}
