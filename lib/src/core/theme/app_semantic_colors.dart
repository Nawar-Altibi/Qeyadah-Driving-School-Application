import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';

/// Theme-aware semantic palette resolved from [ColorScheme] + brightness.
///
/// Prefer this over raw [AppColors] light constants in screens and shared UI.
@immutable
class AppSemanticColors {
  const AppSemanticColors._({
    required this.brightness,
    required this.canvas,
    required this.card,
    required this.elevatedCard,
    required this.ink,
    required this.muted,
    required this.inverseInk,
    required this.line,
    required this.success,
    required this.successBg,
    required this.warning,
    required this.warningBg,
    required this.danger,
    required this.dangerBg,
    required this.info,
    required this.infoBg,
    required this.neutralBg,
    required this.brandSoft,
    required this.primary,
    required this.onPrimary,
    required this.shadow,
    required this.softShadow,
  });

  final Brightness brightness;
  final Color canvas;
  final Color card;
  final Color elevatedCard;
  final Color ink;
  final Color muted;
  final Color inverseInk;
  final Color line;
  final Color success;
  final Color successBg;
  final Color warning;
  final Color warningBg;
  final Color danger;
  final Color dangerBg;
  final Color info;
  final Color infoBg;
  final Color neutralBg;
  final Color brandSoft;
  final Color primary;
  final Color onPrimary;
  final Color shadow;
  final Color softShadow;

  bool get isDark => brightness == Brightness.dark;

  static AppSemanticColors of(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isDark = scheme.brightness == Brightness.dark;

    if (isDark) {
      return AppSemanticColors._(
        brightness: Brightness.dark,
        canvas: scheme.surface,
        card: scheme.surfaceContainer,
        elevatedCard: scheme.surfaceContainerHighest,
        ink: scheme.onSurface,
        muted: scheme.onSurfaceVariant,
        inverseInk: AppColors.white,
        line: scheme.outline,
        success: const Color(0xFF7DCEA0),
        successBg: const Color(0xFF1A3228),
        warning: const Color(0xFFE4B96D),
        warningBg: const Color(0xFF3A2E18),
        danger: scheme.error,
        dangerBg: const Color(0xFF3A1F24),
        info: scheme.primary,
        infoBg: const Color(0xFF1A2F26),
        neutralBg: scheme.surfaceContainerHighest,
        brandSoft: const Color(0xFF1A2F26),
        primary: scheme.primary,
        onPrimary: scheme.onPrimary,
        shadow: scheme.shadow,
        softShadow: const Color(0x4D000000),
      );
    }

    return AppSemanticColors._(
      brightness: Brightness.light,
      canvas: scheme.surface,
      card: scheme.surfaceContainer,
      elevatedCard: scheme.surfaceContainerHighest,
      ink: scheme.onSurface,
      muted: scheme.onSurfaceVariant,
      inverseInk: AppColors.white,
      line: scheme.outline,
      success: AppColors.success,
      successBg: AppColors.successBg,
      warning: AppColors.warning,
      warningBg: AppColors.warningBg,
      danger: AppColors.danger,
      dangerBg: AppColors.dangerBg,
      info: AppColors.info,
      infoBg: AppColors.infoBg,
      neutralBg: AppColors.neutralBg,
      brandSoft: AppColors.brandMintSoft,
      primary: scheme.primary,
      onPrimary: scheme.onPrimary,
      shadow: scheme.shadow,
      softShadow: const Color(0x08153023),
    );
  }

  List<BoxShadow> get cardShadows => isDark
      ? [
          BoxShadow(
            color: softShadow,
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ]
      : const [
          BoxShadow(
            color: Color(0x0F153023),
            blurRadius: 16,
            offset: Offset(0, 5),
          ),
          BoxShadow(
            color: Color(0x08153023),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ];
}
