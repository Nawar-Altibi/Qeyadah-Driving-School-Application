import 'package:flutter/material.dart';

@immutable
class AppTextStylesExtension extends ThemeExtension<AppTextStylesExtension> {
  const AppTextStylesExtension({
    required this.regular12,
    required this.regular14,
    required this.regular16,
    required this.medium12,
    required this.medium14,
    required this.semibold14,
    required this.semibold16,
    required this.bold16,
    required this.bold18,
    required this.bold20,
    required this.bold24,
    required this.display32,
  });

  final TextStyle regular12;
  final TextStyle regular14;
  final TextStyle regular16;
  final TextStyle medium12;
  final TextStyle medium14;
  final TextStyle semibold14;
  final TextStyle semibold16;
  final TextStyle bold16;
  final TextStyle bold18;
  final TextStyle bold20;
  final TextStyle bold24;
  final TextStyle display32;

  static const defaults = AppTextStylesExtension(
    regular12: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    regular14: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    regular16: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    medium12: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    medium14: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    semibold14: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    semibold16: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    bold16: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
    bold18: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
    bold20: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    bold24: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
    display32: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
  );

  AppTextStylesExtension withFontFamily(String fontFamily) {
    return AppTextStylesExtension(
      regular12: regular12.copyWith(fontFamily: fontFamily),
      regular14: regular14.copyWith(fontFamily: fontFamily),
      regular16: regular16.copyWith(fontFamily: fontFamily),
      medium12: medium12.copyWith(fontFamily: fontFamily),
      medium14: medium14.copyWith(fontFamily: fontFamily),
      semibold14: semibold14.copyWith(fontFamily: fontFamily),
      semibold16: semibold16.copyWith(fontFamily: fontFamily),
      bold16: bold16.copyWith(fontFamily: fontFamily),
      bold18: bold18.copyWith(fontFamily: fontFamily),
      bold20: bold20.copyWith(fontFamily: fontFamily),
      bold24: bold24.copyWith(fontFamily: fontFamily),
      display32: display32.copyWith(fontFamily: fontFamily),
    );
  }

  AppTextStylesExtension withLocaleFonts({
    required String bodyFontFamily,
    required String headingFontFamily,
  }) {
    return AppTextStylesExtension(
      regular12: regular12.copyWith(fontFamily: bodyFontFamily),
      regular14: regular14.copyWith(fontFamily: bodyFontFamily),
      regular16: regular16.copyWith(fontFamily: bodyFontFamily),
      medium12: medium12.copyWith(fontFamily: bodyFontFamily),
      medium14: medium14.copyWith(fontFamily: bodyFontFamily),
      semibold14: semibold14.copyWith(fontFamily: bodyFontFamily),
      semibold16: semibold16.copyWith(fontFamily: bodyFontFamily),
      bold16: bold16.copyWith(fontFamily: headingFontFamily),
      bold18: bold18.copyWith(fontFamily: headingFontFamily),
      bold20: bold20.copyWith(fontFamily: headingFontFamily),
      bold24: bold24.copyWith(fontFamily: headingFontFamily),
      display32: display32.copyWith(fontFamily: headingFontFamily),
    );
  }

  @override
  AppTextStylesExtension copyWith({
    TextStyle? regular12,
    TextStyle? regular14,
    TextStyle? regular16,
    TextStyle? medium12,
    TextStyle? medium14,
    TextStyle? semibold14,
    TextStyle? semibold16,
    TextStyle? bold16,
    TextStyle? bold18,
    TextStyle? bold20,
    TextStyle? bold24,
    TextStyle? display32,
  }) {
    return AppTextStylesExtension(
      regular12: regular12 ?? this.regular12,
      regular14: regular14 ?? this.regular14,
      regular16: regular16 ?? this.regular16,
      medium12: medium12 ?? this.medium12,
      medium14: medium14 ?? this.medium14,
      semibold14: semibold14 ?? this.semibold14,
      semibold16: semibold16 ?? this.semibold16,
      bold16: bold16 ?? this.bold16,
      bold18: bold18 ?? this.bold18,
      bold20: bold20 ?? this.bold20,
      bold24: bold24 ?? this.bold24,
      display32: display32 ?? this.display32,
    );
  }

  @override
  AppTextStylesExtension lerp(
    covariant ThemeExtension<AppTextStylesExtension>? other,
    double t,
  ) {
    if (other is! AppTextStylesExtension) return this;
    return AppTextStylesExtension(
      regular12: TextStyle.lerp(regular12, other.regular12, t)!,
      regular14: TextStyle.lerp(regular14, other.regular14, t)!,
      regular16: TextStyle.lerp(regular16, other.regular16, t)!,
      medium12: TextStyle.lerp(medium12, other.medium12, t)!,
      medium14: TextStyle.lerp(medium14, other.medium14, t)!,
      semibold14: TextStyle.lerp(semibold14, other.semibold14, t)!,
      semibold16: TextStyle.lerp(semibold16, other.semibold16, t)!,
      bold16: TextStyle.lerp(bold16, other.bold16, t)!,
      bold18: TextStyle.lerp(bold18, other.bold18, t)!,
      bold20: TextStyle.lerp(bold20, other.bold20, t)!,
      bold24: TextStyle.lerp(bold24, other.bold24, t)!,
      display32: TextStyle.lerp(display32, other.display32, t)!,
    );
  }
}
