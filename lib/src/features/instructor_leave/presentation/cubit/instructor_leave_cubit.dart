import 'package:coore/lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/use_cases/instructor_use_cases.dart';

part 'instructor_leave_cubit.freezed.dart';
part 'instructor_leave_state.dart';

@injectable
class InstructorLeaveCubit
    extends AppCoreCoreCubit<InstructorLeaveState, List<InstructorLeaveEntity>> {
  InstructorLeaveCubit(this._loadLeavesUseCase, this._loadDayBookingsUseCase)
    : super(const InstructorLeaveState());

  final LoadInstructorLeavesUseCase _loadLeavesUseCase;
  final LoadInstructorDayBookingsUseCase _loadDayBookingsUseCase;
  int _loadGeneration = 0;

  @override
  ApiState<List<InstructorLeaveEntity>> getApiState(InstructorLeaveState state) =>
      state.apiState;

  @override
  InstructorLeaveState setApiState(
    InstructorLeaveState state,
    ApiState<List<InstructorLeaveEntity>> apiState,
  ) => state.copyWith(apiState: apiState);

  Future<void> load({bool silent = false}) async {
    final generation = ++_loadGeneration;
    emit(state.copyWith(isSilentRefresh: silent));

    final result = await _loadLeavesUseCase();

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
          apiState: ApiState<List<InstructorLeaveEntity>>.failed(
            failure,
            retryFunction: () => load(silent: silent),
          ),
        ),
      ),
      (leaves) => emit(
        state.copyWith(
          isSilentRefresh: false,
          apiState: ApiState<List<InstructorLeaveEntity>>.succeeded(leaves),
        ),
      ),
    );
  }

  void setLeaveFilter({required bool fullDay}) {
    emit(state.copyWith(showFullDayOnly: fullDay));
  }

  Future<List<InstructorBookingEntity>> loadConflictsForDate(
    DateTime date,
  ) async {
    final result = await _loadDayBookingsUseCase(date);
    return result.getOrElse((_) => const []);
  }

  @override
  Future<void> close() {
    _loadGeneration++;
    return super.close();
  }
}
