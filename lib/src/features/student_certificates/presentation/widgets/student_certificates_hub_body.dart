import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
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
    final status = eligibility.requestStatus;
    return AppCard(
      padding: const EdgeInsets.all(AppDesignTokens.spacingLg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCardHeader(
            icon: PhosphorIconsBold.certificate,
            title: l10n.studentCertificatesActiveRequestTitle,
            badge: status == null
                ? null
                : AppStatusBadge(
                    label: StudentCertificatesFormatters.requestStatusLabel(
                      l10n,
                      status,
                    ),
                  ),
          ),
          const SizedBox(height: AppDesignTokens.spacingMd),
          if (eligibility.courseNumber != null) ...[
            AppMetaRow(
              icon: PhosphorIconsBold.numberCircleOne,
              label: l10n.studentCertificatesCourseNumber(
                eligibility.courseNumber!,
              ),
            ),
            const SizedBox(height: AppDesignTokens.spacingSm),
          ],
          if (eligibility.activeCertificateId != null)
            AppMetaRow(
              icon: PhosphorIconsBold.hash,
              label: l10n.studentCertificatesRequestId(
                eligibility.activeCertificateId!,
              ),
            ),
          if (status != null) ...[
            const SizedBox(height: AppDesignTokens.spacingMd),
            StudentCertificateStatusTimeline(status: status, l10n: l10n),
          ],
          const SizedBox(height: AppDesignTokens.spacingMd),
          AppButton.secondary(
            label: l10n.studentCertificatesViewDetailsCta,
            onPressed: onViewDetailsTap,
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
    return AppCard(
      padding: const EdgeInsets.all(AppDesignTokens.spacingLg),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCardHeader(icon: PhosphorIconsBold.plusCircle, title: label),
          if (newRequest.message != null && newRequest.message!.isNotEmpty) ...[
            const SizedBox(height: AppDesignTokens.spacingMd),
            Text(
              newRequest.message!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.muted,
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
              ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
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
    final reexam = eligibility.reexam;
    final examType = reexam.examType;
    final title = examType == null
        ? l10n.studentCertificatesReexamTitle
        : l10n.studentCertificatesReexamTitleTyped(
            StudentCertificatesFormatters.examTypeLabel(l10n, examType),
          );

    return AppCard(
      padding: const EdgeInsets.all(AppDesignTokens.spacingLg),
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
              ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
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
    final newRequest = eligibility.newRequest;
    final reexam = eligibility.reexam;
    final message =
        (newRequest.allowed == false &&
            newRequest.reason == 'ALL_CATEGORIES_COMPLETED' &&
            (newRequest.message?.isNotEmpty ?? false))
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCardHeader(
            icon: PhosphorIconsBold.info,
            title: l10n.studentCertificatesStatusTitle,
          ),
          const SizedBox(height: AppDesignTokens.spacingMd),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.muted,
              height: 1.45,
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
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: AppColors.brandMintSoft,
                  shape: BoxShape.circle,
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
                    color: AppColors.ink,
                  ),
                ),
              ),
              const Icon(
                PhosphorIconsBold.caretLeft,
                size: 16,
                color: AppColors.muted,
                textDirection: TextDirection.ltr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
