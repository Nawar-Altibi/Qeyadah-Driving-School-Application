// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SampleItemModel _$SampleItemModelFromJson(Map<String, dynamic> json) =>
    SampleItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      userId: (json['userId'] as num).toInt(),
    );

Map<String, dynamic> _$SampleItemModelToJson(SampleItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'body': instance.body,
      'userId': instance.userId,
    };
