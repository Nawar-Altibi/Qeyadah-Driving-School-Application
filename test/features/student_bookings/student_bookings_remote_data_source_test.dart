import 'package:coore/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qeyadah_mobile_app/src/core/constants/endpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/data/data_sources/student_bookings_remote_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/params/student_bookings_params.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_booking_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_charge_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_payment_status.dart';

class MockApiHandler extends Mock implements ApiHandlerInterface {}

void main() {
  late MockApiHandler apiHandler;
  late StudentBookingsRemoteDataSourceImpl dataSource;

  setUp(() {
    apiHandler = MockApiHandler();
    dataSource = StudentBookingsRemoteDataSourceImpl(apiHandler);
  });

  group('fetchBookings', () {
    test('maps the { data, meta } envelope into a page entity', () async {
      when(
        () => apiHandler.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          isAuthorized: any(named: 'isAuthorized'),
        ),
      ).thenAnswer(
        (_) async => right({
          'data': [
            {
              'id': '101',
              'studentName': 'Sara',
              'instructorName': 'Omar',
              'trainingType': 'MANUAL',
              'vehicleSource': 'SCHOOL_CAR',
              'vehiclePlate': null,
              'date': '2026-08-05',
              'dayName': 'Wednesday',
              'startTime': '09:00',
              'endTime': '10:00',
              'bookingStatus': 'BOOKED',
              'paymentStatus': 'DEPOSIT_PAID',
              'remainingAmount': '500',
            },
          ],
          'meta': {'total': 12, 'page': 1, 'limit': 20, 'totalPages': 2},
        }),
      );

      final result = await dataSource.fetchBookings(
        LoadStudentBookingsParams(),
      );

      expect(result.isRight(), isTrue);
      final page = result.fold((_) => null, (value) => value)!;
      expect(page.items, hasLength(1));
      expect(page.items.first.id, '101');
      expect(page.items.first.bookingStatus, StudentBookingStatus.booked);
      expect(page.items.first.paymentStatus, StudentPaymentStatus.depositPaid);
      expect(page.total, 12);
      expect(page.totalPages, 2);
      expect(page.hasMorePages, isTrue);
    });

    test(
      'unwraps the live { statusCode, data: { data, meta } } envelope',
      () async {
        when(
          () => apiHandler.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
            isAuthorized: any(named: 'isAuthorized'),
          ),
        ).thenAnswer(
          (_) async => right({
            'statusCode': 200,
            'data': {
              'data': [
                {
                  'id': '542',
                  'studentName': 'طالب تجريبي 1',
                  'instructorName': 'نور حسين',
                  'trainingType': 'MANUAL',
                  'vehicleSource': 'SCHOOL_CAR',
                  'vehiclePlate': 'أ ب ج 103',
                  'date': '2026-08-30',
                  'dayName': 'الأحد',
                  'startTime': '15:00',
                  'endTime': '15:45',
                  'bookingStatus': 'BOOKED',
                  'paymentStatus': 'DEPOSIT_PAID',
                  'remainingAmount': null,
                },
              ],
              'meta': {'total': 12, 'page': 1, 'limit': 2, 'totalPages': 6},
            },
          }),
        );

        final result = await dataSource.fetchBookings(
          LoadStudentBookingsParams(),
        );

        expect(result.isRight(), isTrue);
        final page = result.fold((_) => null, (value) => value)!;
        expect(page.items, hasLength(1));
        expect(page.items.first.id, '542');
        expect(page.total, 12);
        expect(page.totalPages, 6);
      },
    );

    test('clamps the requested limit to the backend maximum of 50', () {
      final params = LoadStudentBookingsParams(limit: 500);
      expect(params.limit, 50);
    });

    test('defaults the limit to 20 when not provided', () {
      final params = LoadStudentBookingsParams();
      expect(params.limit, 20);
    });

    test('fails gracefully when "data" is not a list', () async {
      when(
        () => apiHandler.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          isAuthorized: any(named: 'isAuthorized'),
        ),
      ).thenAnswer((_) async => right({'data': 'unexpected'}));

      final result = await dataSource.fetchBookings(
        LoadStudentBookingsParams(),
      );

      expect(result.isLeft(), isTrue);
      expect(
        result.fold((failure) => failure, (_) => null),
        isA<InternalServerErrorFailure>(),
      );
    });

    test(
      'forwards the status filter, search, and pagination query params',
      () async {
        when(
          () => apiHandler.get(
            any(),
            queryParameters: any(named: 'queryParameters'),
            isAuthorized: any(named: 'isAuthorized'),
          ),
        ).thenAnswer(
          (_) async => right({
            'data': <Map<String, dynamic>>[],
            'meta': {'total': 0, 'page': 1, 'limit': 20, 'totalPages': 1},
          }),
        );

        await dataSource.fetchBookings(
          LoadStudentBookingsParams(
            bookingStatus: StudentBookingStatus.booked,
            search: 'Omar',
            page: 2,
          ),
        );

        final captured = verify(
          () => apiHandler.get(
            Endpoints.studentBookings,
            queryParameters: captureAny(named: 'queryParameters'),
            isAuthorized: true,
          ),
        ).captured;

        expect(captured.single, {
          'bookingStatus': 'BOOKED',
          'search': 'Omar',
          'page': 2,
          'limit': 20,
        });
      },
    );
  });

  group('fetchBookingDetail', () {
    test(
      'maps the booking/student/instructor/vehicle/charges payload',
      () async {
        when(
          () => apiHandler.get(any(), isAuthorized: any(named: 'isAuthorized')),
        ).thenAnswer(
          (_) async => right({
            'booking': {
              'id': '55',
              'bookingStatus': 'BOOKED',
              'paymentStatus': 'DEPOSIT_PAID',
              'trainingType': 'MANUAL',
              'vehicleSource': 'SCHOOL_CAR',
              'date': '2026-08-05',
              'dayName': 'Wednesday',
              'startTime': '09:00',
              'endTime': '10:00',
              'lockedUntil': null,
              'createdAt': '2026-08-01T10:00:00.000Z',
            },
            'student': {'id': 1, 'name': 'Sara', 'phone': '0999000000'},
            'instructor': {'id': 2, 'name': 'Omar', 'phone': '0999111111'},
            'vehicle': {
              'id': 3,
              'source': 'SCHOOL_CAR',
              'plateNumber': '12345',
            },
            'charges': [
              {
                'id': 9,
                'chargeReason': 'Deposit',
                'amountDue': '1000',
                'chargeStatus': 'PARTIALLY_PAID',
                'payments': [
                  {
                    'id': 1,
                    'amountPaid': '400.50',
                    'paymentMethod': 'SHAM_CASH',
                    'receivedAt': '2026-08-01T10:05:00.000Z',
                  },
                ],
              },
            ],
          }),
        );

        final result = await dataSource.fetchBookingDetail(55);

        expect(result.isRight(), isTrue);
        final detail = result.fold((_) => null, (value) => value)!;
        expect(detail.booking.id, 55);
        expect(detail.booking.bookingStatus, StudentBookingStatus.booked);
        expect(detail.student.name, 'Sara');
        expect(detail.instructor.name, 'Omar');
        expect(detail.vehicle?.plateNumber, '12345');
        expect(detail.charges, hasLength(1));
        expect(
          detail.charges.first.chargeStatus,
          StudentChargeStatus.partiallyPaid,
        );
        expect(detail.charges.first.payments.single.amountPaid, '400.50');
        expect(detail.charges.first.remaining, closeTo(599.5, 0.001));
      },
    );

    test('unwraps live statusCode envelope for booking detail', () async {
      when(
        () => apiHandler.get(any(), isAuthorized: any(named: 'isAuthorized')),
      ).thenAnswer(
        (_) async => right({
          'statusCode': 200,
          'data': {
            'booking': {
              'id': '542',
              'bookingStatus': 'BOOKED',
              'paymentStatus': 'DEPOSIT_PAID',
              'trainingType': 'MANUAL',
              'vehicleSource': 'SCHOOL_CAR',
              'date': '2026-08-30',
              'dayName': 'الأحد',
              'startTime': '15:00',
              'endTime': '15:45',
              'lockedUntil': null,
              'createdAt': '2026-08-02T09:00:00.000Z',
            },
            'student': {
              'id': '1',
              'name': 'طالب تجريبي 1',
              'phone': '0500000001',
            },
            'instructor': {'id': '4', 'name': 'نور حسين', 'gender': 'FEMALE'},
            'vehicle': {
              'id': '4',
              'plateNumber': 'أ ب ج 103',
              'model': 'هيونداي أكسنت 2021',
              'type': 'MANUAL',
            },
            'charges': [
              {
                'id': '550',
                'chargeReason': 'LESSON',
                'amountDue': '3080.00',
                'chargeStatus': 'PARTIALLY_PAID',
                'payments': [
                  {
                    'id': '789',
                    'amountPaid': '1540.00',
                    'paymentMethod': 'CASH',
                    'receivedAt': '2026-08-02T09:00:00.000Z',
                  },
                ],
              },
            ],
          },
        }),
      );

      final result = await dataSource.fetchBookingDetail(542);

      expect(result.isRight(), isTrue);
      final detail = result.fold((_) => null, (value) => value)!;
      expect(detail.booking.id, 542);
      expect(detail.student.phone, '0500000001');
      expect(detail.vehicle?.plateNumber, 'أ ب ج 103');
      expect(detail.charges.single.amountDue, '3080.00');
    });

    test('treats a null vehicle as no-vehicle (student car)', () async {
      when(
        () => apiHandler.get(any(), isAuthorized: any(named: 'isAuthorized')),
      ).thenAnswer(
        (_) async => right({
          'booking': {
            'id': '55',
            'bookingStatus': 'BOOKED',
            'paymentStatus': 'DEPOSIT_PAID',
          },
          'student': {'id': 1, 'name': 'Sara'},
          'instructor': {'id': 2, 'name': 'Omar'},
          'vehicle': null,
          'charges': <Map<String, dynamic>>[],
        }),
      );

      final result = await dataSource.fetchBookingDetail(55);

      final detail = result.fold((_) => null, (value) => value)!;
      expect(detail.vehicle, isNull);
      expect(detail.charges, isEmpty);
    });
  });

  group('cancelBooking', () {
    test('posts the cancellation reason to the cancel endpoint', () async {
      when(
        () => apiHandler.post(
          any(),
          body: any(named: 'body'),
          isAuthorized: any(named: 'isAuthorized'),
        ),
      ).thenAnswer((_) async => right(<String, dynamic>{}));

      final result = await dataSource.cancelBooking(
        const CancelStudentBookingParams(
          bookingId: 55,
          cancellationReason: 'Schedule conflict',
        ),
      );

      expect(result.isRight(), isTrue);
      verify(
        () => apiHandler.post(
          Endpoints.studentBookingCancel(55),
          body: {'cancellationReason': 'Schedule conflict'},
          isAuthorized: true,
        ),
      ).called(1);
    });
  });
}
