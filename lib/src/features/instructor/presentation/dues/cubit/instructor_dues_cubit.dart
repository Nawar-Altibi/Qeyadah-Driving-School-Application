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
    this.visibleDues = const [],
  });

  final ApiState<InstructorDuesEntity> apiState;
  final InstructorDuesSortOrder sortOrder;

  /// Sorted copy ready for the list UI; updated when dues or [sortOrder] change.
  final List<InstructorDueDayEntity> visibleDues;

  InstructorDuesState copyWith({
    ApiState<InstructorDuesEntity>? apiState,
    InstructorDuesSortOrder? sortOrder,
    List<InstructorDueDayEntity>? visibleDues,
  }) => InstructorDuesState(
    apiState: apiState ?? this.apiState,
    sortOrder: sortOrder ?? this.sortOrder,
    visibleDues: visibleDues ?? this.visibleDues,
  );

  static List<InstructorDueDayEntity> sortDues(
    List<InstructorDueDayEntity> dues,
    InstructorDuesSortOrder sortOrder,
  ) {
    final sorted = [...dues]
      ..sort((a, b) {
        final compare = a.expenseDate.compareTo(b.expenseDate);
        return sortOrder == InstructorDuesSortOrder.oldestFirst
            ? compare
            : -compare;
      });
    return sorted;
  }
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
      (dues) => emit(
        state.copyWith(
          apiState: ApiState.succeeded(dues),
          visibleDues: InstructorDuesState.sortDues(dues.dues, state.sortOrder),
        ),
      ),
    );
  }

  void toggleSortOrder() {
    final next = state.sortOrder == InstructorDuesSortOrder.newestFirst
        ? InstructorDuesSortOrder.oldestFirst
        : InstructorDuesSortOrder.newestFirst;
    final dues = state.apiState.maybeWhen(
      succeeded: (data) => data.dues,
      orElse: () => const <InstructorDueDayEntity>[],
    );
    emit(
      state.copyWith(
        sortOrder: next,
        visibleDues: InstructorDuesState.sortDues(dues, next),
      ),
    );
  }
}
