import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/screens/student_home_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/presentation/cubit/student_theory_quiz_cubit.dart';

class StudentTheoryResultsScreen extends StatelessWidget {
  const StudentTheoryResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: AppColors.appCanvas,
      appBar: AppBar(
        backgroundColor: AppColors.appCanvas,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(l10n.studentTheoryResultsTitle),
        centerTitle: true,
      ),
      body: ResponsiveShell(
        child: BlocBuilder<StudentTheoryQuizCubit, StudentTheoryQuizState>(
          builder: (context, state) {
            final total = state.questions.length;
            final score = state.correctCount;

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
                            children: [
                              Text(
                                l10n.studentTheoryFinalScoreTitle,
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: AppDesignTokens.spacingMd),
                              Text(
                                l10n.studentTheoryScoreSummary(score, total),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: AppColors.brandPrimary,
                                      fontWeight: FontWeight.w800,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: AppDesignTokens.spacingSm),
                              Text(
                                l10n.studentTheoryResultsBody,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(color: AppColors.muted),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppButton.primary(
                    label: l10n.studentTheoryPracticeAgainButton,
                    onPressed: () =>
                        context.read<StudentTheoryQuizCubit>().restart(),
                  ),
                  const SizedBox(height: AppDesignTokens.spacingSm),
                  AppButton.secondary(
                    label: l10n.studentTheoryBackToHomeButton,
                    onPressed: () => context.go(StudentHomeScreen.routePath),
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
