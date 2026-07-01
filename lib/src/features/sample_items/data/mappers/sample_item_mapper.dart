import 'package:qeyadah_mobile_app/src/features/sample_items/data/models/sample_item_model.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/domain/entities/sample_item_entity.dart';

SampleItemEntity sampleItemModelToEntity(SampleItemModel model) {
  return SampleItemEntity(
    id: model.id,
    title: model.title,
    body: model.body,
    userId: model.userId,
  );
}
