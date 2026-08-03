import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/presentation/cubit/student_theory_quiz_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/presentation/widgets/student_theory_question_card.dart';

class StudentTheoryQuizScreen extends StatelessWidget {
  const StudentTheoryQuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.appCanvas,
      appBar: AppBar(
        backgroundColor: AppColors.appCanvas,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(l10n.studentTheoryTitle),
        centerTitle: true,
      ),
      body: ResponsiveShell(
        child: BlocBuilder<StudentTheoryQuizCubit, StudentTheoryQuizState>(
          builder: (context, state) {
            final question = state.currentQuestion;
            if (question == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Padding(
              padding: AppDesignTokens.screenContentPadding(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        StudentTheoryQuestionCard(
                          question: question,
                          questionNumber: state.currentIndex + 1,
                          totalQuestions: state.questions.length,
                          selectedOption: state.selectedOption,
                          revealed: state.revealed,
                          onSelect: (option) => context
                              .read<StudentTheoryQuizCubit>()
                              .selectOption(option),
                        ),
                      ],
                    ),
                  ),
                  AppButton.primary(
                    label: state.isLastQuestion
                        ? l10n.studentTheoryFinishButton
                        : l10n.studentTheoryNextButton,
                    onPressed: state.revealed
                        ? () => context
                              .read<StudentTheoryQuizCubit>()
                              .nextQuestion()
                        : null,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
