import 'package:coore/lib.dart';

/// Why the backend refused to create a booking with a 409 Conflict.
///
/// The backend contract does not expose a structured conflict reason, so the
/// repository infers it from the error message. This keeps the ambiguity in
/// one place instead of leaking string matching into the presentation layer.
enum StudentBookingConflictReason {
  pendingPaymentExists,
  slotUnavailable,

  /// Unrecognized 409 — show the backend message as-is (e.g. student already
  /// booked the same time with another instructor).
  unspecifiedConflict,
}

final class StudentBookingConflictFailure extends Failure {
  const StudentBookingConflictFailure({
    required this.reason,
    required String message,
  }) : super(message);

  final StudentBookingConflictReason reason;

  @override
  List<Object?> get props => [...super.props, reason];
}
