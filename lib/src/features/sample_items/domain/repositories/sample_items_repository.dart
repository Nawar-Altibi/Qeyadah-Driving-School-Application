import 'package:coore/lib.dart';
import 'package:equatable/equatable.dart';
import 'package:qeyadah_mobile_app/src/core/typedefs/app_typedefs.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/domain/entities/sample_item_entity.dart';

class LoadSampleItemsParams extends Equatable implements Cancelable {
  const LoadSampleItemsParams({this.cancelRequestAdapter});

  @override
  final CancelRequestAdapter? cancelRequestAdapter;

  @override
  List<Object?> get props => [cancelRequestAdapter];

  @override
  LoadSampleItemsParams copyWithCancelRequest(CancelRequestAdapter adapter) {
    return LoadSampleItemsParams(cancelRequestAdapter: adapter);
  }
}

class GetSampleItemParams extends Equatable implements Cancelable {
  const GetSampleItemParams({required this.id, this.cancelRequestAdapter});

  final String id;
  @override
  final CancelRequestAdapter? cancelRequestAdapter;

  @override
  List<Object?> get props => [id, cancelRequestAdapter];

  @override
  GetSampleItemParams copyWithCancelRequest(CancelRequestAdapter adapter) {
    return GetSampleItemParams(id: id, cancelRequestAdapter: adapter);
  }
}

abstract interface class SampleItemsRepository {
  FutureEither<List<SampleItemEntity>> loadItems(LoadSampleItemsParams params);
  FutureEither<SampleItemEntity> getItem(GetSampleItemParams params);
}
