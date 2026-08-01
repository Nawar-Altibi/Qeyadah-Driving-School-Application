import 'package:coore/lib.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/use_cases/instructor_use_cases.dart';

enum InstructorInvoicesViewMode { day, month }

class InstructorInvoicesState {
  const InstructorInvoicesState({
    this.apiState = const ApiState<InstructorInvoicesPageEntity>.initial(),
    this.viewMode = InstructorInvoicesViewMode.month,
    required this.selectedDate,
    this.isLoadingMore = false,
  });

  factory InstructorInvoicesState.initial() =>
      InstructorInvoicesState(selectedDate: DateTime.now());

  final ApiState<InstructorInvoicesPageEntity> apiState;
  final InstructorInvoicesViewMode viewMode;
  final DateTime selectedDate;
  final bool isLoadingMore;

  InstructorInvoicesState copyWith({
    ApiState<InstructorInvoicesPageEntity>? apiState,
    InstructorInvoicesViewMode? viewMode,
    DateTime? selectedDate,
    bool? isLoadingMore,
  }) => InstructorInvoicesState(
    apiState: apiState ?? this.apiState,
    viewMode: viewMode ?? this.viewMode,
    selectedDate: selectedDate ?? this.selectedDate,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
  );
}

@injectable
class InstructorInvoicesCubit
    extends
        AppCoreCoreCubit<
          InstructorInvoicesState,
          InstructorInvoicesPageEntity
        > {
  InstructorInvoicesCubit(this._loadInvoicesUseCase)
    : super(InstructorInvoicesState.initial());

  final LoadInstructorInvoicesUseCase _loadInvoicesUseCase;

  @override
  ApiState<InstructorInvoicesPageEntity> getApiState(
    InstructorInvoicesState state,
  ) => state.apiState;

  @override
  InstructorInvoicesState setApiState(
    InstructorInvoicesState state,
    ApiState<InstructorInvoicesPageEntity> apiState,
  ) => state.copyWith(apiState: apiState);

  Future<void> load() async {
    emit(
      state.copyWith(apiState: const ApiState.loading(), isLoadingMore: false),
    );
    final result = await _fetchPage(page: 1);
    result.fold(
      (failure) => emit(
        state.copyWith(apiState: ApiState.failed(failure, retryFunction: load)),
      ),
      (page) => emit(state.copyWith(apiState: ApiState.succeeded(page))),
    );
  }

  Future<void> setViewMode(InstructorInvoicesViewMode viewMode) async {
    if (state.viewMode == viewMode) return;
    emit(state.copyWith(viewMode: viewMode));
    await load();
  }

  Future<void> selectDate(DateTime date) async {
    emit(state.copyWith(selectedDate: date));
    await load();
  }

  Future<void> loadMore() async {
    final current = state.apiState.maybeWhen(
      succeeded: (value) => value,
      orElse: () => null,
    );
    if (current == null || !current.hasMorePages || state.isLoadingMore) {
      return;
    }

    emit(state.copyWith(isLoadingMore: true));
    final result = await _fetchPage(page: current.page + 1);
    result.fold(
      (_) => emit(state.copyWith(isLoadingMore: false)),
      (nextPage) => emit(
        state.copyWith(
          isLoadingMore: false,
          apiState: ApiState.succeeded(current.appendPage(nextPage)),
        ),
      ),
    );
  }

  FutureEither<InstructorInvoicesPageEntity> _fetchPage({required int page}) {
    return switch (state.viewMode) {
      InstructorInvoicesViewMode.day => _loadInvoicesUseCase.forDate(
        state.selectedDate,
        page: page,
      ),
      InstructorInvoicesViewMode.month => _loadInvoicesUseCase.forMonth(
        DateFormat('yyyy-MM').format(state.selectedDate),
        page: page,
      ),
    };
  }
}
