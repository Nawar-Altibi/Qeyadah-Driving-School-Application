import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card_header.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_meta_row.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_status_badge.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/certificate_eligibility_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificates_hub_state.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/formatters/student_certificates_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/widgets/student_certificate_status_timeline.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/certificate_category.dart';

class StudentCertificatesHubBody extends StatelessWidget {
  const StudentCertificatesHubBody({
    required this.eligibility,
    required this.state,
    required this.isBlocked,
    this.onNewRequestTap,
    this.onReexamTap,
    this.onHistoryTap,
    this.onViewDetailsTap,
    super.key,
  });

  final CertificateEligibilityEntity eligibility;
  final StudentCertificatesHubState state;
  final bool isBlocked;
  final VoidCallback? onNewRequestTap;
  final VoidCallback? onReexamTap;
  final VoidCallback? onHistoryTap;
  final VoidCallback? onViewDetailsTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final children = <Widget>[];

    if (eligibility.hasActiveCertificate) {
      children.add(
        _ActiveRequestSummaryCard(
          eligibility: eligibility,
          l10n: l10n,
          onViewDetailsTap: onViewDetailsTap,
        ),
      );
      children.add(const SizedBox(height: AppDesignTokens.spacingMd));
    }

    if (eligibility.newRequest.allowed) {
      children.add(
        _NewRequestCard(
          eligibility: eligibility,
          isBlocked: isBlocked,
          onTap: onNewRequestTap,
          l10n: l10n,
        ),
      );
    } else if (eligibility.reexam.eligible &&
        !state.reexamRegistrationExpired) {
      children.add(
        _ReexamCard(
          eligibility: eligibility,
          remaining: state.reexamRemaining,
          isBlocked: isBlocked,
          onTap: onReexamTap,
          l10n: l10n,
        ),
      );
    } else {
      children.add(
        _StatusOnlyCard(eligibility: eligibility, state: state, l10n: l10n),
      );
    }

    final completed = eligibility.newRequest.completedCategories;
    if (completed.isNotEmpty) {
      children.add(const SizedBox(height: AppDesignTokens.spacingMd));
      children.add(_CompletedCategoriesCard(categories: completed, l10n: l10n));
    }

    children.add(const SizedBox(height: AppDesignTokens.spacingMd));
    children.add(
      _HistoryCtaCard(
        label: l10n.studentCertificatesHistoryCta,
        onTap: onHistoryTap,
      ),
    );

    return ListView(
      padding: AppDesignTokens.screenContentPadding(
        extraBottom: AppDesignTokens.bottomNavHeight,
      ),
      children: children,
    );
  }
}

class _ActiveRequestSummaryCard extends StatelessWidget {
  const _ActiveRequestSummaryCard({
    required this.eligibility,
    required this.l10n,
    this.onViewDetailsTap,
  });

  final CertificateEligibilityEntity eligibility;
  final AppLocalizations l10n;
  final VoidCallback? onViewDetailsTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    final status = eligibility.requestStatus;
    final textTheme = Theme.of(context).textTheme;
    final radius = BorderRadius.circular(AppDesignTokens.radiusLg);

    return AnimatedContainer(
      duration: AppDesignTokens.animationFast,
      padding: const EdgeInsets.all(AppDesignTokens.spacingLg),
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColors.brandMintSoft.withValues(alpha: 0.85),
            AppColors.white,
          ],
        ),
        border: Border.all(
          color: AppColors.brandPrimary.withValues(alpha: 0.12),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandPrimary.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.brandPrimary,
                  borderRadius: BorderRadius.circular(AppDesignTokens.radiusMd),
                ),
                child: const Icon(
                  PhosphorIconsBold.certificate,
                  color: AppColors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: AppDesignTokens.spacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.studentCertificatesActiveRequestTitle,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        height: 1.25,
                        color: colors.ink,
                      ),
                    ),
                    if (eligibility.activeCertificateId != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        l10n.studentCertificatesRequestId(
                          eligibility.activeCertificateId!,
                        ),
                        style: textTheme.bodySmall?.copyWith(
                          color: colors.muted,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (status != null) ...[
            const SizedBox(height: AppDesignTokens.spacing),
            AppStatusBadge(
              label: StudentCertificatesFormatters.requestStatusLabel(
                l10n,
                status,
              ),
              tone: StudentCertificatesFormatters.requestStatusTone(status),
            ),
          ],
          if (eligibility.courseNumber != null) ...[
            const SizedBox(height: AppDesignTokens.spacingMd),
            AppMetaRow(
              icon: PhosphorIconsBold.numberCircleOne,
              label: l10n.studentCertificatesCourseNumber(
                eligibility.courseNumber!,
              ),
            ),
          ],
          if (status != null) ...[
            const SizedBox(height: AppDesignTokens.spacingMd),
            StudentCertificateStatusTimeline(status: status, l10n: l10n),
          ],
          const SizedBox(height: AppDesignTokens.spacingMd),
          SizedBox(
            width: double.infinity,
            height: AppDesignTokens.buttonHeight,
            child: OutlinedButton(
              onPressed: onViewDetailsTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.brandPrimary,
                backgroundColor: AppColors.white.withValues(alpha: 0.92),
                side: BorderSide(
                  color: AppColors.brandPrimary.withValues(alpha: 0.72),
                  width: 1.6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppDesignTokens.radiusMd,
                  ),
                ),
                textStyle: textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              child: Text(l10n.studentCertificatesViewDetailsCta),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompletedCategoriesCard extends StatelessWidget {
  const _CompletedCategoriesCard({
    required this.categories,
    required this.l10n,
  });

  final List<CertificateCategory> categories;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    return AppCard(
      padding: const EdgeInsets.all(AppDesignTokens.spacingLg),
      backgroundColor: colors.successBg,
      borderColor: colors.success.withValues(alpha: 0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCardHeader(
            icon: PhosphorIconsBold.medal,
            title: l10n.studentCertificatesCompletedCategoriesTitle,
          ),
          const SizedBox(height: AppDesignTokens.spacingMd),
          Wrap(
            spacing: AppDesignTokens.spacingSm,
            runSpacing: AppDesignTokens.spacingSm,
            children: [
              for (final category in categories)
                AppStatusBadge(
                  label: category.apiValue,
                  tone: AppBadgeTone.success,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NewRequestCard extends StatelessWidget {
  const _NewRequestCard({
    required this.eligibility,
    required this.isBlocked,
    required this.l10n,
    this.onTap,
  });

  final CertificateEligibilityEntity eligibility;
  final bool isBlocked;
  final AppLocalizations l10n;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    final newRequest = eligibility.newRequest;
    final label = newRequest.isFirstRequest
        ? l10n.studentCertificatesNewRequestFirst
        : l10n.studentCertificatesNewRequestExtra;
    final types = newRequest.availableTransmissionTypes
        .map(
          (type) =>
              StudentCertificatesFormatters.transmissionTypeLabel(l10n, type),
        )
        .join(' · ');

    return AppCard(
      padding: const EdgeInsets.all(AppDesignTokens.spacingLg),
      backgroundColor: colors.infoBg,
      borderColor: colors.info.withValues(alpha: 0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCardHeader(icon: PhosphorIconsBold.plusCircle, title: label),
          if (newRequest.message != null && newRequest.message!.isNotEmpty) ...[
            const SizedBox(height: AppDesignTokens.spacingMd),
            Text(
              newRequest.message!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colors.muted,
                height: 1.45,
              ),
            ),
          ],
          if (types.isNotEmpty) ...[
            const SizedBox(height: AppDesignTokens.spacingMd),
            AppMetaRow(
              icon: PhosphorIconsBold.car,
              label: l10n.studentCertificatesAvailableTypes(types),
            ),
          ],
          const SizedBox(height: AppDesignTokens.spacingMd),
          if (isBlocked)
            Text(
              l10n.studentCertificatesBlockedWriteHint,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: colors.muted),
            )
          else
            AppButton.primary(label: label, onPressed: onTap),
        ],
      ),
    );
  }
}

class _ReexamCard extends StatelessWidget {
  const _ReexamCard({
    required this.eligibility,
    required this.remaining,
    required this.isBlocked,
    required this.l10n,
    this.onTap,
  });

  final CertificateEligibilityEntity eligibility;
  final Duration remaining;
  final bool isBlocked;
  final AppLocalizations l10n;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    final reexam = eligibility.reexam;
    final examType = reexam.examType;
    final title = examType == null
        ? l10n.studentCertificatesReexamTitle
        : l10n.studentCertificatesReexamTitleTyped(
            StudentCertificatesFormatters.examTypeLabel(l10n, examType),
          );

    return AppCard(
      padding: const EdgeInsets.all(AppDesignTokens.spacingLg),
      backgroundColor: colors.warningBg,
      borderColor: colors.warning.withValues(alpha: 0.42),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCardHeader(icon: PhosphorIconsBold.exam, title: title),
          if (reexam.fee != null) ...[
            const SizedBox(height: AppDesignTokens.spacingMd),
            AppMetaRow(
              icon: PhosphorIconsBold.wallet,
              label: l10n.studentCertificatesReexamFee(
                StudentCertificatesFormatters.fee(reexam.fee!),
              ),
            ),
          ],
          if (reexam.examScheduledLabel != null) ...[
            const SizedBox(height: AppDesignTokens.spacingSm),
            AppMetaRow(
              icon: PhosphorIconsBold.calendarBlank,
              label: l10n.studentCertificatesExamScheduled(
                reexam.examScheduledLabel!,
              ),
            ),
          ],
          if (reexam.registrationClosesLabel != null) ...[
            const SizedBox(height: AppDesignTokens.spacingSm),
            AppMetaRow(
              icon: PhosphorIconsBold.clock,
              label: l10n.studentCertificatesRegistrationCloses(
                reexam.registrationClosesLabel!,
              ),
            ),
          ],
          if (remaining > Duration.zero) ...[
            const SizedBox(height: AppDesignTokens.spacingSm),
            Text(
              l10n.studentCertificatesRegistrationCountdown(
                StudentCertificatesFormatters.countdown(remaining),
              ),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.brandPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
          const SizedBox(height: AppDesignTokens.spacingMd),
          if (isBlocked)
            Text(
              l10n.studentCertificatesBlockedWriteHint,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: colors.muted),
            )
          else
            AppButton.primary(
              label: l10n.studentCertificatesReexamCta,
              onPressed: onTap,
            ),
        ],
      ),
    );
  }
}

class _StatusOnlyCard extends StatelessWidget {
  const _StatusOnlyCard({
    required this.eligibility,
    required this.state,
    required this.l10n,
  });

  final CertificateEligibilityEntity eligibility;
  final StudentCertificatesHubState state;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    final newRequest = eligibility.newRequest;
    final reexam = eligibility.reexam;
    final isAllCompleted =
        newRequest.allowed == false &&
        newRequest.reason == 'ALL_CATEGORIES_COMPLETED';
    final message = isAllCompleted && (newRequest.message?.isNotEmpty ?? false)
        ? newRequest.message!
        : (state.reexamRegistrationExpired &&
              (reexam.message?.isNotEmpty ?? false))
        ? reexam.message!
        : (reexam.message?.isNotEmpty ?? false)
        ? reexam.message!
        : (newRequest.message?.isNotEmpty ?? false)
        ? newRequest.message!
        : l10n.studentCertificatesStatusFallback;

    return AppCard(
      padding: const EdgeInsets.all(AppDesignTokens.spacingLg),
      backgroundColor: isAllCompleted ? colors.successBg : colors.card,
      borderColor: isAllCompleted
          ? colors.success.withValues(alpha: 0.4)
          : colors.muted.withValues(alpha: 0.28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCardHeader(
            icon: isAllCompleted
                ? PhosphorIconsBold.sealCheck
                : PhosphorIconsBold.hourglass,
            title: l10n.studentCertificatesStatusTitle,
          ),
          const SizedBox(height: AppDesignTokens.spacingMd),
          if (!isAllCompleted) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  PhosphorIconsBold.clock,
                  size: 16,
                  color: colors.primary,
                ),
                const SizedBox(width: AppDesignTokens.spacingSm),
                Expanded(
                  child: Text(
                    message,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.ink.withValues(alpha: 0.78),
                      height: 1.45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ] else
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colors.success,
                height: 1.45,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }
}

class _HistoryCtaCard extends StatelessWidget {
  const _HistoryCtaCard({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusLg),
        child: AppCard(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDesignTokens.spacingMd,
            vertical: AppDesignTokens.spacing,
          ),
          borderColor: colors.muted.withValues(alpha: 0.28),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: colors.brandSoft,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.brandPrimary.withValues(alpha: 0.22),
                  ),
                ),
                child: const Icon(
                  PhosphorIconsBold.clockCounterClockwise,
                  size: 20,
                  color: AppColors.brandPrimary,
                ),
              ),
              const SizedBox(width: AppDesignTokens.spacing),
              Expanded(
                child: Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.ink,
                  ),
                ),
              ),
              Icon(
                PhosphorIconsBold.caretLeft,
                size: 16,
                color: colors.muted,
                textDirection: TextDirection.ltr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
