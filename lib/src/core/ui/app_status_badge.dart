import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_text_theme_extension.dart';

enum AppBadgeTone { success, warning, neutral, danger, info }

class AppStatusBadge extends StatelessWidget {
  const AppStatusBadge({
    super.key,
    required this.label,
    this.tone = AppBadgeTone.neutral,
    this.icon,
  });

  final String label;
  final AppBadgeTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final (:foreground, :background) = _colorsForTone(
      AppSemanticColors.of(context),
      tone,
    );
    final textTheme = Theme.of(context).extension<AppTextStylesExtension>();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: foreground),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: (textTheme?.medium12 ?? const TextStyle(fontSize: 12))
                  .copyWith(color: foreground),
            ),
          ],
        ),
      ),
    );
  }

  ({Color foreground, Color background}) _colorsForTone(
    AppSemanticColors colors,
    AppBadgeTone tone,
  ) {
    return switch (tone) {
      AppBadgeTone.success => (
        foreground: colors.success,
        background: colors.successBg,
      ),
      AppBadgeTone.warning => (
        foreground: colors.warning,
        background: colors.warningBg,
      ),
      AppBadgeTone.danger => (
        foreground: colors.danger,
        background: colors.dangerBg,
      ),
      AppBadgeTone.info => (foreground: colors.info, background: colors.infoBg),
      AppBadgeTone.neutral => (
        foreground: colors.muted,
        background: colors.neutralBg,
      ),
    };
  }
}
