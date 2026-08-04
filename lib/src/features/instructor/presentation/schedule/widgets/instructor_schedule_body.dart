import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_calendar_strip.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_segmented_control.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/cubit/instructor_schedule_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/widgets/instructor_schedule_timeline.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/widgets/instructor_schedule_widgets.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/shared/formatters/instructor_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/shared/navigation/instructor_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/cubit/notifications_unread_cubit.dart';

class InstructorScheduleBody extends StatelessWidget {
  const InstructorScheduleBody({
    super.key,
    required this.dashboard,
    this.interactive = true,
  });

  final InstructorScheduleDashboardEntity dashboard;
  final bool interactive;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final calendarDays = InstructorFormatters.weekAround(
      dashboard.selectedDate,
    );
    return RefreshIndicator(
      onRefresh: () =>
          context.read<InstructorScheduleCubit>().load(silent: true),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
          AppDesignTokens.screenHorizontalPadding,
          AppDesignTokens.spacingMd,
          AppDesignTokens.screenHorizontalPadding,
          AppDesignTokens.listEndPadding(
            safeBottom: MediaQuery.paddingOf(context).bottom,
            extraBottom: AppDesignTokens.bottomNavHeight,
          ),
        ),
        children: [
          InstructorScheduleGreetingHeader(
            name: dashboard.profile.name,
            unreadCount: context.select(
              (NotificationsUnreadCubit cubit) => cubit.state,
            ),
            onNotificationsTap: interactive
                ? () => InstructorNavigation.openNotifications(context)
                : null,
          ),
          const SizedBox(height: AppDesignTokens.spacingLg),
          InstructorScheduleSummaryCard(
            dashboard: dashboard,
            localeName: localeName,
          ),
          const SizedBox(height: AppDesignTokens.spacingLg),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      InstructorFormatters.monthYearLabel(
                        dashboard.selectedDate,
                        localeName,
                      ),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      InstructorFormatters.fullDateLabel(
                        dashboard.selectedDate,
                        localeName,
                      ),
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                    ),
                  ],
                ),
              ),
              Material(
                color: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.line),
                ),
                child: InkWell(
                  onTap: interactive ? () => _pickDate(context) : null,
                  borderRadius: BorderRadius.circular(12),
                  child: const SizedBox(
                    width: 36,
                    height: 36,
                    child: Icon(
                      PhosphorIconsBold.calendar,
                      size: 18,
                      color: AppColors.brandPrimary,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDesignTokens.spacing),
          if (dashboard.viewMode == InstructorBookingsViewMode.day)
            AppCalendarStrip(
              days: calendarDays,
              selectedDate: dashboard.selectedDate,
              weekdayLabelBuilder: (date) =>
                  InstructorFormatters.shortWeekday(date, localeName),
              dayNumberBuilder: InstructorFormatters.dayNumber,
              onDaySelected: interactive
                  ? (date) =>
                        context.read<InstructorScheduleCubit>().selectDate(date)
                  : (_) {},
              hasEventsForDay: (date) =>
                  _isSameDay(date, dashboard.selectedDate) &&
                  dashboard.bookings.isNotEmpty,
            ),
          const SizedBox(height: AppDesignTokens.spacingLg),
          Row(
            children: [
              Expanded(
                child: Text(
                  dashboard.viewMode == InstructorBookingsViewMode.day
                      ? l10n.instructorDailyTimeline
                      : l10n.instructorWeeklyBookings,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                width: 148,
                child: AppSegmentedControl<InstructorBookingsViewMode>(
                  value: dashboard.viewMode,
                  items: [
                    AppSegmentedItem(
                      value: InstructorBookingsViewMode.day,
                      label: l10n.instructorViewDay,
                    ),
                    AppSegmentedItem(
                      value: InstructorBookingsViewMode.week,
                      label: l10n.instructorViewWeek,
                    ),
                  ],
                  onChanged: interactive
                      ? context.read<InstructorScheduleCubit>().setViewMode
                      : (_) {},
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDesignTokens.spacing),
          if (dashboard.viewMode == InstructorBookingsViewMode.day)
            InstructorScheduleTimeline(
              bookings: dashboard.bookings,
              localeName: localeName,
            )
          else
            _InstructorWeeklyBookings(
              dashboard: dashboard,
              localeName: localeName,
            ),
        ],
      ),
    );
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: dashboard.selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && context.mounted) {
      await context.read<InstructorScheduleCubit>().selectDate(picked);
    }
  }
}

class _InstructorWeeklyBookings extends StatelessWidget {
  const _InstructorWeeklyBookings({
    required this.dashboard,
    required this.localeName,
  });

  final InstructorScheduleDashboardEntity dashboard;
  final String localeName;

  @override
  Widget build(BuildContext context) {
    final groupedBookings = dashboard.bookingsByDate;
    if (groupedBookings.isEmpty) {
      return AppCard(
        child: Text(
          AppLocalizations.of(context).instructorNoSessionsThisWeek,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final entry in groupedBookings.entries) ...[
          Text(
            InstructorFormatters.fullDateLabel(entry.key, localeName),
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppDesignTokens.spacingSm),
          for (final booking in entry.value) ...[
            InstructorLessonCard(booking: booking),
            const SizedBox(height: AppDesignTokens.spacing),
          ],
          const SizedBox(height: AppDesignTokens.spacingSm),
        ],
      ],
    );
  }
}
