import 'package:coore/lib.dart';

abstract final class EnvironmentVariables {
  static String get apiBaseUrl =>
      _normalizedApiBaseUrl(getIt<EnvironmentConfig>().getString('BASE_URL'));

  static bool get enableOfflineQueue =>
      getIt<EnvironmentConfig>().getString('ENABLE_OFFLINE_QUEUE') == 'true';

  static String _normalizedApiBaseUrl(String rawBaseUrl) {
    final trimmed = rawBaseUrl.trim();
    if (trimmed.isEmpty) return trimmed;
    return trimmed.replaceAll(RegExp(r'/+$'), '');
  }
}
