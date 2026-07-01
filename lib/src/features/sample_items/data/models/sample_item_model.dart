import 'package:json_annotation/json_annotation.dart';

part 'sample_item_model.g.dart';

@JsonSerializable()
class SampleItemModel {
  const SampleItemModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory SampleItemModel.fromJson(Map<String, dynamic> json) =>
      _$SampleItemModelFromJson(json);

  final String id;
  final String title;
  final String body;

  @JsonKey(name: 'userId')
  final int userId;

  Map<String, dynamic> toJson() => _$SampleItemModelToJson(this);
}
