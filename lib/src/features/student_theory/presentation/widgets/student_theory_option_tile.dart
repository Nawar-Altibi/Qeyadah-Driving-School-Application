import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/domain/entities/theory_question_entity.dart';

class StudentTheoryOptionTile extends StatelessWidget {
  const StudentTheoryOptionTile({
    super.key,
    required this.label,
    required this.text,
    required this.option,
    required this.revealed,
    required this.isSelected,
    required this.isCorrect,
    required this.onTap,
  });

  final String label;
  final String text;
  final TheoryCorrectOption option;
  final bool revealed;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    Color border = colors.line;
    Color fill = colors.card;
    Color foreground = colors.ink;
    IconData? trailing;

    if (revealed) {
      if (isCorrect) {
        border = colors.success;
        fill = colors.successBg;
        foreground = colors.success;
        trailing = PhosphorIconsBold.checkCircle;
      } else if (isSelected) {
        border = colors.danger;
        fill = colors.dangerBg;
        foreground = colors.danger;
        trailing = PhosphorIconsBold.xCircle;
      }
    } else if (isSelected) {
      border = AppColors.brandPrimary;
      fill = colors.brandSoft;
    }

    return Material(
      color: fill,
      borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
      child: InkWell(
        onTap: revealed ? null : onTap,
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppDesignTokens.spacingMd),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
            border: Border.all(color: border),
          ),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colors.neutralBg,
                  borderRadius: BorderRadius.circular(AppDesignTokens.radiusSm),
                ),
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: foreground,
                  ),
                ),
              ),
              const SizedBox(width: AppDesignTokens.spacing),
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: foreground,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (trailing != null) Icon(trailing, color: foreground, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
