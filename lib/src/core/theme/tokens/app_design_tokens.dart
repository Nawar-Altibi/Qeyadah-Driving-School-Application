import 'package:coore/lib.dart';
import 'package:flutter/painting.dart';

/// Design token references for spacing and radii.
/// Prefer Coore managers ([PaddingManager], [BorderRadiusManager]) in widgets.
abstract final class AppDesignTokens {
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacing = 12;
  static const double spacingMd = 16;
  static const double spacingLg = 24;
  static const double spacingXl = 32;
  static const double spacing2xl = 40;

  static const double radiusSm = 4;
  static const double radiusMd = 8;
  static const double radiusControl = 15;
  static const double radiusBrandIcon = 14;
  static const double radiusOtpCell = 13;
  static const double radiusSheet = 26;
  static const double radiusLg = 16;
  static const double radiusXl = 24;

  static const double buttonHeight = 48;
  static const double inputHeight = 52;
  static const double bottomNavHeight = 64;
  static const double screenHorizontalPadding = 18;

  /// Comfortable bottom breathing room for scrollable screen bodies.
  static const double screenBottomPadding = spacing2xl + spacingLg;

  /// Shared content padding for student/instructor scroll views.
  /// Use [extraBottom] for sticky bars or bottom navigation clearance.
  static EdgeInsets screenContentPadding({
    double top = spacingMd,
    double extraBottom = 0,
  }) => EdgeInsets.fromLTRB(
    screenHorizontalPadding,
    top,
    screenHorizontalPadding,
    screenBottomPadding + extraBottom,
  );

  static const Duration animationFast = Duration(milliseconds: 150);
  static const Duration animationNormal = Duration(milliseconds: 300);
}

abstract final class AppFonts {
  static const String arabicBody = 'IBMPlexSansArabic';
  static const String arabicHeading = 'IBMPlexSansArabic';
  static const String englishBody = 'Roboto';
}
