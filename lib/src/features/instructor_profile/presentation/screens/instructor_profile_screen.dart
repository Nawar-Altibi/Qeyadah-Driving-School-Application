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
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_metric_tile.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_mobile_bottom_nav.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_profile/presentation/coordinators/instructor_profile_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_profile/presentation/cubit/instructor_profile_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/formatters/instructor_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/navigation/instructor_navigation.dart';

class InstructorProfileScreen extends StatelessWidget {
  const InstructorProfileScreen({super.key});

  static const String routePath = '/instructor/profile';
  static const String routeName = 'instructor-profile';

  @override
  Widget build(BuildContext context) {
    return InstructorProfileScreenCoordinator(
      child: Scaffold(
        backgroundColor: AppColors.appCanvas,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: BlocBuilder<InstructorProfileCubit, InstructorProfileState>(
                  buildWhen: (previous, current) =>
                      previous.apiState != current.apiState,
                  builder: (context, state) {
                    return state.apiState.when(
                      initial: () => const SizedBox.shrink(),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      succeeded: (dashboard) => _ProfileContent(
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
              Positioned(
                left: AppDesignTokens.screenHorizontalPadding,
                right: AppDesignTokens.screenHorizontalPadding,
                bottom: AppDesignTokens.spacing,
                child: AppMobileBottomNav(
                  activeId: 'profile',
                  items: _bottomNavItems(context),
                  onItemSelected: (tabId) =>
                      InstructorNavigation.handleBottomNav(context, tabId),
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

class _ProfileContent extends StatelessWidget {
  const _ProfileContent({required this.dashboard});

  final InstructorProfileDashboardEntity dashboard;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final profile = dashboard.profile;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            decoration: const BoxDecoration(
              gradient: AppGradients.heroEmerald,
            ),
            padding: const EdgeInsets.fromLTRB(
              AppDesignTokens.screenHorizontalPadding,
              AppDesignTokens.spacingSm,
              AppDesignTokens.screenHorizontalPadding,
              AppDesignTokens.spacing2xl,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Spacer(),
                    Text(
                      l10n.instructorProfileTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Transform.translate(
            offset: const Offset(0, -28),
            child: ResponsiveShell(
              child: ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  AppDesignTokens.screenHorizontalPadding,
                  0,
                  AppDesignTokens.screenHorizontalPadding,
                  AppDesignTokens.bottomNavHeight + AppDesignTokens.spacing2xl,
                ),
                children: [
                  Column(
                    children: [
                      InstructorAvatar(
                        initials: InstructorFormatters.initials(profile.name),
                        size: 84,
                      ),
                      const SizedBox(height: AppDesignTokens.spacing),
                      Text(
                        profile.name,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        l10n.instructorRoleLabel,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.muted,
                        ),
                      ),
                      const SizedBox(height: AppDesignTokens.spacingSm),
                      Text(
                        l10n.instructorProfileBio,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.muted,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: AppDesignTokens.spacingMd),
                      AppButton.secondary(
                        label: l10n.instructorContactManagement,
                        icon: PhosphorIconsBold.chatCircle,
                        onPressed: () =>
                            InstructorNavigation.showComingSoon(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDesignTokens.spacingLg),
                  Row(
                    children: [
                      Expanded(
                        child: AppMetricTile(
                          label: l10n.instructorMetricMonthSessions,
                          value: '${dashboard.monthEarnings.monthSessionsCount}',
                          icon: PhosphorIconsBold.clock,
                        ),
                      ),
                      const SizedBox(width: AppDesignTokens.spacing),
                      Expanded(
                        child: AppMetricTile(
                          label: l10n.instructorMetricMonthEarnings,
                          value: InstructorFormatters.currencyAmount(
                            l10n,
                            dashboard.monthEarnings.monthTotal,
                          ),
                          icon: PhosphorIconsBold.star,
                        ),
                      ),
                      const SizedBox(width: AppDesignTokens.spacing),
                      Expanded(
                        child: AppMetricTile(
                          label: l10n.instructorMetricVehicle,
                          value: InstructorFormatters.trainingTypeLabel(
                            l10n,
                            profile.instructorType,
                          ),
                          icon: PhosphorIconsBold.car,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDesignTokens.spacingLg),
                  Text(
                    l10n.instructorAccountPreferences,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.muted,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
                  ),
                  const SizedBox(height: AppDesignTokens.spacingSm),
                  AppCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        InstructorSettingsRow(
                          icon: PhosphorIconsBold.user,
                          label: l10n.instructorProfileData,
                          onTap: () => InstructorNavigation.showComingSoon(context),
                        ),
                        const Divider(height: 1, color: AppColors.line),
                        InstructorSettingsRow(
                          icon: PhosphorIconsBold.calendar,
                          label: l10n.instructorSchedulePreferences,
                          onTap: () => InstructorNavigation.showComingSoon(context),
                        ),
                        const Divider(height: 1, color: AppColors.line),
                        InstructorSettingsRow(
                          icon: PhosphorIconsBold.translate,
                          label: l10n.instructorLanguage,
                          onTap: () => InstructorNavigation.showComingSoon(context),
                        ),
                        const Divider(height: 1, color: AppColors.line),
                        InstructorSettingsRow(
                          icon: PhosphorIconsBold.bell,
                          label: l10n.instructorNotifications,
                          onTap: () => InstructorNavigation.showComingSoon(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDesignTokens.spacingMd),
                  AppCard(
                    padding: EdgeInsets.zero,
                    child: InstructorSettingsRow(
                      icon: PhosphorIconsBold.signOut,
                      label: l10n.logout,
                      danger: true,
                      showChevron: false,
                      onTap: () => context.read<AuthSessionCubit>().logout(),
                    ),
                  ),
                  const SizedBox(height: AppDesignTokens.spacingMd),
                  Center(
                    child: Text(
                      l10n.instructorAppVersion,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.muted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
