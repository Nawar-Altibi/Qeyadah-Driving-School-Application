import 'package:coore/lib.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/use_cases/instructor_use_cases.dart';

class InstructorNotificationsState {
  const InstructorNotificationsState({
    this.apiState = const ApiState<InstructorNotificationsPageEntity>.initial(),
    this.isLoadingMore = false,
  });

  final ApiState<InstructorNotificationsPageEntity> apiState;
  final bool isLoadingMore;

  InstructorNotificationsState copyWith({
    ApiState<InstructorNotificationsPageEntity>? apiState,
    bool? isLoadingMore,
  }) => InstructorNotificationsState(
    apiState: apiState ?? this.apiState,
    isLoadingMore: isLoadingMore ?? this.isLoadingMore,
  );
}

@injectable
class InstructorNotificationsCubit
    extends
        AppCoreCoreCubit<
          InstructorNotificationsState,
          InstructorNotificationsPageEntity
        > {
  InstructorNotificationsCubit(this._loadNotificationsUseCase)
    : super(const InstructorNotificationsState());

  final LoadInstructorNotificationsUseCase _loadNotificationsUseCase;

  @override
  ApiState<InstructorNotificationsPageEntity> getApiState(
    InstructorNotificationsState state,
  ) => state.apiState;

  @override
  InstructorNotificationsState setApiState(
    InstructorNotificationsState state,
    ApiState<InstructorNotificationsPageEntity> apiState,
  ) => state.copyWith(apiState: apiState);

  Future<void> load() async {
    emit(
      state.copyWith(apiState: const ApiState.loading(), isLoadingMore: false),
    );
    final result = await _loadNotificationsUseCase();
    result.fold(
      (failure) => emit(
        state.copyWith(apiState: ApiState.failed(failure, retryFunction: load)),
      ),
      (page) => emit(state.copyWith(apiState: ApiState.succeeded(page))),
    );
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
    final result = await _loadNotificationsUseCase(page: current.page + 1);
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
}
