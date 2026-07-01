import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
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
    final (:foreground, :background, :border) = _colorsForTone(tone);
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
    AppAlertTone tone,
  ) {
    return switch (tone) {
      AppAlertTone.warning => (
        foreground: AppColors.warning,
        background: AppColors.warningBg,
        border: const Color(0xFFF2D48B),
      ),
      AppAlertTone.danger => (
        foreground: AppColors.danger,
        background: AppColors.dangerBg,
        border: const Color(0xFFF2C8CD),
      ),
      AppAlertTone.info => (
        foreground: AppColors.info,
        background: AppColors.infoBg,
        border: const Color(0xFFCBE5D6),
      ),
    };
  }
}
