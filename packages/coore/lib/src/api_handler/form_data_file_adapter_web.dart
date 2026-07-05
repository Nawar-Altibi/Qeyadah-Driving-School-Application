import 'package:dio/dio.dart';

List<MapEntry<String, MultipartFile>> multipartFilesFromValue(
  String key,
  Object? value,
) {
  if (value is MultipartFile) {
    return [MapEntry(key, value)];
  }

  if (value is List<MultipartFile>) {
    return value.map((file) => MapEntry(key, file)).toList();
  }

  return const [];
}
