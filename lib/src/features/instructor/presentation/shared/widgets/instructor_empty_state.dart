import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';

/// Soft empty-state panel used across instructor list screens.
class InstructorEmptyState extends StatelessWidget {
  const InstructorEmptyState({
    super.key,
    required this.message,
    this.icon = PhosphorIconsBold.tray,
  });

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: AppColors.brandMintSoft.withValues(alpha: 0.55),
      borderColor: AppColors.brandMint,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppDesignTokens.spacingMd,
        ),
        child: Column(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: AppColors.brandPrimary, size: 24),
            ),
            const SizedBox(height: AppDesignTokens.spacing),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.muted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
