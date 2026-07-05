import 'package:coore/lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/use_cases/instructor_use_cases.dart';

part 'instructor_schedule_cubit.freezed.dart';
part 'instructor_schedule_state.dart';

@injectable
class InstructorScheduleCubit
    extends AppCoreCoreCubit<InstructorScheduleState, InstructorScheduleDashboardEntity> {
  InstructorScheduleCubit(this._loadScheduleUseCase)
    : super(const InstructorScheduleState());

  final LoadInstructorScheduleUseCase _loadScheduleUseCase;
  int _loadGeneration = 0;

  @override
  ApiState<InstructorScheduleDashboardEntity> getApiState(
    InstructorScheduleState state,
  ) => state.apiState;

  @override
  InstructorScheduleState setApiState(
    InstructorScheduleState state,
    ApiState<InstructorScheduleDashboardEntity> apiState,
  ) => state.copyWith(apiState: apiState);

  Future<void> load({DateTime? date, bool silent = false}) async {
    final generation = ++_loadGeneration;
    final selectedDate = date ?? DateTime.now();
    emit(state.copyWith(isSilentRefresh: silent));

    final result = await _loadScheduleUseCase(selectedDate);

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
            retryFunction: () => load(date: selectedDate, silent: silent),
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

  @override
  Future<void> close() {
    _loadGeneration++;
    return super.close();
  }
}
