import 'package:qeyadah_mobile_app/src/shared/enums/certificate_category.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/certificate_request_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/exam_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';

/// Flexible JSON helpers for certificate payloads.
///
/// Backend bigint ids often arrive as strings, but some live responses still
/// emit numbers. Keep domain ids as [String] always.
abstract final class CertificateJsonParsers {
  static Map<String, dynamic> unwrapApiData(Map<String, dynamic> json) {
    final data = json['data'];
    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }
    return json;
  }

  static String? parseCertificateId(Object? raw) {
    if (raw == null) return null;
    final value = raw.toString().trim();
    if (value.isEmpty || value == 'null') return null;
    return value;
  }

  static int? parseCourseNumber(Object? raw) {
    if (raw == null) return null;
    if (raw is num) return raw.toInt();
    final trimmed = raw.toString().trim();
    if (trimmed.isEmpty || trimmed == 'null') return null;
    return int.tryParse(trimmed);
  }

  static int parseFee(Object? raw, {int fallback = 0}) {
    if (raw == null) return fallback;
    if (raw is num) return raw.toInt();
    return int.tryParse(raw.toString().trim()) ?? fallback;
  }

  static double? parseMoney(Object? raw) {
    if (raw == null) return null;
    if (raw is num) return raw.toDouble();
    return double.tryParse(raw.toString().trim());
  }

  static DateTime? parseDateTime(Object? raw) {
    if (raw == null) return null;
    return DateTime.tryParse(raw.toString());
  }

  static List<TrainingType> parseTransmissionTypes(Object? raw) {
    if (raw is! Iterable) return const [];
    return raw
        .map((item) => TrainingType.fromApi(item?.toString()))
        .whereType<TrainingType>()
        .toList(growable: false);
  }

  static List<CertificateCategory> parseCategories(Object? raw) {
    if (raw is! Iterable) return const [];
    return raw
        .map((item) => CertificateCategory.fromApi(item?.toString()))
        .whereType<CertificateCategory>()
        .toList(growable: false);
  }

  static CertificateRequestStatus? parseRequestStatus(Object? raw) {
    return CertificateRequestStatus.fromApi(raw?.toString());
  }

  static ExamType? parseExamType(Object? raw) {
    return ExamType.fromApi(raw?.toString());
  }
}
