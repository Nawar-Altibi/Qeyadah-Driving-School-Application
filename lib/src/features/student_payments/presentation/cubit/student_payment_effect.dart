part of 'student_payment_cubit.dart';

sealed class StudentPaymentEffect {
  const StudentPaymentEffect();
}

final class StudentPaymentEffectPaymentConfirmed extends StudentPaymentEffect {
  const StudentPaymentEffectPaymentConfirmed(this.confirmation);

  final StudentPaymentConfirmationEntity confirmation;
}

final class StudentPaymentEffectActionFailed extends StudentPaymentEffect {
  const StudentPaymentEffectActionFailed(this.failure);

  final Failure failure;
}
