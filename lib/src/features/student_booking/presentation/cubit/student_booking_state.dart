part of 'student_booking_cubit.dart';

@freezed
abstract class StudentBookingState with _$StudentBookingState {
  const factory StudentBookingState({
    @Default(StudentBookingFiltersEntity()) StudentBookingFiltersEntity filters,
    @Default(ApiState<StudentAvailableSlotsPageEntity>.initial())
    ApiState<StudentAvailableSlotsPageEntity> apiState,
    @Default(false) bool isSilentRefresh,
    StudentBookingSelectionEntity? selection,
    StudentBookingPricingEntity? pricing,
    @Default(false) bool isCreatingBooking,
    StudentBookingEffect? effect,
  }) = _StudentBookingState;
}
