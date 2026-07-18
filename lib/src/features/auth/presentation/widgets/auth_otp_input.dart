import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/services/auth_credentials_rules.dart';

class AuthOtpInput extends StatelessWidget {
  const AuthOtpInput({
    super.key,
    required this.controller,
    this.onCompleted,
    this.autofocus = false,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onCompleted;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final defaultPinTheme = PinTheme(
      width: 49,
      height: 52,
      textStyle: textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 19,
        color: AppColors.ink,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFCFB),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusOtpCell),
        border: Border.all(color: const Color(0xFFDCE3DF)),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: AppColors.brandPrimary, width: 2),
        boxShadow: const [
          BoxShadow(color: Color(0x170F5132), spreadRadius: 3),
        ],
      ),
    );

    return Pinput(
      length: AuthConstants.otpLength,
      controller: controller,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      separatorBuilder: (_) => const SizedBox(width: 10),
      autofocus: autofocus,
      onCompleted: onCompleted,
    );
  }
}
