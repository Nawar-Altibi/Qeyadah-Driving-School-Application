import 'package:equatable/equatable.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_booking_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_payment_status.dart';

/// Result of confirming a ShamCash payment for a booking.
class StudentPaymentConfirmationEntity extends Equatable {
  const StudentPaymentConfirmationEntity({
    required this.bookingId,
    required this.bookingStatus,
    required this.paymentStatus,
  });

  final int bookingId;
  final StudentBookingStatus bookingStatus;
  final StudentPaymentStatus paymentStatus;

  @override
  List<Object?> get props => [bookingId, bookingStatus, paymentStatus];
}
