import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';

enum AppEmptyStateVariant { inline, card }

class AppEmptyState extends StatelessWidget {
  const AppEmptyState.inline({
    super.key,
    required this.title,
    required this.message,
    this.icon = PhosphorIconsBold.info,
  }) : variant = AppEmptyStateVariant.inline;

  const AppEmptyState.card({
    super.key,
    required this.title,
    required this.message,
    this.icon = PhosphorIconsBold.info,
  }) : variant = AppEmptyStateVariant.card;

  final AppEmptyStateVariant variant;
  final String title;
  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    if (variant == AppEmptyStateVariant.card) {
      return AppCard(
        child: Column(
          children: [
            Icon(icon, size: 32, color: AppColors.muted),
            const SizedBox(height: AppDesignTokens.spacingSm),
            Text(
              title,
              textAlign: TextAlign.center,
              style: textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: AppDesignTokens.spacingXs),
            Text(
              message,
              textAlign: TextAlign.center,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.muted,
                height: 1.4,
              ),
            ),
          ],
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.brandMintSoft.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDesignTokens.spacing),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 20, color: AppColors.muted),
            const SizedBox(width: AppDesignTokens.spacingSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.ink,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.muted,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
