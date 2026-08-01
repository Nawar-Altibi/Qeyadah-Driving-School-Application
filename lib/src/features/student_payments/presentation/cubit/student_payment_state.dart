part of 'student_payment_cubit.dart';

@freezed
abstract class StudentPaymentState with _$StudentPaymentState {
  const factory StudentPaymentState({
    StudentPaymentHoldArgs? args,
    @Default(Duration.zero) Duration remaining,
    @Default(false) bool isExpired,
    @Default(false) bool isSubmitting,
    StudentPaymentEffect? effect,
  }) = _StudentPaymentState;
}
