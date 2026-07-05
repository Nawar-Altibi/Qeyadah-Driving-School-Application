import 'package:coore/src/api_handler/form_data_file_adapter.dart';
import 'package:dio/dio.dart';

/// Abstract adapter for creating multipart/form-data.
///
/// Holds the request body internally and exposes a single create() method.
abstract class FormDataAdapter {
  /// Internal representation of body data.
  final Map<String, dynamic> _body;

  /// Accepts the raw body map on construction.
  const FormDataAdapter(this._body);

  /// Builds a [FormData] from the internal body.
  FormData create();
}

/// Default implementation: wraps Dio's FormData.fromMap directly.
class DefaultFormDataAdapter extends FormDataAdapter {
  const DefaultFormDataAdapter(super.body);

  @override
  FormData create() {
    return FormData.fromMap(_body);
  }
}

/// Custom multipart adapter: handles files and fields explicitly.
class MultipartFormDataAdapter extends FormDataAdapter {
  const MultipartFormDataAdapter(super.body);

  @override
  FormData create() {
    final form = FormData();

    _body.forEach((key, value) {
      final files = multipartFilesFromValue(key, value);
      if (files.isNotEmpty) {
        form.files.addAll(files);
      } else {
        // Primitive or other types
        form.fields.add(MapEntry(key, value.toString()));
      }
    });

    return form;
  }
}

/// Usage example:
///
/// final body = {
///   'name': 'John',
///   'profile_pic': platform file object,
///   'attachments': [platform file object],
/// };
/// final adapter = MultipartFormDataAdapter(body);
/// final formData = adapter.create();
///
/// dio.post('/upload', data: formData);
