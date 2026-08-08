import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/src/core/formatters/app_date_formatters.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

/// Soft pill that pairs an icon with a short label (date, time, etc.).
class AppInfoChip extends StatelessWidget {
  const AppInfoChip({
    super.key,
    required this.icon,
    required this.label,
    this.iconColor,
    this.backgroundColor,
  });

  final IconData icon;
  final String label;
  final Color? iconColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.neutralBg,
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusMd),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: iconColor ?? colors.muted),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: colors.ink,
                fontWeight: FontWeight.w600,
                fontSize: 12.5,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Caption + separate date and time chips for paid-at / requested-at rows.
class AppPaidAtRow extends StatelessWidget {
  const AppPaidAtRow({
    super.key,
    required this.caption,
    required this.at,
    this.compact = false,
  });

  final String caption;
  final DateTime at;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final date = AppDateFormatters.dateLabel(at, localeName);
    final time = AppDateFormatters.timeLabel(at, localeName);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              PhosphorIconsBold.checkCircle,
              size: 14,
              color: colors.success,
            ),
            const SizedBox(width: 6),
            Text(
              caption,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: colors.muted,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: compact ? 6 : AppDesignTokens.spacingSm),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            AppInfoChip(
              icon: PhosphorIconsBold.calendarBlank,
              label: date,
              iconColor: colors.primary,
              backgroundColor: colors.brandSoft.withValues(alpha: 0.65),
            ),
            AppInfoChip(
              icon: PhosphorIconsBold.clock,
              label: time,
              iconColor: colors.primary,
              backgroundColor: colors.brandSoft.withValues(alpha: 0.65),
            ),
          ],
        ),
      ],
    );
  }
}
