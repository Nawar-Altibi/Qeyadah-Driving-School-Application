import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_section_heading.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/cubit/instructor_weekly_schedule_cubit.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_day_of_week.dart';

class InstructorWeeklyScheduleScreen extends StatefulWidget {
  const InstructorWeeklyScheduleScreen({super.key});

  static const routePath = '/instructor/weekly-schedule';
  static const routeName = 'instructor-weekly-schedule';

  @override
  State<InstructorWeeklyScheduleScreen> createState() =>
      _InstructorWeeklyScheduleScreenState();
}

class _InstructorWeeklyScheduleScreenState
    extends State<InstructorWeeklyScheduleScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InstructorWeeklyScheduleCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.appCanvas,
      appBar: AppBar(title: Text(l10n.instructorWeeklyScheduleTitle)),
      body:
          BlocBuilder<
            InstructorWeeklyScheduleCubit,
            InstructorWeeklyScheduleState
          >(
            builder: (context, state) => state.apiState.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const _WeeklyScheduleSkeleton(),
              succeeded: (schedule) => _WeeklyScheduleBody(schedule: schedule),
              failed: (failure, retry) => Center(
                child: Padding(
                  padding: PaddingManager.paddingAll16,
                  child: AppButton.primary(
                    label: CoreFailureMessageMapper.messageFor(failure, l10n),
                    onPressed: retry,
                  ),
                ),
              ),
            ),
          ),
    );
  }
}

class _WeeklyScheduleBody extends StatelessWidget {
  const _WeeklyScheduleBody({required this.schedule});

  final List<InstructorScheduleDayEntity> schedule;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final byDay = {for (final item in schedule) item.dayOfWeek: item};
    return ListView(
      padding: const EdgeInsets.all(AppDesignTokens.screenHorizontalPadding),
      children: [
        AppSectionHeading(
          title: l10n.instructorWeeklyScheduleTitle,
          subtitle: l10n.instructorWeeklyScheduleSubtitle,
        ),
        const SizedBox(height: AppDesignTokens.spacingMd),
        for (final day in InstructorDayOfWeek.values) ...[
          _ScheduleDayCard(
            label: _dayLabel(l10n, day),
            schedule: byDay[day.apiValue],
          ),
          const SizedBox(height: AppDesignTokens.spacing),
        ],
      ],
    );
  }

  String _dayLabel(AppLocalizations l10n, InstructorDayOfWeek day) =>
      switch (day) {
        InstructorDayOfWeek.sat => l10n.instructorDaySaturday,
        InstructorDayOfWeek.sun => l10n.instructorDaySunday,
        InstructorDayOfWeek.mon => l10n.instructorDayMonday,
        InstructorDayOfWeek.tue => l10n.instructorDayTuesday,
        InstructorDayOfWeek.wed => l10n.instructorDayWednesday,
        InstructorDayOfWeek.thu => l10n.instructorDayThursday,
        InstructorDayOfWeek.fri => l10n.instructorDayFriday,
      };
}

class _ScheduleDayCard extends StatelessWidget {
  const _ScheduleDayCard({required this.label, required this.schedule});

  final String label;
  final InstructorScheduleDayEntity? schedule;

  @override
  Widget build(BuildContext context) {
    final periods =
        schedule?.periods ?? const <InstructorSchedulePeriodEntity>[];
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: AppDesignTokens.spacingSm),
          if (periods.isEmpty)
            Row(
              children: [
                const AppNonMirroredIcon(
                  PhosphorIconsBold.calendarX,
                  color: AppColors.muted,
                  size: 18,
                ),
                const SizedBox(width: AppDesignTokens.spacingSm),
                Text(
                  AppLocalizations.of(context).instructorDayOff,
                  style: const TextStyle(color: AppColors.muted),
                ),
              ],
            )
          else
            Wrap(
              spacing: AppDesignTokens.spacingSm,
              runSpacing: AppDesignTokens.spacingSm,
              children: [
                for (final period in periods)
                  Chip(label: Text('${period.startTime} – ${period.endTime}')),
              ],
            ),
        ],
      ),
    );
  }
}

class _WeeklyScheduleSkeleton extends StatelessWidget {
  const _WeeklyScheduleSkeleton();

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final placeholder = [
      for (var i = 0; i < 7; i++)
        InstructorScheduleDayEntity.placeholderForDate(
          today.add(Duration(days: i)),
        ),
    ];
    return AppSkeletonizer(
      child: _WeeklyScheduleBody(schedule: placeholder),
    );
  }
}
