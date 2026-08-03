import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/route_resumed_refresh.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/presentation/cubit/student_theory_quiz_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/presentation/screens/student_theory_quiz_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/presentation/screens/student_theory_results_screen.dart';

class StudentTheoryIntroScreen extends StatelessWidget {
  const StudentTheoryIntroScreen({super.key});

  static const String routePath = '/student/theory/self-test';
  static const String routeName = 'student-theory-self-test';

  @override
  Widget build(BuildContext context) {
    return RouteResumedRefresh(
      onInitialLoad: () =>
          context.read<StudentTheoryQuizCubit>().loadQuestions(),
      onResumed: () => context.read<StudentTheoryQuizCubit>().loadQuestions(),
      child: BlocBuilder<StudentTheoryQuizCubit, StudentTheoryQuizState>(
        builder: (context, state) {
          return switch (state.phase) {
            StudentTheoryQuizPhase.quiz => const StudentTheoryQuizScreen(),
            StudentTheoryQuizPhase.results =>
              const StudentTheoryResultsScreen(),
            StudentTheoryQuizPhase.intro => _IntroBody(state: state),
          };
        },
      ),
    );
  }
}

class _IntroBody extends StatelessWidget {
  const _IntroBody({required this.state});

  final StudentTheoryQuizState state;

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
        child: state.apiState.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          succeeded: (questions) {
            return Padding(
              padding: AppDesignTokens.screenContentPadding(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        AppCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l10n.studentTheoryBeforeYouStartTitle,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: AppDesignTokens.spacingSm),
                              Text(
                                l10n.studentTheoryIntroBody,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: AppColors.muted),
                              ),
                              const SizedBox(height: AppDesignTokens.spacingMd),
                              Text(
                                l10n.studentTheoryQuestionCount(
                                  questions.length,
                                ),
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(
                                      color: AppColors.brandPrimary,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppButton.primary(
                    label: l10n.studentTheoryStartButton,
                    onPressed: questions.isEmpty
                        ? null
                        : () => context
                              .read<StudentTheoryQuizCubit>()
                              .startQuiz(),
                  ),
                ],
              ),
            );
          },
          failed: (failure, retry) {
            return Center(
              child: Padding(
                padding: PaddingManager.paddingAll16,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      CoreFailureMessageMapper.messageFor(failure, l10n),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppDesignTokens.spacingMd),
                    AppButton.primary(label: l10n.retry, onPressed: retry),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
