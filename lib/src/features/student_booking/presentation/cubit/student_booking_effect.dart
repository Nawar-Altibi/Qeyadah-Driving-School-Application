part of 'student_booking_cubit.dart';

sealed class StudentBookingEffect {
  const StudentBookingEffect();
}

final class StudentBookingEffectNavigateToSlots extends StudentBookingEffect {
  const StudentBookingEffectNavigateToSlots();
}

final class StudentBookingEffectNavigateToReview extends StudentBookingEffect {
  const StudentBookingEffectNavigateToReview();
}

final class StudentBookingEffectBookingCreated extends StudentBookingEffect {
  const StudentBookingEffectBookingCreated(this.hold);

  final StudentBookingHoldEntity hold;
}

/// The requested slot was taken by someone else before the booking could be
/// created; the slots list should be refreshed.
final class StudentBookingEffectSlotConflict extends StudentBookingEffect {
  const StudentBookingEffectSlotConflict(this.failure);

  final Failure failure;
}

/// Backend 409 with a message we should show as-is (e.g. overlapping booking
/// with another instructor). Do not force a slots refresh unless the user
/// chooses to go back.
final class StudentBookingEffectBackendConflict extends StudentBookingEffect {
  const StudentBookingEffectBackendConflict(this.failure);

  final Failure failure;
}

/// The student already has a PENDING_PAYMENT booking; they should resume
/// that payment instead of creating a new one.
final class StudentBookingEffectPendingPaymentConflict
    extends StudentBookingEffect {
  const StudentBookingEffectPendingPaymentConflict(this.failure);

  final Failure failure;
}

final class StudentBookingEffectActionFailed extends StudentBookingEffect {
  const StudentBookingEffectActionFailed(this.failure);

  final Failure failure;
}
