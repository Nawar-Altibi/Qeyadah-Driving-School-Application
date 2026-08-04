import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_network_image.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/domain/entities/theory_question_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/presentation/widgets/student_theory_option_tile.dart';

class StudentTheoryQuestionCard extends StatelessWidget {
  const StudentTheoryQuestionCard({
    super.key,
    required this.question,
    required this.questionNumber,
    required this.totalQuestions,
    required this.selectedOption,
    required this.revealed,
    required this.onSelect,
  });

  final TheoryQuestionEntity question;
  final int questionNumber;
  final int totalQuestions;
  final TheoryCorrectOption? selectedOption;
  final bool revealed;
  final ValueChanged<TheoryCorrectOption> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final explanation = question.explanation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.studentTheoryProgress(questionNumber, totalQuestions),
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
        ),
        const SizedBox(height: AppDesignTokens.spacingSm),
        LinearProgressIndicator(
          value: totalQuestions == 0 ? 0 : questionNumber / totalQuestions,
          minHeight: 6,
          borderRadius: BorderRadius.circular(999),
          backgroundColor: AppColors.neutralBg,
          color: AppColors.brandPrimary,
        ),
        const SizedBox(height: AppDesignTokens.spacingMd),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _categoryLabel(l10n, question.category),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.brandPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppDesignTokens.spacingSm),
              Text(
                question.questionText,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              if (question.imageUrl != null) ...[
                const SizedBox(height: AppDesignTokens.spacingMd),
                ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppDesignTokens.radiusControl,
                  ),
                  child: AppNetworkImage(
                    imageUrl: question.imageUrl,
                    fit: BoxFit.contain,
                    fallback: const SizedBox.shrink(),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppDesignTokens.spacingMd),
        for (final entry in question.options) ...[
          StudentTheoryOptionTile(
            label: entry.option.apiValue,
            text: entry.text,
            option: entry.option,
            revealed: revealed,
            isSelected: selectedOption == entry.option,
            isCorrect: entry.option == question.correctOption,
            onTap: () => onSelect(entry.option),
          ),
          const SizedBox(height: AppDesignTokens.spacingSm),
        ],
        if (revealed && explanation != null && explanation.isNotEmpty) ...[
          const SizedBox(height: AppDesignTokens.spacingSm),
          AppCard(
            backgroundColor: AppColors.brandMintSoft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.studentTheoryExplanationTitle,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppDesignTokens.spacingSm),
                Text(explanation),
              ],
            ),
          ),
        ],
      ],
    );
  }

  String _categoryLabel(
    AppLocalizations l10n,
    TheoryQuestionCategory category,
  ) {
    return switch (category) {
      TheoryQuestionCategory.signs => l10n.studentTheoryCategorySigns,
      TheoryQuestionCategory.safety => l10n.studentTheoryCategorySafety,
      TheoryQuestionCategory.mechanics => l10n.studentTheoryCategoryMechanics,
      TheoryQuestionCategory.unknown => l10n.studentTheoryCategoryUnknown,
    };
  }
}
