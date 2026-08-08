import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

/// Shows a confirmation dialog before logout.
/// Returns `true` only when the user confirms.
Future<bool> confirmLogout(
  BuildContext context, {
  bool allDevices = false,
}) async {
  final l10n = AppLocalizations.of(context);
  final colors = AppSemanticColors.of(context);
  final confirmColor = allDevices ? colors.danger : AppColors.brandPrimary;

  final confirmed = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (dialogContext) {
      final textTheme = Theme.of(dialogContext).textTheme;
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDesignTokens.radiusXl),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: confirmColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  PhosphorIconsBold.signOut,
                  color: confirmColor,
                  size: 26,
                ),
              ),
              const SizedBox(height: AppDesignTokens.spacingMd),
              Text(
                l10n.logoutConfirmTitle,
                textAlign: TextAlign.center,
                style: textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: colors.ink,
                ),
              ),
              const SizedBox(height: AppDesignTokens.spacingSm),
              Text(
                allDevices
                    ? l10n.logoutAllConfirmMessage
                    : l10n.logoutConfirmMessage,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium?.copyWith(
                  color: colors.muted,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: AppDesignTokens.spacingLg),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () =>
                          Navigator.of(dialogContext).pop(false),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colors.ink,
                        minimumSize: const Size.fromHeight(
                          AppDesignTokens.buttonHeight,
                        ),
                        side: BorderSide(
                          color: colors.line,
                          width: 1.4,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDesignTokens.radiusMd,
                          ),
                        ),
                        textStyle: textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      child: Text(l10n.actionCancel),
                    ),
                  ),
                  const SizedBox(width: AppDesignTokens.spacing),
                  Expanded(
                    child: FilledButton(
                      onPressed: () =>
                          Navigator.of(dialogContext).pop(true),
                      style: FilledButton.styleFrom(
                        backgroundColor: confirmColor,
                        foregroundColor: AppColors.white,
                        elevation: 0,
                        minimumSize: const Size.fromHeight(
                          AppDesignTokens.buttonHeight,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDesignTokens.radiusMd,
                          ),
                        ),
                        textStyle: textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      child: Text(l10n.logoutConfirmAction),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
  return confirmed == true;
}
