import 'package:bloc_test/bloc_test.dart';
import 'package:coore/lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/domain/entities/theory_question_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/domain/use_cases/load_theory_self_test_use_case.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/presentation/cubit/student_theory_quiz_cubit.dart';

class MockLoadTheorySelfTestUseCase extends Mock
    implements LoadTheorySelfTestUseCase {}

TheoryQuestionEntity _q({
  required int id,
  required TheoryCorrectOption correct,
}) {
  return TheoryQuestionEntity(
    id: id,
    category: TheoryQuestionCategory.safety,
    questionText: 'Q$id',
    optionA: 'A',
    optionB: 'B',
    optionC: 'C',
    optionD: 'D',
    correctOption: correct,
    explanation: 'Explain $id',
  );
}

void main() {
  late MockLoadTheorySelfTestUseCase loadSelfTest;

  final questions = [
    _q(id: 1, correct: TheoryCorrectOption.a),
    _q(id: 2, correct: TheoryCorrectOption.b),
  ];

  setUp(() {
    loadSelfTest = MockLoadTheorySelfTestUseCase();
  });

  StudentTheoryQuizCubit buildCubit() => StudentTheoryQuizCubit(loadSelfTest);

  blocTest<StudentTheoryQuizCubit, StudentTheoryQuizState>(
    'selectOption locks answer, reveals correctness, and scores',
    build: () {
      when(() => loadSelfTest()).thenAnswer((_) async => right(questions));
      return buildCubit();
    },
    act: (cubit) async {
      await cubit.loadQuestions();
      cubit.startQuiz();
      cubit.selectOption(TheoryCorrectOption.a);
    },
    expect: () => [
      isA<StudentTheoryQuizState>().having(
        (s) => s.apiState,
        'loading',
        isA<ApiState>().having((s) => s.isLoading, 'isLoading', true),
      ),
      isA<StudentTheoryQuizState>()
          .having((s) => s.phase, 'phase', StudentTheoryQuizPhase.intro)
          .having((s) => s.questions, 'questions', questions),
      isA<StudentTheoryQuizState>().having(
        (s) => s.phase,
        'phase',
        StudentTheoryQuizPhase.quiz,
      ),
      isA<StudentTheoryQuizState>()
          .having((s) => s.revealed, 'revealed', true)
          .having((s) => s.selectedOption, 'selected', TheoryCorrectOption.a)
          .having((s) => s.correctCount, 'score', 1),
    ],
  );

  blocTest<StudentTheoryQuizCubit, StudentTheoryQuizState>(
    'nextQuestion advances then finishes on last question',
    build: () {
      when(() => loadSelfTest()).thenAnswer((_) async => right(questions));
      return buildCubit();
    },
    act: (cubit) async {
      await cubit.loadQuestions();
      cubit.startQuiz();
      cubit.selectOption(TheoryCorrectOption.b);
      cubit.nextQuestion();
      cubit.selectOption(TheoryCorrectOption.b);
      cubit.nextQuestion();
    },
    verify: (cubit) {
      expect(cubit.state.phase, StudentTheoryQuizPhase.results);
      expect(cubit.state.currentIndex, 1);
      expect(cubit.state.correctCount, 1);
    },
  );

  blocTest<StudentTheoryQuizCubit, StudentTheoryQuizState>(
    'restart refetches and resets score then resumes quiz',
    build: () {
      when(() => loadSelfTest()).thenAnswer((_) async => right(questions));
      return buildCubit();
    },
    act: (cubit) async {
      await cubit.loadQuestions();
      cubit.startQuiz();
      cubit.selectOption(TheoryCorrectOption.a);
      await cubit.restart();
    },
    verify: (cubit) {
      verify(() => loadSelfTest()).called(2);
      expect(cubit.state.phase, StudentTheoryQuizPhase.quiz);
      expect(cubit.state.correctCount, 0);
      expect(cubit.state.currentIndex, 0);
      expect(cubit.state.revealed, false);
      expect(cubit.state.selectedOption, isNull);
    },
  );
}
