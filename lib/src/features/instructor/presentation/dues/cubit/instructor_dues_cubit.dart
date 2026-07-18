import 'package:coore/lib.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/use_cases/instructor_use_cases.dart';

class InstructorDuesState {
  const InstructorDuesState({
    this.apiState = const ApiState<InstructorDuesEntity>.initial(),
  });

  final ApiState<InstructorDuesEntity> apiState;

  InstructorDuesState copyWith({ApiState<InstructorDuesEntity>? apiState}) =>
      InstructorDuesState(apiState: apiState ?? this.apiState);
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
}
