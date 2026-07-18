import 'package:coore/lib.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/domain/entities/sample_item_entity.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/domain/repositories/sample_items_repository.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/domain/use_cases/sample_items_use_cases.dart';

part 'sample_items_cubit.freezed.dart';
part 'sample_items_effect.dart';
part 'sample_items_state.dart';

@injectable
class SampleItemsCubit
    extends AppCoreCoreCubit<SampleItemsState, List<SampleItemEntity>> {
  SampleItemsCubit(this._loadSampleItemsUseCase)
    : super(const SampleItemsState());

  final LoadSampleItemsUseCase _loadSampleItemsUseCase;
  int _loadGeneration = 0;

  @override
  ApiState<List<SampleItemEntity>> getApiState(SampleItemsState state) =>
      state.apiState;

  @override
  SampleItemsState setApiState(
    SampleItemsState state,
    ApiState<List<SampleItemEntity>> apiState,
  ) => state.copyWith(apiState: apiState);

  Future<void> load({bool silent = false}) async {
    final generation = ++_loadGeneration;
    if (!silent) {
      emit(state.copyWith(isSilentRefresh: false));
    } else {
      emit(state.copyWith(isSilentRefresh: true));
    }

    final result = await _loadSampleItemsUseCase(const LoadSampleItemsParams());

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
          apiState: ApiState<List<SampleItemEntity>>.failed(
            failure,
            retryFunction: () => load(silent: silent),
          ),
        ),
      ),
      (items) => emit(
        state.copyWith(
          isSilentRefresh: false,
          apiState: ApiState<List<SampleItemEntity>>.succeeded(items),
        ),
      ),
    );
  }

  void clearEffect() {
    emit(state.copyWith(effect: null));
  }

  @override
  Future<void> close() {
    _loadGeneration++;
    return super.close();
  }
}

@injectable
class SampleItemDetailsCubit
    extends AppCoreCoreCubit<SampleItemDetailsState, SampleItemEntity> {
  SampleItemDetailsCubit(this._getSampleItemUseCase)
    : super(const SampleItemDetailsState());

  final GetSampleItemUseCase _getSampleItemUseCase;
  int _loadGeneration = 0;

  @override
  ApiState<SampleItemEntity> getApiState(SampleItemDetailsState state) =>
      state.apiState;

  @override
  SampleItemDetailsState setApiState(
    SampleItemDetailsState state,
    ApiState<SampleItemEntity> apiState,
  ) => state.copyWith(apiState: apiState);

  Future<void> load(String id) async {
    final generation = ++_loadGeneration;
    emit(state.copyWith(apiState: const ApiState<SampleItemEntity>.loading()));

    final result = await _getSampleItemUseCase(GetSampleItemParams(id: id));

    if (!isActiveGeneration(
      capturedGeneration: generation,
      currentGeneration: _loadGeneration,
    )) {
      return;
    }

    result.fold(
      (failure) => emit(
        state.copyWith(
          apiState: ApiState<SampleItemEntity>.failed(
            failure,
            retryFunction: () => load(id),
          ),
        ),
      ),
      (item) => emit(
        state.copyWith(apiState: ApiState<SampleItemEntity>.succeeded(item)),
      ),
    );
  }

  @override
  Future<void> close() {
    _loadGeneration++;
    return super.close();
  }
}
