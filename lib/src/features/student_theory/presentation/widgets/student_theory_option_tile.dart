import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
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
    Color border = AppColors.line;
    Color fill = AppColors.white;
    Color foreground = AppColors.ink;
    IconData? trailing;

    if (revealed) {
      if (isCorrect) {
        border = AppColors.success;
        fill = AppColors.successBg;
        foreground = AppColors.success;
        trailing = PhosphorIconsBold.checkCircle;
      } else if (isSelected) {
        border = AppColors.danger;
        fill = AppColors.dangerBg;
        foreground = AppColors.danger;
        trailing = PhosphorIconsBold.xCircle;
      }
    } else if (isSelected) {
      border = AppColors.brandPrimary;
      fill = AppColors.brandMintSoft;
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
                  color: AppColors.neutralBg,
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
