import 'package:coore/lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/use_cases/instructor_use_cases.dart';

part 'instructor_profile_cubit.freezed.dart';
part 'instructor_profile_state.dart';

@injectable
class InstructorProfileCubit
    extends
        AppCoreCoreCubit<
          InstructorProfileState,
          InstructorProfileDashboardEntity
        > {
  InstructorProfileCubit(this._loadProfileUseCase)
    : super(const InstructorProfileState());

  final LoadInstructorProfileUseCase _loadProfileUseCase;
  int _loadGeneration = 0;

  @override
  ApiState<InstructorProfileDashboardEntity> getApiState(
    InstructorProfileState state,
  ) => state.apiState;

  @override
  InstructorProfileState setApiState(
    InstructorProfileState state,
    ApiState<InstructorProfileDashboardEntity> apiState,
  ) => state.copyWith(apiState: apiState);

  Future<void> load({bool silent = false}) async {
    final generation = ++_loadGeneration;
    if (silent) {
      emit(state.copyWith(isSilentRefresh: true));
    } else {
      // Skip the loading skeleton when a fresh cache can answer immediately.
      final hasSucceededData = state.apiState.maybeWhen(
        succeeded: (_) => true,
        orElse: () => false,
      );
      if (!hasSucceededData) {
        emit(
          state.copyWith(
            isSilentRefresh: false,
            apiState:
                const ApiState<InstructorProfileDashboardEntity>.loading(),
          ),
        );
      }
    }

    // Silent resume forces a network refresh; initial loads prefer fresh cache.
    final result = await _loadProfileUseCase(forceRefresh: silent);

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
          apiState: ApiState<InstructorProfileDashboardEntity>.failed(
            failure,
            retryFunction: () => load(silent: silent),
          ),
        ),
      ),
      (dashboard) => emit(
        state.copyWith(
          isSilentRefresh: false,
          apiState: ApiState<InstructorProfileDashboardEntity>.succeeded(
            dashboard,
          ),
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
