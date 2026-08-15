import 'package:coore/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qeyadah_mobile_app/src/core/constants/endpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/data/data_sources/student_booking_remote_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/params/student_booking_params.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_gender.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/vehicle_source.dart';

class MockApiHandler extends Mock implements ApiHandlerInterface {}

void main() {
  late MockApiHandler apiHandler;
  late StudentBookingRemoteDataSourceImpl dataSource;

  const params = LoadAvailableSlotsParams(
    trainingType: TrainingType.manual,
    vehicleSource: VehicleSource.schoolCar,
    instructorGender: InstructorGender.male,
  );

  Map<String, dynamic> pricingJson({
    String lessonPrice = '66000.00',
    String depositAmount = '33000.00',
  }) {
    return {
      'lessonPrice': lessonPrice,
      'depositAmount': depositAmount,
      'depositPercentage': 50,
      'lessonDurationMinutes': 60,
    };
  }

  setUp(() {
    apiHandler = MockApiHandler();
    dataSource = StudentBookingRemoteDataSourceImpl(apiHandler);
  });

  group('fetchAvailableSlots', () {
    test('maps data.instructors + data.pricing into page entity', () async {
      when(
        () => apiHandler.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          isAuthorized: any(named: 'isAuthorized'),
        ),
      ).thenAnswer(
        (_) async => right({
          'data': {
            'pricing': pricingJson(),
            'instructors': [
              {
                'instructor': {'id': '7', 'name': 'Lina', 'gender': 'FEMALE'},
                'slots': [
                  {
                    'date': '2026-08-05',
                    'dayName': 'Wednesday',
                    'startTime': '09:00',
                    'endTime': '10:00',
                  },
                  {
                    'date': '2026-08-05',
                    'dayName': 'Wednesday',
                    'startTime': '11:00',
                    'endTime': '12:00',
                  },
                ],
              },
              {
                'instructor': {'id': 9, 'name': 'Omar', 'gender': 'MALE'},
                'slots': <Map<String, dynamic>>[],
              },
            ],
          },
        }),
      );

      final result = await dataSource.fetchAvailableSlots(params);

      expect(result.isRight(), isTrue);
      final page = result.fold((_) => null, (value) => value)!;
      expect(page.pricing.lessonPrice, '66000.00');
      expect(page.pricing.depositAmount, '33000.00');
      expect(page.pricing.depositPercentage, 50);
      expect(page.pricing.lessonDurationMinutes, 60);
      expect(page.instructors, hasLength(2));

      final first = page.instructors.first;
      expect(first.instructor.id, 7);
      expect(first.instructor.name, 'Lina');
      expect(first.instructor.gender, InstructorGender.female);
      expect(first.slots, hasLength(2));
      expect(first.slots.first.startTime, '09:00');
      expect(first.slots.first.endTime, '10:00');
      expect(first.slots.first.date, DateTime.parse('2026-08-05'));

      final second = page.instructors[1];
      expect(second.instructor.id, 9);
      expect(second.slots, isEmpty);

      expect(page.hasAnySlots, isTrue);
    });

    test('succeeds with empty instructors while keeping pricing', () async {
      when(
        () => apiHandler.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          isAuthorized: any(named: 'isAuthorized'),
        ),
      ).thenAnswer(
        (_) async => right({
          'data': {
            'pricing': pricingJson(
              lessonPrice: '77000.00',
              depositAmount: '38500.00',
            ),
            'instructors': <Map<String, dynamic>>[],
          },
        }),
      );

      final result = await dataSource.fetchAvailableSlots(params);

      final page = result.fold((_) => null, (value) => value)!;
      expect(page.hasAnySlots, isFalse);
      expect(page.instructors, isEmpty);
      expect(page.pricing.lessonPrice, '77000.00');
      expect(page.pricing.depositAmount, '38500.00');
    });

    test('fails when legacy list "data" shape is returned', () async {
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
              'instructor': {'id': 1, 'name': 'Sara', 'gender': 'FEMALE'},
              'slots': <Map<String, dynamic>>[],
            },
          ],
        }),
      );

      final result = await dataSource.fetchAvailableSlots(params);

      expect(result.isLeft(), isTrue);
      expect(
        result.fold((failure) => failure, (_) => null),
        isA<InternalServerErrorFailure>(),
      );
    });

    test('fails gracefully when "data" is not an object', () async {
      when(
        () => apiHandler.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          isAuthorized: any(named: 'isAuthorized'),
        ),
      ).thenAnswer((_) async => right({'data': 'unexpected'}));

      final result = await dataSource.fetchAvailableSlots(params);

      expect(result.isLeft(), isTrue);
      expect(
        result.fold((failure) => failure, (_) => null),
        isA<InternalServerErrorFailure>(),
      );
    });

    test('sends the required query parameters as API enum values', () async {
      when(
        () => apiHandler.get(
          any(),
          queryParameters: any(named: 'queryParameters'),
          isAuthorized: any(named: 'isAuthorized'),
        ),
      ).thenAnswer(
        (_) async => right({
          'data': {
            'pricing': pricingJson(),
            'instructors': <Map<String, dynamic>>[],
          },
        }),
      );

      await dataSource.fetchAvailableSlots(params);

      final captured = verify(
        () => apiHandler.get(
          Endpoints.studentBookingsAvailableSlots,
          queryParameters: captureAny(named: 'queryParameters'),
          isAuthorized: true,
        ),
      ).captured;

      expect(captured.single, {
        'trainingType': 'MANUAL',
        'vehicleSource': 'SCHOOL_CAR',
        'instructorGender': 'MALE',
      });
    });
  });
}
