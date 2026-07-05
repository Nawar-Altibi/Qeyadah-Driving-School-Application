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
import 'package:qeyadah_mobile_app/src/core/ui/app_segmented_control.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_leave/presentation/coordinators/instructor_leave_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_leave/presentation/cubit/instructor_leave_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/formatters/instructor_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/navigation/instructor_navigation.dart';

class InstructorLeaveScreen extends StatelessWidget {
  const InstructorLeaveScreen({super.key});

  static const String routePath = '/instructor/leave-request';
  static const String routeName = 'instructor-leave-request';

  @override
  Widget build(BuildContext context) {
    return InstructorLeaveScreenCoordinator(
      child: Scaffold(
        backgroundColor: AppColors.appCanvas,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).instructorLeaveTitle),
          centerTitle: true,
        ),
        body: ResponsiveShell(
          child: BlocBuilder<InstructorLeaveCubit, InstructorLeaveState>(
            builder: (context, state) {
              return state.apiState.when(
                initial: () => const SizedBox.shrink(),
                loading: () => const Center(child: CircularProgressIndicator()),
                succeeded: (leaves) => _LeaveContent(
                  leaves: leaves,
                  showFullDayOnly: state.showFullDayOnly,
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
                            CoreFailureMessageMapper.messageFor(failure, l10n),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppDesignTokens.spacingMd),
                          AppButton.primary(label: l10n.retry, onPressed: retry),
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
    );
  }
}

class _LeaveContent extends StatelessWidget {
  const _LeaveContent({
    required this.leaves,
    required this.showFullDayOnly,
  });

  final List<InstructorLeaveEntity> leaves;
  final bool showFullDayOnly;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final filtered = leaves
        .where((leave) => showFullDayOnly ? leave.isFullDay : !leave.isFullDay)
        .toList();

    return ListView(
      padding: const EdgeInsets.all(AppDesignTokens.screenHorizontalPadding),
      children: [
        Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.brandMintSoft,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(
                PhosphorIconsBold.calendar,
                color: AppColors.brandPrimary,
              ),
            ),
            const SizedBox(height: AppDesignTokens.spacingSm),
            Text(
              l10n.instructorLeaveIntroTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.instructorLeaveIntroBody,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.muted,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppDesignTokens.spacingMd),
        AppSegmentedControl<bool>(
          value: showFullDayOnly,
          onChanged: (value) => context
              .read<InstructorLeaveCubit>()
              .setLeaveFilter(fullDay: value),
          items: [
            AppSegmentedItem(value: false, label: l10n.instructorLeaveHourlyTab),
            AppSegmentedItem(value: true, label: l10n.instructorLeaveDailyTab),
          ],
        ),
        const SizedBox(height: AppDesignTokens.spacingMd),
        AppAlertBanner(
          tone: AppAlertTone.info,
          icon: PhosphorIconsBold.info,
          title: l10n.instructorLeaveAdminNoticeTitle,
          message: l10n.instructorLeaveAdminNoticeBody,
        ),
        const SizedBox(height: AppDesignTokens.spacingMd),
        if (filtered.isEmpty)
          AppCard(
            child: Text(
              l10n.instructorLeaveEmpty,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.muted,
              ),
            ),
          )
        else
          ...filtered.map(
            (leave) => Padding(
              padding: const EdgeInsets.only(bottom: AppDesignTokens.spacingSm),
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      InstructorFormatters.leavePeriodLabel(
                        l10n,
                        leave,
                        localeName,
                      ),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (leave.reason?.trim().isNotEmpty ?? false) ...[
                      const SizedBox(height: AppDesignTokens.spacingSm),
                      Text(
                        leave.reason!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(height: AppDesignTokens.spacingLg),
        AppButton.primary(
          label: l10n.instructorContactManagement,
          onPressed: () => InstructorNavigation.showComingSoon(context),
        ),
        const SizedBox(height: AppDesignTokens.spacingSm),
        AppButton.secondary(
          label: l10n.instructorCancel,
          onPressed: () => CoreNavigator.pop(context),
        ),
      ],
    );
  }
}
