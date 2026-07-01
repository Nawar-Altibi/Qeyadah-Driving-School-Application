import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
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
    final (:foreground, :background) = _colorsForTone(tone);
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

  ({Color foreground, Color background}) _colorsForTone(AppBadgeTone tone) {
    return switch (tone) {
      AppBadgeTone.success => (
        foreground: AppColors.success,
        background: AppColors.successBg,
      ),
      AppBadgeTone.warning => (
        foreground: AppColors.warning,
        background: AppColors.warningBg,
      ),
      AppBadgeTone.danger => (
        foreground: AppColors.danger,
        background: AppColors.dangerBg,
      ),
      AppBadgeTone.info => (
        foreground: AppColors.info,
        background: AppColors.infoBg,
      ),
      AppBadgeTone.neutral => (
        foreground: AppColors.muted,
        background: AppColors.neutralBg,
      ),
    };
  }
}
