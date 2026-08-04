import 'dart:async';

import 'package:coore/lib.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/params/student_bookings_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/use_cases/student_bookings_use_cases.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/cubit/student_bookings_list_state.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_booking_status.dart';

export 'student_bookings_list_state.dart';

const _searchDebounceDuration = Duration(milliseconds: 350);

@injectable
class StudentBookingsListCubit
    extends
        AppCoreCoreCubit<StudentBookingsListState, StudentBookingsPageEntity> {
  StudentBookingsListCubit(this._loadBookingsUseCase)
    : super(const StudentBookingsListState());

  final LoadStudentBookingsUseCase _loadBookingsUseCase;

  Timer? _searchDebounce;
  int _loadGeneration = 0;

  @override
  ApiState<StudentBookingsPageEntity> getApiState(
    StudentBookingsListState state,
  ) => state.apiState;

  @override
  StudentBookingsListState setApiState(
    StudentBookingsListState state,
    ApiState<StudentBookingsPageEntity> apiState,
  ) => state.copyWith(apiState: apiState);

  /// Loads page 1.
  ///
  /// When [silent] is true and we already have succeeded data (search/filter
  /// reloads), keep the list mounted and show an inline progress indicator
  /// instead of swapping to the full-screen skeleton (which dismisses the
  /// keyboard).
  Future<void> load({bool silent = false}) async {
    final generation = ++_loadGeneration;
    final keepExisting = silent && state.apiState.isSuccess;
    emit(
      state.copyWith(
        apiState: keepExisting ? state.apiState : const ApiState.loading(),
        isLoadingMore: false,
        isRefreshing: keepExisting,
      ),
    );

    final result = await _fetchPage(page: 1);
    if (!isActiveGeneration(
      capturedGeneration: generation,
      currentGeneration: _loadGeneration,
    )) {
      return;
    }

    result.fold(
      (failure) => emit(
        state.copyWith(
          isRefreshing: false,
          apiState: keepExisting
              ? state.apiState
              : ApiState.failed(failure, retryFunction: load),
        ),
      ),
      (page) => emit(
        state.copyWith(isRefreshing: false, apiState: ApiState.succeeded(page)),
      ),
    );
  }

  Future<void> refresh() async {
    final generation = ++_loadGeneration;
    emit(state.copyWith(isRefreshing: true));

    final result = await _fetchPage(page: 1);
    if (!isActiveGeneration(
      capturedGeneration: generation,
      currentGeneration: _loadGeneration,
    )) {
      return;
    }

    result.fold(
      (failure) => emit(
        state.copyWith(
          isRefreshing: false,
          apiState: state.apiState.isSuccess
              ? state.apiState
              : ApiState.failed(failure, retryFunction: load),
        ),
      ),
      (page) => emit(
        state.copyWith(isRefreshing: false, apiState: ApiState.succeeded(page)),
      ),
    );
  }

  Future<void> loadMore() async {
    final current = state.apiState.maybeWhen(
      succeeded: (value) => value,
      orElse: () => null,
    );
    if (current == null || !current.hasMorePages || state.isLoadingMore) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));
    final result = await _fetchPage(page: current.page + 1);
    result.fold(
      (_) => emit(state.copyWith(isLoadingMore: false)),
      (nextPage) => emit(
        state.copyWith(
          isLoadingMore: false,
          apiState: ApiState.succeeded(current.appendPage(nextPage)),
        ),
      ),
    );
  }

  void setStatusFilter(StudentBookingStatus? status) {
    if (state.selectedStatus == status) return;
    emit(state.withStatus(status));
    load(silent: true);
  }

  void setSearchQuery(String query) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(_searchDebounceDuration, () {
      if (state.searchQuery == query) {
        load(silent: true);
        return;
      }
      emit(state.copyWith(searchQuery: query));
      load(silent: true);
    });
  }

  void toggleSortOrder() {
    final next = state.sortOrder == StudentBookingsSortOrder.newestFirst
        ? StudentBookingsSortOrder.oldestFirst
        : StudentBookingsSortOrder.newestFirst;
    emit(state.copyWith(sortOrder: next));
  }

  FutureEither<StudentBookingsPageEntity> _fetchPage({required int page}) {
    final query = state.searchQuery.trim();
    return _loadBookingsUseCase(
      LoadStudentBookingsParams(
        bookingStatus: state.selectedStatus,
        search: query.isEmpty ? null : query,
        page: page,
      ),
    );
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    _loadGeneration++;
    return super.close();
  }
}
