import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_text_theme_extension.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';

class AppMetricTile extends StatelessWidget {
  const AppMetricTile({
    super.key,
    required this.value,
    required this.label,
    required this.icon,
    this.iconColor,
  });

  final String value;
  final String label;
  final IconData icon;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    final textTheme = Theme.of(context).extension<AppTextStylesExtension>();

    return AppCard(
      padding: const EdgeInsets.all(AppDesignTokens.spacing),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor ?? colors.primary, size: 20),
          const SizedBox(height: AppDesignTokens.spacingSm),
          Text(
            value,
            style:
                (textTheme?.bold16 ?? Theme.of(context).textTheme.titleMedium)
                    ?.copyWith(color: colors.ink),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            textAlign: TextAlign.center,
            style:
                (textTheme?.regular12 ?? Theme.of(context).textTheme.bodySmall)
                    ?.copyWith(color: colors.muted),
          ),
        ],
      ),
    );
  }
}
