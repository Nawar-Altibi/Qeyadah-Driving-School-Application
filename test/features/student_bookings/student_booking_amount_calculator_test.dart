import 'package:flutter_test/flutter_test.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_booking_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_charge_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_payment_status.dart';

StudentBookingChargePaymentEntity _payment(String amountPaid) {
  return StudentBookingChargePaymentEntity(
    id: 1,
    amountPaid: amountPaid,
    paymentMethod: 'SHAM_CASH',
    receivedAt: DateTime(2026, 8),
  );
}

void main() {
  group('StudentBookingAmountCalculator.sumPayments', () {
    test('sums parseable decimal amounts', () {
      final total = StudentBookingAmountCalculator.sumPayments([
        _payment('100.50'),
        _payment('49.50'),
      ]);
      expect(total, 150.0);
    });

    test('ignores unparsable amounts instead of throwing', () {
      final total = StudentBookingAmountCalculator.sumPayments([
        _payment('not-a-number'),
        _payment('50'),
      ]);
      expect(total, 50.0);
    });

    test('returns 0 for an empty payments list', () {
      expect(StudentBookingAmountCalculator.sumPayments([]), 0.0);
    });
  });

  group('StudentBookingAmountCalculator.computeRemaining', () {
    test('subtracts total paid from amount due', () {
      final remaining = StudentBookingAmountCalculator.computeRemaining(
        '1000',
        [_payment('400')],
      );
      expect(remaining, 600.0);
    });

    test('never returns a negative remainder when overpaid', () {
      final remaining = StudentBookingAmountCalculator.computeRemaining(
        '1000',
        [_payment('1200')],
      );
      expect(remaining, 0.0);
    });

    test('treats an unparsable amountDue as 0', () {
      final remaining = StudentBookingAmountCalculator.computeRemaining(
        'invalid',
        [_payment('50')],
      );
      expect(remaining, 0.0);
    });
  });

  group('StudentBookingChargeEntity', () {
    test('exposes totalPaid and remaining derived from its payments', () {
      final charge = StudentBookingChargeEntity(
        id: 1,
        chargeReason: 'Deposit',
        amountDue: '1000',
        chargeStatus: StudentChargeStatus.partiallyPaid,
        payments: [_payment('250'), _payment('250')],
      );

      expect(charge.totalPaid, 500.0);
      expect(charge.remaining, 500.0);
    });
  });

  group('StudentBookingDetailEntity totals', () {
    test(
      'aggregates totalAmountDue, totalPaid, and totalRemaining across charges',
      () {
        final detail = StudentBookingDetailEntity(
          booking: const StudentBookingDetailBookingEntity(
            id: 1,
            bookingStatus: StudentBookingStatus.booked,
            paymentStatus: StudentPaymentStatus.depositPaid,
          ),
          student: const StudentBookingDetailPersonEntity(id: 1, name: 'Sara'),
          instructor: const StudentBookingDetailPersonEntity(
            id: 2,
            name: 'Omar',
          ),
          charges: [
            StudentBookingChargeEntity(
              id: 1,
              chargeReason: 'Deposit',
              amountDue: '1000',
              chargeStatus: StudentChargeStatus.partiallyPaid,
              payments: [_payment('400')],
            ),
            const StudentBookingChargeEntity(
              id: 2,
              chargeReason: 'Extra hour',
              amountDue: '200',
              chargeStatus: StudentChargeStatus.unpaid,
              payments: [],
            ),
          ],
        );

        expect(detail.totalAmountDue, 1200.0);
        expect(detail.totalPaid, 400.0);
        expect(detail.totalRemaining, 800.0);
      },
    );
  });
}
