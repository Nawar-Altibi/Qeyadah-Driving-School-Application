part of 'sample_items_cubit.dart';

@freezed
abstract class SampleItemsState with _$SampleItemsState {
  const factory SampleItemsState({
    @Default(ApiState<List<SampleItemEntity>>.initial())
    ApiState<List<SampleItemEntity>> apiState,
    @Default(false) bool isSilentRefresh,
    SampleItemsEffect? effect,
  }) = _SampleItemsState;
}

@freezed
abstract class SampleItemDetailsState with _$SampleItemDetailsState {
  const factory SampleItemDetailsState({
    @Default(ApiState<SampleItemEntity>.initial())
    ApiState<SampleItemEntity> apiState,
  }) = _SampleItemDetailsState;
}
