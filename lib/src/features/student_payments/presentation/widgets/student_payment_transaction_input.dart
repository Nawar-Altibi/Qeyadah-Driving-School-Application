import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pinput/pinput.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/domain/services/student_payment_validation_rules.dart';

/// ShamCash transaction ID field: exactly 9 digits.
class StudentPaymentTransactionInput extends StatelessWidget {
  const StudentPaymentTransactionInput({
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

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: AppColors.brandPrimary, width: 2),
      ),
    );

    return Pinput(
      length: StudentPaymentConstants.transactionIdLength,
      controller: controller,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      separatorBuilder: (_) => const SizedBox(width: 4),
      autofocus: autofocus,
      onCompleted: onCompleted,
    );
  }
}
