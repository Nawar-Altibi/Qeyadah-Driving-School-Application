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
