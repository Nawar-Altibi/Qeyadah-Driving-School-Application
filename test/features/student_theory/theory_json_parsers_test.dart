import 'package:flutter_test/flutter_test.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/data/parsers/theory_json_parsers.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/domain/entities/theory_question_entity.dart';

void main() {
  group('TheoryJsonParsers', () {
    test('parses bare list of questions', () {
      final questions = TheoryJsonParsers.parseQuestions([
        {
          'id': 1,
          'category': 'SAFETY',
          'questionText': 'What should you do?',
          'optionA': 'A1',
          'optionB': 'B1',
          'optionC': 'C1',
          'optionD': 'D1',
          'correctOption': 'B',
          'explanation': 'Because B',
          'imageUrl': null,
        },
      ]);

      expect(questions, hasLength(1));
      final question = questions.first;
      expect(question.id, 1);
      expect(question.category, TheoryQuestionCategory.safety);
      expect(question.questionText, 'What should you do?');
      expect(question.correctOption, TheoryCorrectOption.b);
      expect(question.explanation, 'Because B');
      expect(question.options, hasLength(4));
    });

    test('unwraps {data: [...]} envelope and keeps absolute image urls', () {
      final questions = TheoryJsonParsers.parseQuestions({
        'statusCode': 200,
        'data': [
          {
            'id': '12',
            'category': 'MECHANICS',
            'questionText': 'Engine question',
            'optionA': 'A',
            'optionB': 'B',
            'correctOption': 'A',
            'imageUrl': 'https://cdn.example.com/theory/engine.png',
          },
        ],
      });

      expect(questions, hasLength(1));
      expect(questions.first.category, TheoryQuestionCategory.mechanics);
      expect(questions.first.optionC, isNull);
      expect(
        questions.first.imageUrl,
        'https://cdn.example.com/theory/engine.png',
      );
    });

    test('maps unknown categories and invalid correctOption safely', () {
      final question = TheoryJsonParsers.parseQuestion({
        'id': 3,
        'category': 'OTHER',
        'questionText': 'Q',
        'optionA': 'A',
        'optionB': 'B',
        'correctOption': 'Z',
      });

      expect(question.category, TheoryQuestionCategory.unknown);
      expect(question.correctOption, TheoryCorrectOption.a);
    });
  });
}
