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
    extends
        AppCoreCoreCubit<InstructorLeaveState, List<InstructorLeaveEntity>> {
  InstructorLeaveCubit(this._loadLeavesUseCase)
    : super(
        const InstructorLeaveState(
          apiState: ApiState<List<InstructorLeaveEntity>>.initial(),
        ),
      );

  final LoadInstructorLeavesUseCase _loadLeavesUseCase;
  int _loadGeneration = 0;

  @override
  ApiState<List<InstructorLeaveEntity>> getApiState(
    InstructorLeaveState state,
  ) => state.apiState;

  @override
  InstructorLeaveState setApiState(
    InstructorLeaveState state,
    ApiState<List<InstructorLeaveEntity>> apiState,
  ) => state.copyWith(apiState: apiState);

  Future<void> load() async {
    final generation = ++_loadGeneration;

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
          apiState: ApiState<List<InstructorLeaveEntity>>.failed(
            failure,
            retryFunction: load,
          ),
        ),
      ),
      (leaves) => emit(
        state.copyWith(
          apiState: ApiState<List<InstructorLeaveEntity>>.succeeded(leaves),
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _loadGeneration++;
    return super.close();
  }
}
