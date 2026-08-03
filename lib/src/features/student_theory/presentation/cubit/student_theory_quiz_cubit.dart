import 'package:coore/lib.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/app_core_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/domain/entities/theory_question_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/domain/use_cases/load_theory_self_test_use_case.dart';

enum StudentTheoryQuizPhase { intro, quiz, results }

class StudentTheoryQuizState {
  const StudentTheoryQuizState({
    this.apiState = const ApiState<List<TheoryQuestionEntity>>.initial(),
    this.phase = StudentTheoryQuizPhase.intro,
    this.currentIndex = 0,
    this.selectedOption,
    this.revealed = false,
    this.correctCount = 0,
  });

  final ApiState<List<TheoryQuestionEntity>> apiState;
  final StudentTheoryQuizPhase phase;
  final int currentIndex;
  final TheoryCorrectOption? selectedOption;
  final bool revealed;
  final int correctCount;

  List<TheoryQuestionEntity> get questions =>
      apiState.maybeWhen(succeeded: (value) => value, orElse: () => const []);

  TheoryQuestionEntity? get currentQuestion {
    final items = questions;
    if (currentIndex < 0 || currentIndex >= items.length) return null;
    return items[currentIndex];
  }

  bool get isLastQuestion =>
      questions.isNotEmpty && currentIndex >= questions.length - 1;

  StudentTheoryQuizState copyWith({
    ApiState<List<TheoryQuestionEntity>>? apiState,
    StudentTheoryQuizPhase? phase,
    int? currentIndex,
    TheoryCorrectOption? selectedOption,
    bool clearSelectedOption = false,
    bool? revealed,
    int? correctCount,
  }) {
    return StudentTheoryQuizState(
      apiState: apiState ?? this.apiState,
      phase: phase ?? this.phase,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedOption: clearSelectedOption
          ? null
          : selectedOption ?? this.selectedOption,
      revealed: revealed ?? this.revealed,
      correctCount: correctCount ?? this.correctCount,
    );
  }
}

@injectable
class StudentTheoryQuizCubit extends AppCoreCubit<StudentTheoryQuizState> {
  StudentTheoryQuizCubit(this._loadSelfTest)
    : super(const StudentTheoryQuizState());

  final LoadTheorySelfTestUseCase _loadSelfTest;
  int _loadGeneration = 0;

  Future<void> loadQuestions() async {
    final generation = ++_loadGeneration;
    emit(
      state.copyWith(
        apiState: const ApiState.loading(),
        phase: StudentTheoryQuizPhase.intro,
        currentIndex: 0,
        clearSelectedOption: true,
        revealed: false,
        correctCount: 0,
      ),
    );

    final result = await _loadSelfTest();
    if (generation != _loadGeneration) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          apiState: ApiState.failed(failure, retryFunction: loadQuestions),
        ),
      ),
      (questions) => emit(
        state.copyWith(
          apiState: ApiState.succeeded(questions),
          phase: StudentTheoryQuizPhase.intro,
        ),
      ),
    );
  }

  void startQuiz() {
    if (state.questions.isEmpty) return;
    emit(
      state.copyWith(
        phase: StudentTheoryQuizPhase.quiz,
        currentIndex: 0,
        clearSelectedOption: true,
        revealed: false,
        correctCount: 0,
      ),
    );
  }

  void selectOption(TheoryCorrectOption option) {
    if (state.phase != StudentTheoryQuizPhase.quiz || state.revealed) return;
    final question = state.currentQuestion;
    if (question == null) return;

    final isCorrect = option == question.correctOption;
    emit(
      state.copyWith(
        selectedOption: option,
        revealed: true,
        correctCount: isCorrect ? state.correctCount + 1 : state.correctCount,
      ),
    );
  }

  void nextQuestion() {
    if (!state.revealed) return;
    if (state.isLastQuestion) {
      emit(state.copyWith(phase: StudentTheoryQuizPhase.results));
      return;
    }
    emit(
      state.copyWith(
        currentIndex: state.currentIndex + 1,
        clearSelectedOption: true,
        revealed: false,
      ),
    );
  }

  Future<void> restart() => loadQuestions().then((_) {
    if (state.questions.isNotEmpty) startQuiz();
  });
}
