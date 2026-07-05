import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/features/auth/domain/services/auth_credentials_rules.dart';

class AuthResendTimer extends StatefulWidget {
  const AuthResendTimer({
    super.key,
    required this.onResend,
    this.seconds = AuthConstants.otpResendCooldownSeconds,
  });

  final Future<void> Function() onResend;
  final int seconds;

  @override
  State<AuthResendTimer> createState() => _AuthResendTimerState();
}

class _AuthResendTimerState extends State<AuthResendTimer> {
  late int _remaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _remaining = widget.seconds;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remaining <= 0) {
        timer.cancel();
        return;
      }
      setState(() => _remaining--);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return '$minutes:$secs';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    if (_remaining <= 0) {
      return TextButton(
        onPressed: () async {
          await widget.onResend();
          setState(() => _remaining = widget.seconds);
          _startTimer();
        },
        child: Text(
          l10n.resendOtpNow,
          style: textTheme.labelSmall?.copyWith(
            color: AppColors.brandSecondary,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }

    return Text.rich(
      TextSpan(
        style: textTheme.labelSmall?.copyWith(
          color: AppColors.muted,
          fontSize: 10,
        ),
        children: [
          TextSpan(text: '${l10n.forgotPasswordResend} '),
          TextSpan(
            text: l10n.forgotPasswordResendAction(_formatTime(_remaining)),
            style: const TextStyle(
              color: AppColors.brandSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
