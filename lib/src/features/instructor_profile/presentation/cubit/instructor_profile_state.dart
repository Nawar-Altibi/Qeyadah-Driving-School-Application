part of 'instructor_profile_cubit.dart';

@freezed
abstract class InstructorProfileState with _$InstructorProfileState {
  const factory InstructorProfileState({
    @Default(ApiState<InstructorProfileDashboardEntity>.initial())
    ApiState<InstructorProfileDashboardEntity> apiState,
    @Default(false) bool isSilentRefresh,
  }) = _InstructorProfileState;
}
