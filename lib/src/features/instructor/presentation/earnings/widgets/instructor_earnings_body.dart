import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/formatters/app_date_formatters.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_metric_tile.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_section_heading.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_segmented_control.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/earnings/cubit/instructor_earnings_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/shared/formatters/instructor_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/shared/widgets/instructor_period_stepper.dart';

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
    final colors = AppSemanticColors.of(context);
    final isDay = state.viewMode == InstructorEarningsViewMode.day;
    final total = isDay ? earnings.dayTotal ?? 0 : earnings.monthTotal;
    final count = isDay
        ? earnings.daySessionsCount ?? earnings.sessions.length
        : earnings.monthSessionsCount;
    final sessions = earnings.sessions;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            AppDesignTokens.screenHorizontalPadding,
            AppDesignTokens.screenHorizontalPadding,
            AppDesignTokens.screenHorizontalPadding,
            0,
          ),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppSegmentedControl<InstructorEarningsViewMode>(
                  value: state.viewMode,
                  items: [
                    AppSegmentedItem(
                      value: InstructorEarningsViewMode.day,
                      label: l10n.instructorPeriodDay,
                    ),
                    AppSegmentedItem(
                      value: InstructorEarningsViewMode.month,
                      label: l10n.instructorPeriodMonth,
                    ),
                  ],
                  onChanged: interactive
                      ? context.read<InstructorEarningsCubit>().setViewMode
                      : (_) {},
                ),
                const SizedBox(height: AppDesignTokens.spacingSm),
                Text(
                  isDay
                      ? l10n.instructorPeriodHintDay
                      : l10n.instructorPeriodHintMonth,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: colors.muted),
                ),
                const SizedBox(height: AppDesignTokens.spacing),
                InstructorPeriodStepper(
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
                if (sessions.isEmpty)
                  AppCard(child: Text(l10n.instructorEarningsEmpty)),
              ],
            ),
          ),
        ),
        if (sessions.isNotEmpty)
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              AppDesignTokens.screenHorizontalPadding,
              0,
              AppDesignTokens.screenHorizontalPadding,
              AppDesignTokens.listEndPadding(
                safeBottom: MediaQuery.paddingOf(context).bottom,
              ),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index < sessions.length - 1
                        ? AppDesignTokens.spacingSm
                        : 0,
                  ),
                  child: _SessionCard(session: sessions[index]),
                );
              }, childCount: sessions.length),
            ),
          )
        else
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: AppDesignTokens.listEndPadding(
                safeBottom: MediaQuery.paddingOf(context).bottom,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _stepPeriod(BuildContext context, bool isDay, int delta) async {
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
    final cubit = context.read<InstructorEarningsCubit>();
    final selected = await pickInstructorPeriod(
      context: context,
      isDay: isDay,
      selectedDate: state.selectedDate,
    );
    if (selected == null) return;
    await cubit.selectDate(
      isDay ? selected : DateTime(selected.year, selected.month),
    );
  }
}

class _SessionCard extends StatelessWidget {
  const _SessionCard({required this.session});

  final InstructorEarningSessionEntity session;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = AppSemanticColors.of(context);
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
            style: TextStyle(color: colors.muted),
          ),
          const SizedBox(height: 2),
          Text(
            l10n.instructorEarningsPaidAt(
              AppDateFormatters.dateTimeLabel(session.paidAt, localeName),
            ),
            style: TextStyle(color: colors.muted),
          ),
        ],
      ),
    );
  }
}
