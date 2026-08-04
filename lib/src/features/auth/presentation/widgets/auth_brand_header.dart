import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

class AuthBrandHeader extends StatelessWidget {
  const AuthBrandHeader({
    super.key,
    this.eyebrow,
    this.title,
    this.subtitle,
    this.centered = false,
  });

  final String? eyebrow;
  final String? title;
  final String? subtitle;
  final bool centered;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final crossAxis = centered
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    final textAlign = centered ? TextAlign.center : TextAlign.start;

    return Column(
      crossAxisAlignment: crossAxis,
      children: [
        Row(
          mainAxisAlignment: centered
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.brandPrimary,
                borderRadius: BorderRadius.circular(
                  AppDesignTokens.radiusBrandIcon,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x330F5132),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: const Icon(
                PhosphorIconsBold.gauge,
                color: AppColors.white,
                size: 25,
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Column(
                crossAxisAlignment: crossAxis,
                children: [
                  Text(
                    l10n.appName,
                    style: textTheme.titleSmall?.copyWith(
                      color: AppColors.ink,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    l10n.appBrandTagline,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.muted,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDesignTokens.spacing2xl),
        Text(
          eyebrow ?? l10n.loginEyebrow,
          textAlign: textAlign,
          style: textTheme.labelSmall?.copyWith(
            color: AppColors.brandPrimary,
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: AppDesignTokens.spacingSm),
        Text(
          title ?? l10n.loginWelcomeTitle,
          textAlign: textAlign,
          style: textTheme.headlineMedium?.copyWith(
            color: AppColors.ink,
            fontSize: 26,
            fontWeight: FontWeight.w800,
            height: 1.2,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle ?? l10n.loginSubtitle,
          textAlign: textAlign,
          style: textTheme.bodyMedium?.copyWith(
            color: AppColors.muted,
            fontSize: 15,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
