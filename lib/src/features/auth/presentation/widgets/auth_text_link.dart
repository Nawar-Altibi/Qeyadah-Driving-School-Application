import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';

class AuthTextLink extends StatelessWidget {
  const AuthTextLink({super.key, required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.brandPrimary,
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
        ),
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}

class AuthSecureNote extends StatelessWidget {
  const AuthSecureNote({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.verified_user_outlined,
          size: 16,
          color: AppColors.muted,
        ),
        const SizedBox(width: 7),
        Flexible(
          child: Text(
            l10n.loginSecureNote,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.muted,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
