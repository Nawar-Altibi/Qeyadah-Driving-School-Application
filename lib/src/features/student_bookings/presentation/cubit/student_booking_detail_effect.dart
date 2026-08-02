part of 'student_booking_detail_cubit.dart';

sealed class StudentBookingDetailEffect {
  const StudentBookingDetailEffect();
}

/// A fresh, still-valid ShamCash hold exists for this booking; resume the
/// payment screen with it.
final class StudentBookingDetailEffectNavigateToPayment
    extends StudentBookingDetailEffect {
  const StudentBookingDetailEffectNavigateToPayment(this.args);

  final StudentPaymentHoldArgs args;
}

/// The booking is PENDING_PAYMENT but no local hold is cached (e.g. the app
/// was reinstalled). We deliberately do not invent deposit/receiver details.
final class StudentBookingDetailEffectPendingPaymentNoHold
    extends StudentBookingDetailEffect {
  const StudentBookingDetailEffectPendingPaymentNoHold();
}

/// The cached hold for this booking has expired; offer to start a new
/// booking instead.
final class StudentBookingDetailEffectHoldExpired
    extends StudentBookingDetailEffect {
  const StudentBookingDetailEffectHoldExpired();
}

/// The cancellation request succeeded and the detail was refetched.
final class StudentBookingDetailEffectCancelSucceeded
    extends StudentBookingDetailEffect {
  const StudentBookingDetailEffectCancelSucceeded();
}

final class StudentBookingDetailEffectActionFailed
    extends StudentBookingDetailEffect {
  const StudentBookingDetailEffectActionFailed(this.failure);

  final Failure failure;
}
