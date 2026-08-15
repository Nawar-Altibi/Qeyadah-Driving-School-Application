import 'package:coore/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qeyadah_mobile_app/src/core/constants/endpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/data/data_sources/student_booking_remote_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/params/student_booking_params.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_booking_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_payment_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/vehicle_source.dart';

class MockApiHandler extends Mock implements ApiHandlerInterface {}

void main() {
  late MockApiHandler apiHandler;
  late StudentBookingRemoteDataSourceImpl dataSource;

  final params = CreateStudentBookingParams(
    instructorId: 1,
    date: DateTime(2026, 8, 15),
    time: '09:00',
    trainingType: TrainingType.manual,
    vehicleSource: VehicleSource.schoolCar,
  );

  setUp(() {
    apiHandler = MockApiHandler();
    dataSource = StudentBookingRemoteDataSourceImpl(apiHandler);
  });

  group('createBooking hold mapping', () {
    test('maps paymentRequired true with deposit hold fields', () async {
      when(
        () => apiHandler.post(
          any(),
          body: any(named: 'body'),
          isAuthorized: any(named: 'isAuthorized'),
        ),
      ).thenAnswer(
        (_) async => right({
          'data': {
            'booking': {
              'id': '560',
              'bookingStatus': 'PENDING_PAYMENT',
              'paymentStatus': 'PENDING_DEPOSIT',
              'trainingType': 'MANUAL',
              'vehicleSource': 'SCHOOL_CAR',
              'lockedUntil': '2026-08-15T09:30:00.000Z',
              'instructor': {'id': '1', 'name': 'Mohammad', 'gender': 'MALE'},
            },
            'paymentRequired': true,
            'depositAmount': '33000.00',
            'lockedUntil': '2026-08-15T09:30:00.000Z',
            'receiverName': 'ShamCash Receiver',
          },
        }),
      );

      final result = await dataSource.createBooking(params);
      final hold = result.fold((_) => null, (value) => value)!;

      expect(hold.paymentRequired, isTrue);
      expect(hold.depositAmount, '33000.00');
      expect(hold.receiverName, 'ShamCash Receiver');
      expect(hold.lockedUntil, isNotNull);
      expect(hold.booking.bookingStatus, StudentBookingStatus.pendingPayment);
      expect(hold.booking.paymentStatus, StudentPaymentStatus.pendingDeposit);
    });

    test(
      'maps paymentRequired false without depositAmount and null lockedUntil',
      () async {
        when(
          () => apiHandler.post(
            any(),
            body: any(named: 'body'),
            isAuthorized: any(named: 'isAuthorized'),
          ),
        ).thenAnswer(
          (_) async => right({
            'data': {
              'booking': {
                'id': '554',
                'bookingStatus': 'BOOKED',
                'paymentStatus': 'DEPOSIT_PAID',
                'trainingType': 'MANUAL',
                'vehicleSource': 'SCHOOL_CAR',
                'lockedUntil': null,
                'instructor': {'id': '1', 'name': 'Mohammad', 'gender': 'MALE'},
              },
              'paymentRequired': false,
            },
          }),
        );

        final result = await dataSource.createBooking(params);
        final hold = result.fold((_) => null, (value) => value)!;

        expect(hold.paymentRequired, isFalse);
        expect(hold.depositAmount, isNull);
        expect(hold.lockedUntil, isNull);
        expect(hold.booking.bookingStatus, StudentBookingStatus.booked);
        expect(hold.booking.paymentStatus, StudentPaymentStatus.depositPaid);
      },
    );

    test('fails when paymentRequired true and lockedUntil missing', () async {
      when(
        () => apiHandler.post(
          any(),
          body: any(named: 'body'),
          isAuthorized: any(named: 'isAuthorized'),
        ),
      ).thenAnswer(
        (_) async => right({
          'data': {
            'booking': {
              'id': '560',
              'bookingStatus': 'PENDING_PAYMENT',
              'paymentStatus': 'PENDING_DEPOSIT',
              'trainingType': 'MANUAL',
              'vehicleSource': 'SCHOOL_CAR',
              'instructor': {'id': '1', 'name': 'Mohammad', 'gender': 'MALE'},
            },
            'paymentRequired': true,
            'depositAmount': '33000.00',
            'receiverName': 'Receiver',
          },
        }),
      );

      final result = await dataSource.createBooking(params);
      expect(result.isLeft(), isTrue);
    });

    test('posts to student bookings endpoint', () async {
      when(
        () => apiHandler.post(
          any(),
          body: any(named: 'body'),
          isAuthorized: any(named: 'isAuthorized'),
        ),
      ).thenAnswer(
        (_) async => right({
          'data': {
            'booking': {
              'id': '1',
              'bookingStatus': 'BOOKED',
              'paymentStatus': 'DEPOSIT_PAID',
              'instructor': {'id': '1', 'name': 'A', 'gender': 'MALE'},
            },
            'paymentRequired': false,
          },
        }),
      );

      await dataSource.createBooking(params);

      verify(
        () => apiHandler.post(
          Endpoints.studentBookings,
          body: any(named: 'body'),
          isAuthorized: true,
        ),
      ).called(1);
    });
  });
}
