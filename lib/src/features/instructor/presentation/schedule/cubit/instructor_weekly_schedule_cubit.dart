import 'package:coore/lib.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/use_cases/instructor_use_cases.dart';

class InstructorWeeklyScheduleState {
  const InstructorWeeklyScheduleState({
    this.apiState = const ApiState<List<InstructorScheduleDayEntity>>.initial(),
  });

  final ApiState<List<InstructorScheduleDayEntity>> apiState;

  InstructorWeeklyScheduleState copyWith({
    ApiState<List<InstructorScheduleDayEntity>>? apiState,
  }) => InstructorWeeklyScheduleState(apiState: apiState ?? this.apiState);
}

@injectable
class InstructorWeeklyScheduleCubit
    extends
        AppCoreCoreCubit<
          InstructorWeeklyScheduleState,
          List<InstructorScheduleDayEntity>
        > {
  InstructorWeeklyScheduleCubit(this._loadWeeklyScheduleUseCase)
    : super(const InstructorWeeklyScheduleState());

  final LoadInstructorWeeklyScheduleUseCase _loadWeeklyScheduleUseCase;

  @override
  ApiState<List<InstructorScheduleDayEntity>> getApiState(
    InstructorWeeklyScheduleState state,
  ) => state.apiState;

  @override
  InstructorWeeklyScheduleState setApiState(
    InstructorWeeklyScheduleState state,
    ApiState<List<InstructorScheduleDayEntity>> apiState,
  ) => state.copyWith(apiState: apiState);

  Future<void> load({bool forceRefresh = false}) async {
    final hasSucceededData = state.apiState.maybeWhen(
      succeeded: (_) => true,
      orElse: () => false,
    );
    // Skip the skeleton when a fresh cache can answer immediately.
    if (!hasSucceededData) {
      emit(state.copyWith(apiState: const ApiState.loading()));
    }
    final result = await _loadWeeklyScheduleUseCase(forceRefresh: forceRefresh);
    result.fold(
      (failure) => emit(
        state.copyWith(
          apiState: ApiState.failed(
            failure,
            retryFunction: () => load(forceRefresh: forceRefresh),
          ),
        ),
      ),
      (schedule) =>
          emit(state.copyWith(apiState: ApiState.succeeded(schedule))),
    );
  }

  Future<void> refresh() => load(forceRefresh: true);
}
