import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_alert_banner.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/formatters/instructor_formatters.dart';

class InstructorLeaveBody extends StatelessWidget {
  const InstructorLeaveBody({super.key, required this.leaves});

  final List<InstructorLeaveEntity> leaves;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();
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
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.instructorLeaveIntroBody,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
            ),
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
        if (leaves.isEmpty)
          AppCard(
            child: Text(
              l10n.instructorLeaveEmpty,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
            ),
          )
        else
          ...leaves.map(
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
                        '${l10n.instructorLeaveReasonLabel}: ${leave.reason!}',
                        style: Theme.of(
                          context,
                        ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        const SizedBox(height: AppDesignTokens.spacingLg),
      ],
    );
  }
}
