import 'package:flutter_test/flutter_test.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_payment_status.dart';

void main() {
  group('StudentBookingDepositOutcomeMapper.fromPaymentStatus', () {
    test('maps DEPOSIT_AVAILABLE_FOR_REBOOKING to availableForRebooking', () {
      expect(
        StudentBookingDepositOutcomeMapper.fromPaymentStatus(
          StudentPaymentStatus.depositAvailableForRebooking,
        ),
        StudentBookingDepositOutcome.availableForRebooking,
      );
    });

    test('maps DEPOSIT_NON_REFUNDABLE to nonRefundable', () {
      expect(
        StudentBookingDepositOutcomeMapper.fromPaymentStatus(
          StudentPaymentStatus.depositNonRefundable,
        ),
        StudentBookingDepositOutcome.nonRefundable,
      );
    });

    for (final status in [
      StudentPaymentStatus.pendingDeposit,
      StudentPaymentStatus.depositPaid,
      StudentPaymentStatus.fullyPaid,
      StudentPaymentStatus.depositUsedInRebooking,
    ]) {
      test('maps $status to none (not a cancellation deposit outcome)', () {
        expect(
          StudentBookingDepositOutcomeMapper.fromPaymentStatus(status),
          StudentBookingDepositOutcome.none,
        );
      });
    }
  });
}
