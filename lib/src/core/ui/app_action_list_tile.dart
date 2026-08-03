import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

/// One row in a settings-style list: icon, label, optional trailing
/// chevron, optional destructive tone (red icon/text). Reusable for any
/// future account/settings screen instead of one-off full-width buttons.
class AppActionListTile extends StatelessWidget {
  const AppActionListTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
    this.showChevron = true,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final tint = isDestructive ? AppColors.danger : AppColors.brandPrimary;
    final softBg = isDestructive ? AppColors.dangerBg : AppColors.brandMintSoft;
    final textColor = isDestructive ? AppColors.danger : AppColors.ink;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDesignTokens.spacingSm,
            vertical: AppDesignTokens.spacing,
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: softBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 18, color: tint),
              ),
              const SizedBox(width: AppDesignTokens.spacing),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (showChevron)
                Icon(
                  PhosphorIconsBold.caretLeft,
                  size: 16,
                  color: AppColors.muted.withValues(alpha: 0.7),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
