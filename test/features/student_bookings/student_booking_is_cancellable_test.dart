import 'package:flutter_test/flutter_test.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_booking_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_payment_status.dart';

void main() {
  StudentBookingDetailBookingEntity booking(StudentBookingStatus status) {
    return StudentBookingDetailBookingEntity(
      id: 1,
      bookingStatus: status,
      paymentStatus: StudentPaymentStatus.depositPaid,
    );
  }

  group('StudentBookingDetailBookingEntity.isCancellable', () {
    test('is true for booked and pendingPayment only', () {
      expect(booking(StudentBookingStatus.booked).isCancellable, isTrue);
      expect(
        booking(StudentBookingStatus.pendingPayment).isCancellable,
        isTrue,
      );
    });

    test('is false for terminal statuses including cancelled', () {
      expect(booking(StudentBookingStatus.cancelled).isCancellable, isFalse);
      expect(booking(StudentBookingStatus.completed).isCancellable, isFalse);
      expect(booking(StudentBookingStatus.expired).isCancellable, isFalse);
      expect(booking(StudentBookingStatus.noShow).isCancellable, isFalse);
    });
  });

  group('StudentBookingStatus.fromApi', () {
    test('accepts CANCELLED and CANCELED', () {
      expect(
        StudentBookingStatus.fromApi('CANCELLED'),
        StudentBookingStatus.cancelled,
      );
      expect(
        StudentBookingStatus.fromApi('CANCELED'),
        StudentBookingStatus.cancelled,
      );
    });
  });
}
