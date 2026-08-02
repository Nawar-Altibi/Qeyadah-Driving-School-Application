import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_alert_banner.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_mobile_bottom_nav.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/entities/student_home_dashboard_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/coordinators/student_home_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/cubit/student_home_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/formatters/student_home_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/navigation/student_home_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/widgets/student_home_greeting_header.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/widgets/student_home_next_lesson_card.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/widgets/student_home_quick_actions_section.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/widgets/student_home_training_progress_card.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  static const String routePath = '/student/home';
  static const String routeName = 'student-home';

  @override
  Widget build(BuildContext context) {
    return StudentHomeScreenCoordinator(
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
                    child: BlocBuilder<StudentHomeCubit, StudentHomeState>(
                      buildWhen: (previous, current) =>
                          previous.apiState != current.apiState ||
                          previous.isSilentRefresh != current.isSilentRefresh,
                      builder: (context, state) {
                        return state.apiState.when(
                          initial: () => const SizedBox.shrink(),
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          succeeded: (dashboard) =>
                              _StudentHomeContent(dashboard: dashboard),
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
                  activeId: 'home',
                  items: _bottomNavItems(context),
                  onItemSelected: (tabId) =>
                      StudentHomeNavigation.handleBottomNav(context, tabId),
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
        id: 'home',
        label: l10n.home,
        icon: PhosphorIconsBold.house,
      ),
      AppMobileBottomNavItem(
        id: 'bookings',
        label: l10n.studentHomeNavBookings,
        icon: PhosphorIconsBold.calendar,
      ),
      AppMobileBottomNavItem(
        id: 'certificate',
        label: l10n.studentHomeNavCertificate,
        icon: PhosphorIconsBold.certificate,
      ),
      AppMobileBottomNavItem(
        id: 'profile',
        label: l10n.studentHomeNavProfile,
        icon: PhosphorIconsBold.user,
      ),
    ];
  }
}

class _StudentHomeContent extends StatelessWidget {
  const _StudentHomeContent({required this.dashboard});

  final StudentHomeDashboardEntity dashboard;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final sessionUser = context.watch<AuthSessionCubit>().currentSession?.user;
    final studentName = sessionUser?.displayName ?? '';
    final isBlocked = sessionUser?.isBlocked ?? false;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppDesignTokens.screenHorizontalPadding,
        AppDesignTokens.spacingMd,
        AppDesignTokens.screenHorizontalPadding,
        AppDesignTokens.bottomNavHeight + AppDesignTokens.spacing2xl,
      ),
      children: [
        if (isBlocked) ...[
          AppAlertBanner(
            tone: AppAlertTone.danger,
            icon: PhosphorIconsBold.prohibit,
            title: l10n.studentHomeBlockedTitle,
            message: l10n.studentHomeBlockedMessage,
          ),
          const SizedBox(height: AppDesignTokens.spacingMd),
        ],
        StudentHomeGreetingHeader(
          dateLabel: StudentHomeFormatters.dateLabel(
            dashboard.referenceDate,
            localeName,
          ),
          greeting: StudentHomeFormatters.greetingFor(
            l10n: l10n,
            name: studentName,
            referenceDate: dashboard.referenceDate,
          ),
          hasUnreadNotifications: dashboard.hasUnreadNotifications,
          onNotificationsTap: () =>
              StudentHomeNavigation.showComingSoon(context),
        ),
        const SizedBox(height: AppDesignTokens.spacingLg),
        if (dashboard.nextLesson != null)
          StudentHomeNextLessonCard(
            lesson: dashboard.nextLesson!,
            localeName: localeName,
            onDirectionsTap: () =>
                StudentHomeNavigation.showComingSoon(context),
          )
        else
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.studentHomeNoNextLessonTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: AppDesignTokens.spacingSm),
                Text(
                  l10n.studentHomeNoNextLessonBody,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
                ),
              ],
            ),
          ),
        if (dashboard.pendingPayment != null) ...[
          const SizedBox(height: AppDesignTokens.spacingMd),
          InkWell(
            borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
            onTap: dashboard.pendingPayment!.canResumePayment
                ? () => StudentHomeNavigation.resumePendingPayment(
                    context: context,
                    pendingPayment: dashboard.pendingPayment!,
                  )
                : null,
            child: AppAlertBanner(
              icon: PhosphorIconsBold.timer,
              title: l10n.studentHomePendingPaymentTitle,
              message: dashboard.pendingPayment!.canResumePayment
                  ? '${l10n.studentHomePendingPaymentMessage(StudentHomeFormatters.paymentCountdown(minutes: dashboard.pendingPayment!.remainingMinutes, seconds: dashboard.pendingPayment!.remainingSeconds))} ${l10n.studentHomePendingPaymentCta}'
                  : l10n.studentHomePendingPaymentMessage(
                      StudentHomeFormatters.paymentCountdown(
                        minutes: dashboard.pendingPayment!.remainingMinutes,
                        seconds: dashboard.pendingPayment!.remainingSeconds,
                      ),
                    ),
            ),
          ),
        ],
        const SizedBox(height: AppDesignTokens.spacingLg),
        StudentHomeQuickActionsSection(
          actions: dashboard.quickActions,
          isActionEnabled: (action) =>
              !isBlocked ||
              (action != StudentHomeQuickActionType.newBooking &&
                  action != StudentHomeQuickActionType.certificateRequest),
          onActionTap: (action) =>
              StudentHomeNavigation.handleQuickAction(context, action),
          onViewAllTap: () => StudentHomeNavigation.showComingSoon(context),
        ),
        const SizedBox(height: AppDesignTokens.spacingMd),
        StudentHomeTrainingProgressCard(progress: dashboard.trainingProgress),
      ],
    );
  }
}
