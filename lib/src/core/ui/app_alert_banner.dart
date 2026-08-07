import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_text_theme_extension.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

enum AppAlertTone { warning, danger, info }

class AppAlertBanner extends StatelessWidget {
  const AppAlertBanner({
    super.key,
    required this.title,
    required this.message,
    this.tone = AppAlertTone.warning,
    this.icon,
  });

  final String title;
  final String message;
  final AppAlertTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    final (:foreground, :background, :border) = _colorsForTone(colors, tone);
    final textTheme = Theme.of(context).extension<AppTextStylesExtension>();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDesignTokens.spacing),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon ?? Icons.info_outline, color: foreground, size: 20),
            const SizedBox(width: AppDesignTokens.spacingSm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style:
                        (textTheme?.semibold14 ??
                                Theme.of(context).textTheme.titleSmall)
                            ?.copyWith(color: foreground),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message,
                    style:
                        (textTheme?.regular12 ??
                                Theme.of(context).textTheme.bodySmall)
                            ?.copyWith(color: foreground),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ({Color foreground, Color background, Color border}) _colorsForTone(
    AppSemanticColors colors,
    AppAlertTone tone,
  ) {
    return switch (tone) {
      AppAlertTone.warning => (
        foreground: colors.warning,
        background: colors.warningBg,
        border: colors.warning.withValues(alpha: 0.35),
      ),
      AppAlertTone.danger => (
        foreground: colors.danger,
        background: colors.dangerBg,
        border: colors.danger.withValues(alpha: 0.35),
      ),
      AppAlertTone.info => (
        foreground: colors.info,
        background: colors.infoBg,
        border: colors.info.withValues(alpha: 0.35),
      ),
    };
  }
}
