import 'package:coore/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/data/data_sources/instructor_local_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/data/data_sources/instructor_remote_data_source.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/data/repositories/instructor_repository_impl.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';

class MockInstructorRemoteDataSource extends Mock
    implements InstructorRemoteDataSource {}

class MockInstructorLocalDataSource extends Mock
    implements InstructorLocalDataSource {}

void main() {
  late MockInstructorRemoteDataSource remote;
  late MockInstructorLocalDataSource local;
  late InstructorRepositoryImpl repository;

  const schedule = [
    InstructorScheduleDayEntity(
      dayOfWeek: 'SAT',
      periods: [
        InstructorSchedulePeriodEntity(startTime: '08:00', endTime: '12:00'),
      ],
    ),
  ];

  setUpAll(() {
    registerFallbackValue(schedule);
  });

  setUp(() {
    remote = MockInstructorRemoteDataSource();
    local = MockInstructorLocalDataSource();
    repository = InstructorRepositoryImpl(remote, local);
  });

  group('getWeeklySchedule', () {
    test('returns fresh cache without hitting remote', () async {
      final cached = CachedInstructorWeeklySchedule(
        schedule: schedule,
        cachedAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(hours: 12)),
      );
      when(
        () => local.readWeeklySchedule(),
      ).thenAnswer((_) async => right(cached));

      final result = await repository.getWeeklySchedule();

      expect(result.fold((_) => null, (value) => value), schedule);
      verifyNever(() => remote.fetchWeeklySchedule());
      verifyNever(() => local.saveWeeklySchedule(any()));
    });

    test('forceRefresh skips fresh cache and saves remote result', () async {
      final cached = CachedInstructorWeeklySchedule(
        schedule: schedule,
        cachedAt: DateTime.now(),
        expiresAt: DateTime.now().add(const Duration(hours: 12)),
      );
      when(
        () => local.readWeeklySchedule(),
      ).thenAnswer((_) async => right(cached));
      when(
        () => remote.fetchWeeklySchedule(),
      ).thenAnswer((_) async => right(schedule));
      when(
        () => local.saveWeeklySchedule(any()),
      ).thenAnswer((_) async => right(null));

      final result = await repository.getWeeklySchedule(forceRefresh: true);

      expect(result.fold((_) => null, (value) => value), schedule);
      verify(() => remote.fetchWeeklySchedule()).called(1);
      verify(() => local.saveWeeklySchedule(schedule)).called(1);
    });

    test('falls back to stale cache when remote fails', () async {
      final stale = CachedInstructorWeeklySchedule(
        schedule: schedule,
        cachedAt: DateTime.now().subtract(const Duration(days: 2)),
        expiresAt: DateTime.now().subtract(const Duration(hours: 1)),
      );
      when(
        () => local.readWeeklySchedule(),
      ).thenAnswer((_) async => right(stale));
      when(() => remote.fetchWeeklySchedule()).thenAnswer(
        (_) async => left(const InternalServerErrorFailure('server error')),
      );

      final result = await repository.getWeeklySchedule();

      expect(result.fold((_) => null, (value) => value), schedule);
    });

    test('invalidateWeeklyScheduleCache clears local schedule', () async {
      when(
        () => local.clearWeeklySchedule(),
      ).thenAnswer((_) async => right(null));

      final result = await repository.invalidateWeeklyScheduleCache();

      expect(result.isRight(), isTrue);
      verify(() => local.clearWeeklySchedule()).called(1);
    });
  });
}
