import 'package:coore/lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/use_cases/instructor_use_cases.dart';

part 'instructor_schedule_cubit.freezed.dart';
part 'instructor_schedule_state.dart';

@injectable
class InstructorScheduleCubit
    extends
        AppCoreCoreCubit<
          InstructorScheduleState,
          InstructorScheduleDashboardEntity
        > {
  InstructorScheduleCubit(this._loadScheduleUseCase)
    : super(const InstructorScheduleState());

  final LoadInstructorScheduleUseCase _loadScheduleUseCase;
  int _loadGeneration = 0;
  DateTime _selectedDate = DateTime.now();

  @override
  ApiState<InstructorScheduleDashboardEntity> getApiState(
    InstructorScheduleState state,
  ) => state.apiState;

  @override
  InstructorScheduleState setApiState(
    InstructorScheduleState state,
    ApiState<InstructorScheduleDashboardEntity> apiState,
  ) => state.copyWith(apiState: apiState);

  Future<void> load({
    DateTime? date,
    InstructorBookingsViewMode? viewMode,
    bool silent = false,
  }) async {
    final generation = ++_loadGeneration;
    final selectedDate = date ?? _selectedDate;
    final selectedViewMode = viewMode ?? state.viewMode;
    _selectedDate = selectedDate;
    if (silent) {
      emit(state.copyWith(isSilentRefresh: true, viewMode: selectedViewMode));
    } else {
      emit(
        state.copyWith(
          isSilentRefresh: false,
          viewMode: selectedViewMode,
          apiState: const ApiState<InstructorScheduleDashboardEntity>.loading(),
        ),
      );
    }

    final result = await _loadScheduleUseCase(selectedDate, selectedViewMode);

    if (!isActiveGeneration(
      capturedGeneration: generation,
      currentGeneration: _loadGeneration,
    )) {
      return;
    }

    result.fold(
      (failure) => emit(
        state.copyWith(
          isSilentRefresh: false,
          apiState: ApiState<InstructorScheduleDashboardEntity>.failed(
            failure,
            retryFunction: () => load(
              date: selectedDate,
              viewMode: selectedViewMode,
              silent: silent,
            ),
          ),
        ),
      ),
      (dashboard) => emit(
        state.copyWith(
          isSilentRefresh: false,
          apiState: ApiState<InstructorScheduleDashboardEntity>.succeeded(
            dashboard,
          ),
        ),
      ),
    );
  }

  Future<void> selectDate(DateTime date) => load(date: date);

  Future<void> setViewMode(InstructorBookingsViewMode mode) {
    if (mode == state.viewMode) return Future.value();
    return load(date: _selectedDate, viewMode: mode);
  }

  @override
  Future<void> close() {
    _loadGeneration++;
    return super.close();
  }
}
