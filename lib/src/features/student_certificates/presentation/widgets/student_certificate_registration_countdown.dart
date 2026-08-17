import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/formatters/app_date_formatters.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

/// Compact remaining-time chips for reexam registration windows.
class StudentCertificateRegistrationCountdown extends StatelessWidget {
  const StudentCertificateRegistrationCountdown({
    super.key,
    required this.remaining,
  });

  final Duration remaining;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final parts = AppDateFormatters.countdownParts(remaining);
    final chips = <Widget>[
      if (parts.days > 0)
        _CountdownChip(value: '${parts.days}', unit: l10n.durationDaysUnit),
      _CountdownChip(
        value: parts.hours.toString().padLeft(2, '0'),
        unit: l10n.durationHoursUnit,
      ),
      _CountdownChip(
        value: parts.minutes.toString().padLeft(2, '0'),
        unit: l10n.durationMinutesUnit,
      ),
      _CountdownChip(
        value: parts.seconds.toString().padLeft(2, '0'),
        unit: l10n.durationSecondsUnit,
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.studentCertificatesRegistrationCountdownLabel,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: AppColors.brandPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppDesignTokens.spacingSm),
        Wrap(
          spacing: AppDesignTokens.spacingSm,
          runSpacing: AppDesignTokens.spacingSm,
          children: chips,
        ),
      ],
    );
  }
}

class _CountdownChip extends StatelessWidget {
  const _CountdownChip({required this.value, required this.unit});

  final String value;
  final String unit;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesignTokens.spacing,
        vertical: AppDesignTokens.spacingXs + 2,
      ),
      decoration: BoxDecoration(
        color: colors.brandSoft,
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusMd),
        border: Border.all(
          color: AppColors.brandPrimary.withValues(alpha: 0.18),
        ),
      ),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: value,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.brandPrimary,
                fontWeight: FontWeight.w800,
                height: 1,
              ),
            ),
            TextSpan(
              text: ' $unit',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: colors.muted,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
