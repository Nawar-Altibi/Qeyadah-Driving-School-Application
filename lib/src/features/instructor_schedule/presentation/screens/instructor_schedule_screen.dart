import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_calendar_strip.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_mobile_bottom_nav.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/coordinators/instructor_schedule_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/cubit/instructor_schedule_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/formatters/instructor_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/navigation/instructor_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/widgets/instructor_schedule_widgets.dart';

class InstructorScheduleScreen extends StatelessWidget {
  const InstructorScheduleScreen({super.key});

  static const String routePath = '/instructor/home';
  static const String routeName = 'instructor-home';

  @override
  Widget build(BuildContext context) {
    return InstructorScheduleScreenCoordinator(
      child: Scaffold(
        backgroundColor: AppColors.appCanvas,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    gradient: AppGradients.softMintBackground,
                  ),
                  child: ResponsiveShell(
                    child: BlocBuilder<InstructorScheduleCubit, InstructorScheduleState>(
                      buildWhen: (previous, current) =>
                          previous.apiState != current.apiState ||
                          previous.isSilentRefresh != current.isSilentRefresh,
                      builder: (context, state) {
                        return state.apiState.when(
                          initial: () => const SizedBox.shrink(),
                          loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          succeeded: (dashboard) => _ScheduleContent(
                            dashboard: dashboard,
                          ),
                          failed: (failure, retry) {
                            final l10n = AppLocalizations.of(context);
                            return Center(
                              child: Padding(
                                padding: PaddingManager.paddingAll16,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      CoreFailureMessageMapper.messageFor(
                                        failure,
                                        l10n,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(
                                      height: AppDesignTokens.spacingMd,
                                    ),
                                    AppButton.primary(
                                      label: l10n.retry,
                                      onPressed: retry,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                left: AppDesignTokens.screenHorizontalPadding,
                right: AppDesignTokens.screenHorizontalPadding,
                bottom: AppDesignTokens.spacing,
                child: AppMobileBottomNav(
                  activeId: 'schedule',
                  items: _bottomNavItems(context),
                  onItemSelected: (tabId) =>
                      InstructorNavigation.handleBottomNav(context, tabId),
                ),
              ),
              Positioned(
                left: AppDesignTokens.screenHorizontalPadding,
                bottom: AppDesignTokens.bottomNavHeight + AppDesignTokens.spacingLg,
                child: AppFloatingActionChip(
                  label: AppLocalizations.of(context).instructorRequestLeave,
                  onPressed: () => InstructorNavigation.openLeaveRequest(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static List<AppMobileBottomNavItem> _bottomNavItems(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return [
      AppMobileBottomNavItem(
        id: 'schedule',
        label: l10n.instructorNavSchedule,
        icon: PhosphorIconsBold.calendar,
      ),
      AppMobileBottomNavItem(
        id: 'profile',
        label: l10n.instructorNavProfile,
        icon: PhosphorIconsBold.user,
      ),
    ];
  }
}

class _ScheduleContent extends StatelessWidget {
  const _ScheduleContent({required this.dashboard});

  final InstructorScheduleDashboardEntity dashboard;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final calendarDays = InstructorFormatters.weekAround(dashboard.selectedDate);

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppDesignTokens.screenHorizontalPadding,
        AppDesignTokens.spacingMd,
        AppDesignTokens.screenHorizontalPadding,
        AppDesignTokens.bottomNavHeight + 96,
      ),
      children: [
        InstructorScheduleGreetingHeader(
          name: dashboard.profile.name,
          onNotificationsTap: () => InstructorNavigation.showComingSoon(context),
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
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.muted,
                    ),
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
                onTap: () => _pickDate(context),
                borderRadius: BorderRadius.circular(12),
                child: const SizedBox(
                  width: 36,
                  height: 36,
                  child: Icon(
                    PhosphorIconsBold.calendar,
                    size: 18,
                    color: AppColors.brandPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDesignTokens.spacing),
        AppCalendarStrip(
          days: calendarDays,
          selectedDate: dashboard.selectedDate,
          weekdayLabelBuilder: (date) =>
              InstructorFormatters.shortWeekday(date, localeName),
          dayNumberBuilder: InstructorFormatters.dayNumber,
          onDaySelected: (date) =>
              context.read<InstructorScheduleCubit>().selectDate(date),
          hasEventsForDay: (date) => _isSameDay(date, dashboard.selectedDate) &&
              dashboard.bookings.isNotEmpty,
        ),
        const SizedBox(height: AppDesignTokens.spacingLg),
        Row(
          children: [
            Text(
              l10n.instructorDailyTimeline,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Row(
              children: [
                Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: Color(0xFF35A66D),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  l10n.instructorLiveSchedule,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.brandPrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppDesignTokens.spacing),
        InstructorTimelineSection(
          bookings: dashboard.bookings,
          localeName: localeName,
        ),
      ],
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
