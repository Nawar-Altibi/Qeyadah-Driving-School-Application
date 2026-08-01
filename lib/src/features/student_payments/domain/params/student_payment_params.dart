import 'package:equatable/equatable.dart';

class ConfirmStudentPaymentParams extends Equatable {
  const ConfirmStudentPaymentParams({
    required this.bookingId,
    required this.transactionId,
  });

  final int bookingId;
  final String transactionId;

  @override
  List<Object?> get props => [bookingId, transactionId];
}
