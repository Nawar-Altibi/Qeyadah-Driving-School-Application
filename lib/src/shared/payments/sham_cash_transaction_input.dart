import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/shared/payments/sham_cash_validation_rules.dart';

class ShamCashTransactionInput extends StatelessWidget {
  const ShamCashTransactionInput({
    super.key,
    required this.controller,
    this.onCompleted,
    this.onChanged,
    this.autofocus = false,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final defaultPinTheme = PinTheme(
      width: 34,
      height: 46,
      textStyle: textTheme.titleSmall?.copyWith(
        fontWeight: FontWeight.w700,
        fontSize: 16,
        color: AppColors.ink,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFFBFCFB),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusOtpCell),
        border: Border.all(color: const Color(0xFFDCE3DF)),
      ),
    );

    return Pinput(
      length: ShamCashConstants.transactionIdLength,
      controller: controller,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: defaultPinTheme.decoration?.copyWith(
          border: Border.all(color: AppColors.brandPrimary, width: 2),
        ),
      ),
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      separatorBuilder: (_) => const SizedBox(width: 4),
      autofocus: autofocus,
      onChanged: onChanged,
      onCompleted: onCompleted,
    );
  }
}
