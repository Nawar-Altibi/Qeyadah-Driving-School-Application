import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_appearance_section.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_calendar_strip.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_info_row.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_status_badge.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/shared/formatters/instructor_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/shared/navigation/instructor_navigation.dart';

class InstructorProfileBody extends StatelessWidget {
  const InstructorProfileBody({
    super.key,
    required this.dashboard,
    this.interactive = true,
  });

  final InstructorProfileDashboardEntity dashboard;
  final bool interactive;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = AppSemanticColors.of(context);
    final profile = dashboard.profile;
    final leaveStatus = profile.leaveStatus?.trim();
    final details = <_ProfileDetail>[
      _ProfileDetail(
        icon: PhosphorIconsBold.genderIntersex,
        label: l10n.instructorProfileGender,
        value: profile.gender.toUpperCase() == 'FEMALE'
            ? l10n.instructorProfileGenderFemale
            : l10n.instructorProfileGenderMale,
      ),
      _ProfileDetail(
        icon: PhosphorIconsBold.steeringWheel,
        label: l10n.instructorProfileTrainingType,
        value: InstructorFormatters.trainingTypeLabel(
          l10n,
          profile.instructorType,
        ),
      ),
      _ProfileDetail(
        icon: PhosphorIconsBold.shieldCheck,
        label: l10n.instructorProfileAccountStatus,
        value: profile.accountStatus.toUpperCase() == 'ACTIVE'
            ? l10n.instructorProfileStatusActive
            : profile.accountStatus,
      ),
      _ProfileDetail(
        icon: PhosphorIconsBold.wallet,
        label: l10n.instructorProfileSessionWage,
        value: InstructorFormatters.currencyAmount(l10n, profile.sessionWage),
      ),
      _ProfileDetail(
        icon: PhosphorIconsBold.calendarCheck,
        label: l10n.instructorProfileTodayLessons,
        value: '${profile.todayLessonsCount}',
      ),
      _ProfileDetail(
        icon: PhosphorIconsBold.calendarX,
        label: l10n.instructorProfileLeaveStatus,
        value: InstructorFormatters.leaveStatusLabel(l10n, leaveStatus),
      ),
    ];

    final isActive = profile.accountStatus.toUpperCase() == 'ACTIVE';

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _InstructorProfileHeader(
            title: l10n.instructorProfileTitle,
            name: profile.name,
            roleLabel: l10n.instructorRoleLabel,
            statusLabel: isActive
                ? l10n.instructorProfileStatusActive
                : profile.accountStatus,
            isActive: isActive,
          ),
        ),
        SliverToBoxAdapter(
          child: ResponsiveShell(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                AppDesignTokens.screenHorizontalPadding,
                AppDesignTokens.spacingMd,
                AppDesignTokens.screenHorizontalPadding,
                AppDesignTokens.listEndPadding(
                  safeBottom: MediaQuery.paddingOf(context).bottom,
                  extraBottom: AppDesignTokens.bottomNavHeight,
                ),
              ),
              child: Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      l10n.instructorProfileData,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: colors.muted,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDesignTokens.spacingSm),
                  AppCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        for (
                          var index = 0;
                          index < details.length;
                          index++
                        ) ...[
                          AppInfoRow.inline(
                            icon: details[index].icon,
                            label: details[index].label,
                            value: details[index].value,
                          ),
                          if (index != details.length - 1)
                            Divider(height: 1, color: colors.line),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDesignTokens.spacingMd),
                  const AppAppearanceSection(),
                  const SizedBox(height: AppDesignTokens.spacingMd),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      l10n.instructorProfileSettings,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: colors.muted,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDesignTokens.spacingSm),
                  AppCard(
                    padding: EdgeInsets.zero,
                    child: Column(
                      children: [
                        InstructorSettingsRow(
                          icon: PhosphorIconsBold.calendarCheck,
                          label: l10n.instructorWeeklyScheduleTitle,
                          onTap: interactive
                              ? () => InstructorNavigation.openWeeklySchedule(
                                  context,
                                )
                              : null,
                        ),
                        Divider(height: 1, color: colors.line),
                        InstructorSettingsRow(
                          icon: PhosphorIconsBold.calendarX,
                          label: l10n.instructorLeaveTitle,
                          onTap: interactive
                              ? () => InstructorNavigation.openLeaves(context)
                              : null,
                        ),
                        Divider(height: 1, color: colors.line),
                        InstructorSettingsRow(
                          icon: PhosphorIconsBold.wallet,
                          label: l10n.instructorDuesTitle,
                          onTap: interactive
                              ? () => InstructorNavigation.openDues(context)
                              : null,
                        ),
                        Divider(height: 1, color: colors.line),
                        InstructorSettingsRow(
                          icon: PhosphorIconsBold.money,
                          label: l10n.instructorEarningsTitle,
                          onTap: interactive
                              ? () => InstructorNavigation.openEarnings(context)
                              : null,
                        ),
                        Divider(height: 1, color: colors.line),
                        InstructorSettingsRow(
                          icon: PhosphorIconsBold.receipt,
                          label: l10n.instructorInvoicesTitle,
                          onTap: interactive
                              ? () => InstructorNavigation.openInvoices(context)
                              : null,
                        ),
                        Divider(height: 1, color: colors.line),
                        InstructorSettingsRow(
                          icon: PhosphorIconsBold.signOut,
                          label: l10n.logout,
                          danger: true,
                          showChevron: false,
                          onTap: interactive
                              ? () => context.read<AuthSessionCubit>().logout()
                              : null,
                        ),
                      ],
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

class _InstructorProfileHeader extends StatelessWidget {
  const _InstructorProfileHeader({
    required this.title,
    required this.name,
    required this.roleLabel,
    required this.statusLabel,
    required this.isActive,
  });

  final String title;
  final String name;
  final String roleLabel;
  final String statusLabel;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: AppGradients.heroEmerald,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(AppDesignTokens.radiusXl),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x330B3F28),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(AppDesignTokens.radiusXl),
        ),
        child: Stack(
          children: [
            const Positioned(
              top: -36,
              right: -28,
              child: _HeaderGlow(size: 140, opacity: 0.16),
            ),
            const Positioned(
              bottom: -48,
              left: -20,
              child: _HeaderGlow(size: 160, opacity: 0.12),
            ),
            const Positioned(
              top: 48,
              left: 40,
              child: _HeaderGlow(size: 64, opacity: 0.1),
            ),
            SafeArea(
              bottom: false,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppDesignTokens.screenHorizontalPadding,
                    AppDesignTokens.spacingSm,
                    AppDesignTokens.screenHorizontalPadding,
                    AppDesignTokens.spacingXl,
                  ),
                  child: Column(
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: AppColors.white.withValues(alpha: 0.92),
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                      const SizedBox(height: AppDesignTokens.spacingLg),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.white.withValues(alpha: 0.14),
                          border: Border.all(
                            color: AppColors.white.withValues(alpha: 0.28),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.18),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: InstructorAvatar(
                          initials: InstructorFormatters.initials(name),
                          size: 84,
                          tone: InstructorAvatarTone.light,
                        ),
                      ),
                      const SizedBox(height: AppDesignTokens.spacing),
                      Text(
                        name,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        roleLabel,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.white.withValues(alpha: 0.78),
                        ),
                      ),
                      const SizedBox(height: AppDesignTokens.spacingSm),
                      AppStatusBadge(
                        label: statusLabel,
                        tone: isActive
                            ? AppBadgeTone.success
                            : AppBadgeTone.neutral,
                        icon: isActive
                            ? PhosphorIconsBold.checkCircle
                            : PhosphorIconsBold.info,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderGlow extends StatelessWidget {
  const _HeaderGlow({required this.size, required this.opacity});

  final double size;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white.withValues(alpha: opacity),
        ),
      ),
    );
  }
}

class _ProfileDetail {
  const _ProfileDetail({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}
