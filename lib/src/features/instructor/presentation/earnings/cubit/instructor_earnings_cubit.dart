import 'package:coore/lib.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/use_cases/instructor_use_cases.dart';

enum InstructorEarningsViewMode { day, month }

class InstructorEarningsState {
  const InstructorEarningsState({
    this.apiState = const ApiState<InstructorEarningsEntity>.initial(),
    this.viewMode = InstructorEarningsViewMode.day,
    required this.selectedDate,
  });

  factory InstructorEarningsState.initial() =>
      InstructorEarningsState(selectedDate: DateTime.now());

  final ApiState<InstructorEarningsEntity> apiState;
  final InstructorEarningsViewMode viewMode;
  final DateTime selectedDate;

  InstructorEarningsState copyWith({
    ApiState<InstructorEarningsEntity>? apiState,
    InstructorEarningsViewMode? viewMode,
    DateTime? selectedDate,
  }) => InstructorEarningsState(
    apiState: apiState ?? this.apiState,
    viewMode: viewMode ?? this.viewMode,
    selectedDate: selectedDate ?? this.selectedDate,
  );
}

@injectable
class InstructorEarningsCubit
    extends
        AppCoreCoreCubit<InstructorEarningsState, InstructorEarningsEntity> {
  InstructorEarningsCubit(this._loadEarningsUseCase)
    : super(InstructorEarningsState.initial());

  final LoadInstructorEarningsUseCase _loadEarningsUseCase;

  @override
  ApiState<InstructorEarningsEntity> getApiState(
    InstructorEarningsState state,
  ) => state.apiState;

  @override
  InstructorEarningsState setApiState(
    InstructorEarningsState state,
    ApiState<InstructorEarningsEntity> apiState,
  ) => state.copyWith(apiState: apiState);

  Future<void> load() async {
    emit(state.copyWith(apiState: const ApiState.loading()));
    final result = switch (state.viewMode) {
      InstructorEarningsViewMode.day => _loadEarningsUseCase.forDate(
        state.selectedDate,
      ),
      InstructorEarningsViewMode.month => _loadEarningsUseCase.forMonth(
        DateFormat('yyyy-MM').format(state.selectedDate),
      ),
    };
    final earnings = await result;
    earnings.fold(
      (failure) => emit(
        state.copyWith(apiState: ApiState.failed(failure, retryFunction: load)),
      ),
      (value) => emit(state.copyWith(apiState: ApiState.succeeded(value))),
    );
  }

  Future<void> setViewMode(InstructorEarningsViewMode viewMode) async {
    if (state.viewMode == viewMode) return;
    emit(state.copyWith(viewMode: viewMode));
    await load();
  }

  Future<void> selectDate(DateTime date) async {
    emit(state.copyWith(selectedDate: date));
    await load();
  }
}
