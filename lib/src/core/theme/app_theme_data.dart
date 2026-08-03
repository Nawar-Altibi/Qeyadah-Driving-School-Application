import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_text_theme_extension.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

abstract interface class AppThemeData {
  static final ThemeData _baseTheme = ThemeData(
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    extensions: const [AppTextStylesExtension.defaults],
  );

  static final lightThemeData = _baseTheme.copyWith(
    colorScheme: AppColors.lightColorScheme,
    scaffoldBackgroundColor: AppColors.lightColorScheme.surface,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: AppColors.appCanvas,
      foregroundColor: AppColors.ink,
    ),
    cardTheme: const CardThemeData(
      color: AppColors.white,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(AppDesignTokens.radiusLg),
        ),
        side: BorderSide(color: AppColors.line),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: AppColors.white,
      selectedColor: AppColors.brandMintSoft,
      disabledColor: AppColors.neutralBg,
      labelStyle: AppTextStylesExtension.defaults.medium12,
      secondaryLabelStyle: AppTextStylesExtension.defaults.medium12.copyWith(
        color: AppColors.brandPrimary,
      ),
      side: const BorderSide(color: AppColors.line),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadiusManager.radiusAll8,
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(AppDesignTokens.buttonHeight),
        backgroundColor: AppColors.brandPrimary,
        foregroundColor: AppColors.white,
        textStyle: AppTextStylesExtension.defaults.bold16,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(AppDesignTokens.buttonHeight),
        foregroundColor: AppColors.brandPrimary,
        textStyle: AppTextStylesExtension.defaults.bold16,
        side: const BorderSide(color: AppColors.brandMint),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      floatingLabelAlignment: FloatingLabelAlignment.start,
      labelStyle: AppTextStylesExtension.defaults.medium12.copyWith(
        color: AppColors.muted,
      ),
      floatingLabelStyle: AppTextStylesExtension.defaults.medium12.copyWith(
        color: AppColors.brandPrimary,
      ),
      hintStyle: AppTextStylesExtension.defaults.medium14.copyWith(
        color: AppColors.muted,
      ),
      prefixIconColor: AppColors.muted,
      suffixIconColor: AppColors.muted,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
        borderSide: const BorderSide(color: AppColors.line),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.line),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.brandPrimaryLight,
          width: 1.4,
        ),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.danger),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.danger, width: 1.4),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
      ),
      contentPadding: PaddingManager.paddingHorizontal16Vertical12,
    ),
  );

  static final darkThemeData =
      ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: AppColors.darkColorScheme,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        extensions: const [AppTextStylesExtension.defaults],
      ).copyWith(
        scaffoldBackgroundColor: AppColors.darkColorScheme.surface,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        cardTheme: CardThemeData(
          color: AppColors.darkColorScheme.surfaceContainer,
          elevation: 0,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDesignTokens.radiusLg),
            side: BorderSide(color: AppColors.darkColorScheme.outline),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(AppDesignTokens.buttonHeight),
            textStyle: AppTextStylesExtension.defaults.bold16,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppDesignTokens.radiusControl,
              ),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            minimumSize: const Size.fromHeight(AppDesignTokens.buttonHeight),
            textStyle: AppTextStylesExtension.defaults.bold16,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                AppDesignTokens.radiusControl,
              ),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkColorScheme.surfaceContainerHighest,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          labelStyle: AppTextStylesExtension.defaults.medium12.copyWith(
            color: AppColors.darkColorScheme.onSurfaceVariant,
          ),
          floatingLabelStyle: AppTextStylesExtension.defaults.medium12.copyWith(
            color: AppColors.darkColorScheme.primary,
          ),
          hintStyle: AppTextStylesExtension.defaults.medium14.copyWith(
            color: AppColors.darkColorScheme.onSurfaceVariant,
          ),
          prefixIconColor: AppColors.darkColorScheme.onSurfaceVariant,
          suffixIconColor: AppColors.darkColorScheme.onSurfaceVariant,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
            borderSide: BorderSide(color: AppColors.darkColorScheme.outline),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.darkColorScheme.outline),
            borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.darkColorScheme.primary,
              width: 1.4,
            ),
            borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.darkColorScheme.error),
            borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.darkColorScheme.error,
              width: 1.4,
            ),
            borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
          ),
          contentPadding: PaddingManager.paddingHorizontal16Vertical12,
        ),
      );
}
