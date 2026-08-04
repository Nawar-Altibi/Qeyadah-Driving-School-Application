import 'package:coore/lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/entities/student_home_dashboard_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/repositories/student_home_repository.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/use_cases/load_student_home_use_case.dart';

part 'student_home_cubit.freezed.dart';
part 'student_home_state.dart';

@injectable
class StudentHomeCubit
    extends AppCoreCoreCubit<StudentHomeState, StudentHomeDashboardEntity> {
  StudentHomeCubit(this._loadStudentHomeUseCase)
    : super(const StudentHomeState());

  final LoadStudentHomeUseCase _loadStudentHomeUseCase;
  int _loadGeneration = 0;

  @override
  ApiState<StudentHomeDashboardEntity> getApiState(StudentHomeState state) =>
      state.apiState;

  @override
  StudentHomeState setApiState(
    StudentHomeState state,
    ApiState<StudentHomeDashboardEntity> apiState,
  ) => state.copyWith(apiState: apiState);

  Future<void> load({bool silent = false}) async {
    final generation = ++_loadGeneration;
    emit(state.copyWith(isSilentRefresh: silent));

    final result = await _loadStudentHomeUseCase(
      LoadStudentHomeParams(forceRefresh: silent),
    );

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
          apiState: ApiState<StudentHomeDashboardEntity>.failed(
            failure,
            retryFunction: () => load(silent: silent),
          ),
        ),
      ),
      (dashboard) => emit(
        state.copyWith(
          isSilentRefresh: false,
          apiState: ApiState<StudentHomeDashboardEntity>.succeeded(dashboard),
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
