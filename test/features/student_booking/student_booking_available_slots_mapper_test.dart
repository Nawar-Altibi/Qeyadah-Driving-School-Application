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

  setUp(() {
    apiHandler = MockApiHandler();
    dataSource = StudentBookingRemoteDataSourceImpl(apiHandler);
  });

  group('fetchAvailableSlots', () {
    test('maps a list "data" payload into instructors and slots', () async {
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
        }),
      );

      final result = await dataSource.fetchAvailableSlots(params);

      expect(result.isRight(), isTrue);
      final page = result.fold((_) => null, (value) => value)!;
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

    test('hasAnySlots is false when every instructor has no slots', () async {
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

      final page = result.fold((_) => null, (value) => value)!;
      expect(page.hasAnySlots, isFalse);
    });

    test('fails gracefully when "data" is not a list', () async {
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
      ).thenAnswer((_) async => right({'data': <Map<String, dynamic>>[]}));

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
