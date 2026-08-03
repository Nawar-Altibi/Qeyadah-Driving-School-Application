import 'package:bloc_test/bloc_test.dart';
import 'package:coore/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/params/student_bookings_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/repositories/student_bookings_repository.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/use_cases/student_bookings_use_cases.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/cubit/student_bookings_list_cubit.dart';

class MockStudentBookingsRepository extends Mock
    implements StudentBookingsRepository {}

StudentBookingListItemEntity _item(String id) {
  return StudentBookingListItemEntity.placeholder(id: id);
}

StudentBookingsPageEntity _page({
  required List<StudentBookingListItemEntity> items,
  int page = 1,
  int totalPages = 1,
}) {
  return StudentBookingsPageEntity(
    items: items,
    total: items.length,
    page: page,
    limit: 10,
    totalPages: totalPages,
  );
}

void main() {
  setUpAll(() {
    registerFallbackValue(LoadStudentBookingsParams());
  });

  group('StudentBookingsListCubit', () {
    late MockStudentBookingsRepository repository;
    late StudentBookingsListCubit cubit;

    setUp(() {
      repository = MockStudentBookingsRepository();
      cubit = StudentBookingsListCubit(LoadStudentBookingsUseCase(repository));
    });

    tearDown(() async {
      await cubit.close();
    });

    blocTest<StudentBookingsListCubit, StudentBookingsListState>(
      'silent search reload keeps succeeded page and sets isRefreshing',
      build: () {
        when(
          () => repository.getBookings(any()),
        ).thenAnswer((_) async => right(_page(items: [_item('1')])));
        return cubit;
      },
      act: (c) async {
        await c.load();
        c.setSearchQuery('ali');
        await Future<void>.delayed(const Duration(milliseconds: 400));
      },
      verify: (c) {
        expect(c.state.apiState.isSuccess, isTrue);
        expect(c.state.searchQuery, 'ali');
        expect(c.state.isRefreshing, isFalse);
      },
    );

    blocTest<StudentBookingsListCubit, StudentBookingsListState>(
      'toggleSortOrder flips between newest and oldest without refetch',
      build: () {
        when(() => repository.getBookings(any())).thenAnswer(
          (_) async => right(_page(items: [_item('1'), _item('2')])),
        );
        return cubit;
      },
      act: (c) async {
        await c.load();
        clearInteractions(repository);
        c.toggleSortOrder();
      },
      verify: (c) {
        expect(c.state.sortOrder, StudentBookingsSortOrder.oldestFirst);
        verifyNever(() => repository.getBookings(any()));
      },
    );

    blocTest<StudentBookingsListCubit, StudentBookingsListState>(
      'loadMore appends next page once while hasMorePages',
      build: () {
        when(() => repository.getBookings(any())).thenAnswer((
          invocation,
        ) async {
          final params =
              invocation.positionalArguments.first as LoadStudentBookingsParams;
          if (params.page == 1) {
            return right(_page(items: [_item('1')], totalPages: 2));
          }
          return right(_page(items: [_item('2')], page: 2, totalPages: 2));
        });
        return cubit;
      },
      act: (c) async {
        await c.load();
        await c.loadMore();
        await c.loadMore();
      },
      verify: (c) {
        final page = c.state.apiState.maybeWhen(
          succeeded: (value) => value,
          orElse: () => null,
        );
        expect(page?.items.map((e) => e.id), ['1', '2']);
        expect(page?.hasMorePages, isFalse);
        verify(() => repository.getBookings(any())).called(2);
      },
    );
  });
}
