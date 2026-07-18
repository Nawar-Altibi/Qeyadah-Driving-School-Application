import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_metric_tile.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_month_year_picker.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_section_heading.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_segmented_control.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_earnings/presentation/cubit/instructor_earnings_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/formatters/instructor_formatters.dart';

class InstructorEarningsBody extends StatelessWidget {
  const InstructorEarningsBody({
    super.key,
    required this.state,
    required this.earnings,
    this.interactive = true,
  });

  final InstructorEarningsState state;
  final InstructorEarningsEntity earnings;
  final bool interactive;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDay = state.viewMode == InstructorEarningsViewMode.day;
    final total = isDay ? earnings.dayTotal ?? 0 : earnings.monthTotal;
    final count = isDay
        ? earnings.daySessionsCount ?? earnings.sessions.length
        : earnings.monthSessionsCount;
    return ListView(
      padding: const EdgeInsets.all(AppDesignTokens.screenHorizontalPadding),
      children: [
        AppSegmentedControl<InstructorEarningsViewMode>(
          value: state.viewMode,
          items: [
            AppSegmentedItem(
              value: InstructorEarningsViewMode.day,
              label: l10n.instructorEarningsDay,
            ),
            AppSegmentedItem(
              value: InstructorEarningsViewMode.month,
              label: l10n.instructorEarningsMonth,
            ),
          ],
          onChanged: interactive
              ? context.read<InstructorEarningsCubit>().setViewMode
              : (_) {},
        ),
        const SizedBox(height: AppDesignTokens.spacingSm),
        Text(
          isDay
              ? l10n.instructorEarningsPeriodHintDay
              : l10n.instructorEarningsPeriodHintMonth,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
        ),
        const SizedBox(height: AppDesignTokens.spacing),
        _EarningsPeriodStepper(
          isDay: isDay,
          selectedDate: state.selectedDate,
          interactive: interactive,
          onPrevious: () => _stepPeriod(context, isDay, -1),
          onNext: () => _stepPeriod(context, isDay, 1),
          onPick: () => _pickPeriod(context, isDay),
          onJumpCurrent: () => _jumpToCurrent(context, isDay),
        ),
        const SizedBox(height: AppDesignTokens.spacingMd),
        Row(
          children: [
            Expanded(
              child: AppMetricTile(
                value: InstructorFormatters.currencyAmount(l10n, total),
                label: isDay
                    ? l10n.instructorEarningsDayTotal
                    : l10n.instructorEarningsMonthTotal,
                icon: PhosphorIconsBold.money,
              ),
            ),
            const SizedBox(width: AppDesignTokens.spacing),
            Expanded(
              child: AppMetricTile(
                value: '$count',
                label: l10n.instructorEarningsSessions,
                icon: PhosphorIconsBold.calendarCheck,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDesignTokens.spacingLg),
        AppSectionHeading(title: l10n.instructorEarningsSessions),
        const SizedBox(height: AppDesignTokens.spacing),
        if (earnings.sessions.isEmpty)
          AppCard(child: Text(l10n.instructorEarningsEmpty))
        else
          for (final session in earnings.sessions) ...[
            _SessionCard(session: session),
            const SizedBox(height: AppDesignTokens.spacingSm),
          ],
      ],
    );
  }

  Future<void> _stepPeriod(
    BuildContext context,
    bool isDay,
    int delta,
  ) async {
    if (!interactive) return;
    final current = state.selectedDate;
    final next = isDay
        ? current.add(Duration(days: delta))
        : DateTime(current.year, current.month + delta);
    await context.read<InstructorEarningsCubit>().selectDate(next);
  }

  Future<void> _jumpToCurrent(BuildContext context, bool isDay) async {
    if (!interactive) return;
    final now = DateTime.now();
    final target = isDay
        ? DateTime(now.year, now.month, now.day)
        : DateTime(now.year, now.month);
    await context.read<InstructorEarningsCubit>().selectDate(target);
  }

  Future<void> _pickPeriod(BuildContext context, bool isDay) async {
    if (!interactive) return;
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<InstructorEarningsCubit>();
    final now = DateTime.now();
    final DateTime? selected;
    if (isDay) {
      selected = await showDatePicker(
        context: context,
        initialDate: state.selectedDate,
        firstDate: DateTime(2020),
        lastDate: now.add(const Duration(days: 365)),
        helpText: l10n.instructorEarningsPickDay,
      );
    } else {
      selected = await showAppMonthYearPicker(
        context: context,
        initialDate: state.selectedDate,
        firstDate: DateTime(2020),
        lastDate: DateTime(now.year + 1, now.month),
        helpText: l10n.instructorEarningsPickMonth,
      );
    }
    if (selected == null) return;
    await cubit.selectDate(
      isDay ? selected : DateTime(selected.year, selected.month),
    );
  }
}

class _EarningsPeriodStepper extends StatelessWidget {
  const _EarningsPeriodStepper({
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
                tooltip: l10n.instructorEarningsPreviousPeriod,
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
                tooltip: l10n.instructorEarningsNextPeriod,
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
                isDay
                    ? l10n.instructorEarningsToday
                    : l10n.instructorEarningsThisMonth,
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

class _SessionCard extends StatelessWidget {
  const _SessionCard({required this.session});

  final InstructorEarningSessionEntity session;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final timeFormat = DateFormat.Hm(localeName);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  session.studentName,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Text(
                InstructorFormatters.currencyAmount(l10n, session.amount),
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
          const SizedBox(height: AppDesignTokens.spacingSm),
          Text(
            '${timeFormat.format(session.startAt)} – ${timeFormat.format(session.endAt)}',
            style: const TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 2),
          Text(
            l10n.instructorEarningsPaidAt(
              DateFormat.yMMMd(localeName).add_Hm().format(session.paidAt),
            ),
            style: const TextStyle(color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}
