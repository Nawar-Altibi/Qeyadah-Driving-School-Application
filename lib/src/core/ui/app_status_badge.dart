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
    final colors = AppSemanticColors.of(context);
    final (:foreground, :background) = _colorsForTone(colors, tone);
    final textTheme = Theme.of(context).extension<AppTextStylesExtension>();
    final borderColor = switch (tone) {
      AppBadgeTone.success => colors.success.withValues(alpha: 0.35),
      AppBadgeTone.warning => colors.warning.withValues(alpha: 0.4),
      AppBadgeTone.danger => colors.danger.withValues(alpha: 0.35),
      AppBadgeTone.info => colors.info.withValues(alpha: 0.35),
      AppBadgeTone.neutral => colors.muted.withValues(alpha: 0.28),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: foreground),
              const SizedBox(width: 4),
            ],
            Flexible(
              child: Text(
                label,
                softWrap: true,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: (textTheme?.medium12 ?? const TextStyle(fontSize: 12))
                    .copyWith(
                      color: foreground,
                      fontWeight: FontWeight.w700,
                      height: 1.35,
                    ),
              ),
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
        foreground: colors.ink.withValues(alpha: 0.78),
        background: colors.neutralBg,
      ),
    };
  }
}
