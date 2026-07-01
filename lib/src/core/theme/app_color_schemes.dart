import 'package:flutter/material.dart';

abstract interface class AppColors {
  static const white = Color(0xFFFFFFFF);
  static const black = Color(0xFF000000);
  static const brandPrimary = Color(0xFF0F5132);
  static const brandPrimaryDark = Color(0xFF0B3F28);
  static const brandPrimaryLight = Color(0xFF176B46);
  static const brandSecondary = Color(0xFFB7791F);
  static const brandMint = Color(0xFFD1E7DD);
  static const brandMintSoft = Color(0xFFE8F5E9);
  static const appCanvas = Color(0xFFF8F9FA);
  static const appCanvasAlt = Color(0xFFF2F4F1);
  static const ink = Color(0xFF212529);
  static const muted = Color(0xFF6C757D);
  static const line = Color(0xFFE3E8E5);
  static const success = Color(0xFF12633B);
  static const successBg = Color(0xFFDCF2E5);
  static const warning = Color(0xFF926116);
  static const warningBg = Color(0xFFFFF0C7);
  static const danger = Color(0xFFB4232F);
  static const dangerBg = Color(0xFFFDEBED);
  static const info = Color(0xFF176748);
  static const infoBg = Color(0xFFDCEFE6);
  static const neutralBg = Color(0xFFEDF0EE);
  static const shadow = Color(0x14153023);
  static const gray2e2e2e = ink;
  static const gray8b8b8b = muted;
  static const grayD2d2d2 = line;

  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: brandPrimary,
    onPrimary: white,
    secondary: brandSecondary,
    onSecondary: white,
    primaryContainer: brandMint,
    onPrimaryContainer: brandPrimaryDark,
    secondaryContainer: warningBg,
    onSecondaryContainer: warning,
    error: danger,
    onError: white,
    surface: appCanvas,
    onSurface: ink,
    surfaceContainer: white,
    surfaceContainerHighest: appCanvasAlt,
    onSurfaceVariant: muted,
    outline: line,
    shadow: shadow,
  );

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF8ED1AE),
    onPrimary: black,
    secondary: Color(0xFFE4B96D),
    onSecondary: black,
    primaryContainer: brandPrimary,
    onPrimaryContainer: white,
    secondaryContainer: Color(0xFF5D4218),
    onSecondaryContainer: Color(0xFFFFE1A8),
    error: Color(0xFFFFB3BC),
    onError: black,
    surface: Color(0xFF101612),
    surfaceContainer: Color(0xFF19231D),
    surfaceContainerHighest: Color(0xFF223028),
    onSurface: white,
    onSurfaceVariant: Color(0xFFB9C7BF),
    outline: Color(0xFF34443B),
    shadow: Color(0x66000000),
  );
}

abstract interface class AppGradients {
  static const heroEmerald = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [
      AppColors.brandPrimaryDark,
      AppColors.brandPrimary,
      AppColors.brandPrimaryLight,
    ],
  );

  static const softMintBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.brandMintSoft, AppColors.appCanvas],
  );
}
