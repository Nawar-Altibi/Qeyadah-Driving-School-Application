import 'dart:io';

import 'package:dio/dio.dart';

List<MapEntry<String, MultipartFile>> multipartFilesFromValue(
  String key,
  Object? value,
) {
  if (value is File) {
    return [MapEntry(key, MultipartFile.fromFileSync(value.path))];
  }

  if (value is List<File>) {
    return value
        .map((file) => MapEntry(key, MultipartFile.fromFileSync(file.path)))
        .toList();
  }

  return const [];
}
