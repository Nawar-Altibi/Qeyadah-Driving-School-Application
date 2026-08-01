part of 'student_booking_detail_cubit.dart';

@freezed
abstract class StudentBookingDetailState with _$StudentBookingDetailState {
  const factory StudentBookingDetailState({
    int? bookingId,
    @Default(ApiState<StudentBookingDetailEntity>.initial())
    ApiState<StudentBookingDetailEntity> apiState,
    @Default(false) bool isCancelling,
    StudentBookingDetailEffect? effect,
  }) = _StudentBookingDetailState;
}
