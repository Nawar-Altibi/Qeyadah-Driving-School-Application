import 'package:equatable/equatable.dart';

/// Minimal data needed to render the payment screen, whether arriving
/// straight from a freshly created booking hold or resuming from the
/// student home "pending payment" banner.
class StudentPaymentHoldArgs extends Equatable {
  const StudentPaymentHoldArgs({
    required this.bookingId,
    required this.depositAmount,
    required this.receiverName,
    required this.lockedUntil,
  });

  final int bookingId;
  final String depositAmount;
  final String receiverName;
  final DateTime lockedUntil;

  @override
  List<Object?> get props => [
    bookingId,
    depositAmount,
    receiverName,
    lockedUntil,
  ];
}
