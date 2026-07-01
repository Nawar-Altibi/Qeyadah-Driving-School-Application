
import 'package:freezed_annotation/freezed_annotation.dart';

part 'error_response_model.freezed.dart';
part 'error_response_model.g.dart';

@freezed
abstract class ErrorResponseModel with _$ErrorResponseModel {
  const factory ErrorResponseModel({
    @Default('') String message,
    @JsonKey(
      name: 'errors',
      fromJson: _mapErrorList,

      defaultValue: <String, String>{},
    )
    required Map<String, String> errorsMap,
  }) = _ErrorResponseModel;

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseModelFromJson(json);
}

// Extract your custom logic into a top‐level helper:
Map<String, String> _mapErrorList(dynamic json) {
  if (json is List) return <String, String>{};
  return Map<String, String>.from(json as Map);
}
