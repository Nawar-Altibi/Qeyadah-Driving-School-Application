import 'package:coore/lib.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/use_cases/instructor_use_cases.dart';

enum InstructorDuesSortOrder { newestFirst, oldestFirst }

class InstructorDuesState {
  const InstructorDuesState({
    this.apiState = const ApiState<InstructorDuesEntity>.initial(),
    this.sortOrder = InstructorDuesSortOrder.newestFirst,
  });

  final ApiState<InstructorDuesEntity> apiState;
  final InstructorDuesSortOrder sortOrder;

  InstructorDuesState copyWith({
    ApiState<InstructorDuesEntity>? apiState,
    InstructorDuesSortOrder? sortOrder,
  }) => InstructorDuesState(
    apiState: apiState ?? this.apiState,
    sortOrder: sortOrder ?? this.sortOrder,
  );
}

@injectable
class InstructorDuesCubit
    extends AppCoreCoreCubit<InstructorDuesState, InstructorDuesEntity> {
  InstructorDuesCubit(this._loadDuesUseCase)
    : super(const InstructorDuesState());

  final LoadInstructorDuesUseCase _loadDuesUseCase;

  @override
  ApiState<InstructorDuesEntity> getApiState(InstructorDuesState state) =>
      state.apiState;

  @override
  InstructorDuesState setApiState(
    InstructorDuesState state,
    ApiState<InstructorDuesEntity> apiState,
  ) => state.copyWith(apiState: apiState);

  Future<void> load() async {
    emit(state.copyWith(apiState: const ApiState.loading()));
    final result = await _loadDuesUseCase();
    result.fold(
      (failure) => emit(
        state.copyWith(apiState: ApiState.failed(failure, retryFunction: load)),
      ),
      (dues) => emit(state.copyWith(apiState: ApiState.succeeded(dues))),
    );
  }

  void toggleSortOrder() {
    final next = state.sortOrder == InstructorDuesSortOrder.newestFirst
        ? InstructorDuesSortOrder.oldestFirst
        : InstructorDuesSortOrder.newestFirst;
    emit(state.copyWith(sortOrder: next));
  }
}
