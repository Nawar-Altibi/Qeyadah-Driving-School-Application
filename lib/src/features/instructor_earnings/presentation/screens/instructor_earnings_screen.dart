import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_metric_tile.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_section_heading.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_segmented_control.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_earnings/presentation/cubit/instructor_earnings_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/formatters/instructor_formatters.dart';

class InstructorEarningsScreen extends StatefulWidget {
  const InstructorEarningsScreen({super.key});

  static const routePath = '/instructor/earnings';
  static const routeName = 'instructor-earnings';

  @override
  State<InstructorEarningsScreen> createState() =>
      _InstructorEarningsScreenState();
}

class _InstructorEarningsScreenState extends State<InstructorEarningsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InstructorEarningsCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.appCanvas,
      appBar: AppBar(title: Text(l10n.instructorEarningsTitle)),
      body: BlocBuilder<InstructorEarningsCubit, InstructorEarningsState>(
        builder: (context, state) => state.apiState.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator()),
          succeeded: (earnings) =>
              _EarningsBody(state: state, earnings: earnings),
          failed: (failure, retry) => Center(
            child: AppButton.primary(
              label: CoreFailureMessageMapper.messageFor(failure, l10n),
              onPressed: retry,
            ),
          ),
        ),
      ),
    );
  }
}

class _EarningsBody extends StatelessWidget {
  const _EarningsBody({required this.state, required this.earnings});

  final InstructorEarningsState state;
  final InstructorEarningsEntity earnings;

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
          onChanged: context.read<InstructorEarningsCubit>().setViewMode,
        ),
        const SizedBox(height: AppDesignTokens.spacing),
        AppButton.secondary(
          label: isDay
              ? DateFormat.yMMMMd(
                  Localizations.localeOf(context).toLanguageTag(),
                ).format(state.selectedDate)
              : DateFormat.yMMMM(
                  Localizations.localeOf(context).toLanguageTag(),
                ).format(state.selectedDate),
          onPressed: () => _pickPeriod(context, isDay),
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

  Future<void> _pickPeriod(BuildContext context, bool isDay) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: state.selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      helpText: isDay
          ? AppLocalizations.of(context).instructorEarningsPickDay
          : AppLocalizations.of(context).instructorEarningsPickMonth,
    );
    if (selected == null || !context.mounted) return;
    await context.read<InstructorEarningsCubit>().selectDate(
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
