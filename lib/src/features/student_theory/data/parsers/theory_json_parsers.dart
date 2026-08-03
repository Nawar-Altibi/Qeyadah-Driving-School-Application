import 'package:qeyadah_mobile_app/src/features/student_certificates/data/parsers/certificate_json_parsers.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/domain/entities/theory_question_entity.dart';

abstract final class TheoryJsonParsers {
  static List<TheoryQuestionEntity> parseQuestions(Object? raw) {
    final list = _unwrapList(raw);
    return list
        .map((item) => parseQuestion(Map<String, dynamic>.from(item as Map)))
        .toList(growable: false);
  }

  static TheoryQuestionEntity parseQuestion(Map<String, dynamic> json) {
    final correct =
        TheoryCorrectOption.fromApi(json['correctOption']?.toString()) ??
        TheoryCorrectOption.a;
    return TheoryQuestionEntity(
      id: CertificateJsonParsers.parseInt(json['id']),
      category: TheoryQuestionCategory.fromApi(json['category']?.toString()),
      questionText: json['questionText']?.toString().trim() ?? '',
      imageUrl: CertificateJsonParsers.resolveDocumentUrl(json['imageUrl']),
      optionA: json['optionA']?.toString().trim() ?? '',
      optionB: json['optionB']?.toString().trim() ?? '',
      optionC: _nullableText(json['optionC']),
      optionD: _nullableText(json['optionD']),
      correctOption: correct,
      explanation: _nullableText(json['explanation']),
    );
  }

  static List<dynamic> _unwrapList(Object? raw) {
    if (raw is List) return raw;
    if (raw is Map) {
      final data = raw['data'];
      if (data is List) return data;
      if (data is Map && data['data'] is List) {
        return data['data'] as List;
      }
    }
    throw const FormatException('Invalid theory self-test response');
  }

  static String? _nullableText(Object? raw) {
    final value = raw?.toString().trim();
    if (value == null || value.isEmpty || value == 'null') return null;
    return value;
  }
}
