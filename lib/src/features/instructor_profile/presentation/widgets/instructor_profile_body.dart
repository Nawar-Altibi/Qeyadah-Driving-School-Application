import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_calendar_strip.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/formatters/instructor_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/navigation/instructor_navigation.dart';

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
    final profile = dashboard.profile;
    final leaveStatus = profile.leaveStatus?.trim();
    final details = <_ProfileDetail>[
      _ProfileDetail(
        icon: PhosphorIconsBold.phone,
        label: l10n.profilePhone,
        value: profile.phone,
        valueDirection: TextDirection.ltr,
      ),
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
        value: leaveStatus == null || leaveStatus.isEmpty
            ? l10n.instructorProfileNoLeave
            : leaveStatus,
      ),
    ];

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            decoration: const BoxDecoration(gradient: AppGradients.heroEmerald),
            padding: const EdgeInsets.fromLTRB(
              AppDesignTokens.screenHorizontalPadding,
              AppDesignTokens.spacingMd,
              AppDesignTokens.screenHorizontalPadding,
              64,
            ),
            alignment: Alignment.topCenter,
            child: Text(
              l10n.instructorProfileTitle,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Transform.translate(
            offset: const Offset(0, -42),
            child: ResponsiveShell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppDesignTokens.screenHorizontalPadding,
                  0,
                  AppDesignTokens.screenHorizontalPadding,
                  AppDesignTokens.bottomNavHeight + AppDesignTokens.spacing2xl,
                ),
                child: Column(
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.appCanvas,
                          width: 4,
                        ),
                      ),
                      child: InstructorAvatar(
                        initials: InstructorFormatters.initials(profile.name),
                        size: 84,
                      ),
                    ),
                    const SizedBox(height: AppDesignTokens.spacing),
                    Text(
                      profile.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    Text(
                      l10n.instructorRoleLabel,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
                    ),
                    const SizedBox(height: AppDesignTokens.spacingLg),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        l10n.instructorProfileData,
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              color: AppColors.muted,
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
                            _InstructorProfileInfoRow(detail: details[index]),
                            if (index != details.length - 1)
                              const Divider(height: 1, color: AppColors.line),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDesignTokens.spacingMd),
                    AppCard(
                      padding: EdgeInsets.zero,
                      child: Column(
                        children: [
                          InstructorSettingsRow(
                            icon: PhosphorIconsBold.calendarCheck,
                            label: l10n.instructorLeaveTitle,
                            onTap: interactive
                                ? () => InstructorNavigation.openLeaves(context)
                                : null,
                          ),
                          const Divider(height: 1, color: AppColors.line),
                          InstructorSettingsRow(
                            icon: PhosphorIconsBold.signOut,
                            label: l10n.logout,
                            danger: true,
                            showChevron: false,
                            onTap: interactive
                                ? () =>
                                      context.read<AuthSessionCubit>().logout()
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
        ),
      ],
    );
  }
}

class _InstructorProfileInfoRow extends StatelessWidget {
  const _InstructorProfileInfoRow({required this.detail});

  final _ProfileDetail detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesignTokens.spacingMd,
        vertical: 14,
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: AppColors.brandMintSoft,
              shape: BoxShape.circle,
            ),
            child: Icon(detail.icon, size: 18, color: AppColors.brandPrimary),
          ),
          const SizedBox(width: AppDesignTokens.spacing),
          Expanded(
            child: Text(
              detail.label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
            ),
          ),
          const SizedBox(width: AppDesignTokens.spacingSm),
          Flexible(
            child: Text(
              detail.value,
              textDirection: detail.valueDirection,
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.ink,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileDetail {
  const _ProfileDetail({
    required this.icon,
    required this.label,
    required this.value,
    this.valueDirection,
  });

  final IconData icon;
  final String label;
  final String value;
  final TextDirection? valueDirection;
}
