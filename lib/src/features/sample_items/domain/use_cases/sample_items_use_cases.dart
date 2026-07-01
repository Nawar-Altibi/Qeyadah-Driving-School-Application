import 'package:coore/lib.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/domain/entities/sample_item_entity.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/domain/repositories/sample_items_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoadSampleItemsUseCase
    extends FutureEitherUseCase<List<SampleItemEntity>, LoadSampleItemsParams> {
  LoadSampleItemsUseCase(this._repository);

  final SampleItemsRepository _repository;

  @override
  FutureEither<List<SampleItemEntity>> call(LoadSampleItemsParams params) {
    return _repository.loadItems(params);
  }
}

@lazySingleton
class GetSampleItemUseCase
    extends FutureEitherUseCase<SampleItemEntity, GetSampleItemParams> {
  GetSampleItemUseCase(this._repository);

  final SampleItemsRepository _repository;

  @override
  FutureEither<SampleItemEntity> call(GetSampleItemParams params) {
    return _repository.getItem(params);
  }
}
