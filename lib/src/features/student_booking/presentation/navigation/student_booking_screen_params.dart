import 'package:coore/lib.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/cubit/student_booking_cubit.dart';

/// Carries the shared [StudentBookingCubit] instance across the
/// preferences -> slots -> review screens (mirrors the registration OTP
/// cubit-through-`extra` pattern).
class StudentBookingScreenParams extends BaseScreenParams {
  const StudentBookingScreenParams({required this.cubit});

  final StudentBookingCubit cubit;

  static const String cubitExtraKey = 'studentBookingCubit';

  @override
  Map<String, Object> get extra => {cubitExtraKey: cubit};

  @override
  List<Object?> get props => [cubit];
}

StudentBookingCubit? studentBookingCubitFromExtra(Object? extra) {
  if (extra is! Map) return null;
  final value = extra[StudentBookingScreenParams.cubitExtraKey];
  return value is StudentBookingCubit ? value : null;
}

/// Carries the confirmed booking id to the saved-deposit success screen.
class StudentBookingCreditSuccessScreenParams extends BaseScreenParams {
  const StudentBookingCreditSuccessScreenParams({required this.bookingId});

  final int bookingId;

  static const String bookingIdExtraKey = 'studentBookingCreditSuccessId';

  @override
  Map<String, Object> get extra => {bookingIdExtraKey: bookingId};

  @override
  List<Object?> get props => [bookingId];
}

int? studentBookingCreditSuccessIdFromExtra(Object? extra) {
  if (extra is! Map) return null;
  final value =
      extra[StudentBookingCreditSuccessScreenParams.bookingIdExtraKey];
  return value is int ? value : null;
}
