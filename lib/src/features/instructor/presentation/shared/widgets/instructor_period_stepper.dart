import 'package:flutter/material.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_month_year_picker.dart';

/// Shared day/month period navigator used by earnings and invoices screens.
class InstructorPeriodStepper extends StatelessWidget {
  const InstructorPeriodStepper({
    super.key,
    required this.isDay,
    required this.selectedDate,
    required this.interactive,
    required this.onPrevious,
    required this.onNext,
    required this.onPick,
    required this.onJumpCurrent,
  });

  final bool isDay;
  final DateTime selectedDate;
  final bool interactive;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onPick;
  final VoidCallback onJumpCurrent;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final label = isDay
        ? DateFormat.yMMMMd(localeName).format(selectedDate)
        : DateFormat.yMMMM(localeName).format(selectedDate);
    final now = DateTime.now();
    final isCurrent = isDay
        ? _isSameDay(selectedDate, now)
        : selectedDate.year == now.year && selectedDate.month == now.month;

    return AppCard(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesignTokens.spacingSm,
        vertical: AppDesignTokens.spacingSm,
      ),
      child: Column(
        children: [
          Row(
            // Keep chronological navigation: left = earlier, right = later.
            textDirection: TextDirection.ltr,
            children: [
              IconButton(
                tooltip: l10n.instructorPeriodPrevious,
                onPressed: interactive ? onPrevious : null,
                icon: const Icon(
                  PhosphorIconsBold.caretLeft,
                  color: AppColors.brandPrimary,
                ),
              ),
              Expanded(
                child: Material(
                  color: AppColors.brandMintSoft,
                  borderRadius: BorderRadius.circular(AppDesignTokens.radiusMd),
                  child: InkWell(
                    onTap: interactive ? onPick : null,
                    borderRadius: BorderRadius.circular(
                      AppDesignTokens.radiusMd,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDesignTokens.spacing,
                        vertical: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            PhosphorIconsBold.calendar,
                            size: 18,
                            color: AppColors.brandPrimary,
                            textDirection: TextDirection.ltr,
                          ),
                          const SizedBox(width: AppDesignTokens.spacingSm),
                          Flexible(
                            child: Text(
                              label,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                tooltip: l10n.instructorPeriodNext,
                onPressed: interactive ? onNext : null,
                icon: const Icon(
                  PhosphorIconsBold.caretRight,
                  color: AppColors.brandPrimary,
                ),
              ),
            ],
          ),
          if (!isCurrent) ...[
            const SizedBox(height: AppDesignTokens.spacingSm),
            TextButton.icon(
              onPressed: interactive ? onJumpCurrent : null,
              icon: const Icon(PhosphorIconsBold.arrowUUpLeft, size: 16),
              label: Text(
                isDay ? l10n.instructorPeriodToday : l10n.instructorPeriodThisMonth,
              ),
            ),
          ],
        ],
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

/// Helper for picking a day or month period from pickers.
Future<DateTime?> pickInstructorPeriod({
  required BuildContext context,
  required bool isDay,
  required DateTime selectedDate,
}) async {
  final l10n = AppLocalizations.of(context);
  final now = DateTime.now();
  if (isDay) {
    return showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: now.add(const Duration(days: 365)),
      helpText: l10n.instructorPeriodPickDay,
    );
  }
  return showAppMonthYearPicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2020),
    lastDate: DateTime(now.year + 1, now.month),
    helpText: l10n.instructorPeriodPickMonth,
  );
}
