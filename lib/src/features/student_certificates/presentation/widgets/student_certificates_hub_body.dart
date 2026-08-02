import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_status_badge.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/certificate_eligibility_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificates_hub_state.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/formatters/student_certificates_formatters.dart';

class StudentCertificatesHubBody extends StatelessWidget {
  const StudentCertificatesHubBody({
    required this.eligibility,
    required this.state,
    required this.isBlocked,
    this.onNewRequestTap,
    this.onReexamTap,
    super.key,
  });

  final CertificateEligibilityEntity eligibility;
  final StudentCertificatesHubState state;
  final bool isBlocked;
  final VoidCallback? onNewRequestTap;
  final VoidCallback? onReexamTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final children = <Widget>[];

    if (eligibility.hasActiveCertificate) {
      children.add(
        _ActiveRequestSummaryCard(eligibility: eligibility, l10n: l10n),
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

    return ListView(
      padding: const EdgeInsets.all(AppDesignTokens.spacingMd),
      children: children,
    );
  }
}

class _ActiveRequestSummaryCard extends StatelessWidget {
  const _ActiveRequestSummaryCard({
    required this.eligibility,
    required this.l10n,
  });

  final CertificateEligibilityEntity eligibility;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final status = eligibility.requestStatus;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.studentCertificatesActiveRequestTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppDesignTokens.spacingSm),
          if (status != null) ...[
            AppStatusBadge(
              label: StudentCertificatesFormatters.requestStatusLabel(
                l10n,
                status,
              ),
            ),
            const SizedBox(height: AppDesignTokens.spacingSm),
          ],
          if (eligibility.courseNumber != null)
            Text(
              l10n.studentCertificatesCourseNumber(eligibility.courseNumber!),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          if (eligibility.activeCertificateId != null)
            Text(
              l10n.studentCertificatesRequestId(
                eligibility.activeCertificateId!,
              ),
              style: Theme.of(context).textTheme.bodySmall,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: Theme.of(context).textTheme.titleMedium),
          if (newRequest.message != null && newRequest.message!.isNotEmpty) ...[
            const SizedBox(height: AppDesignTokens.spacingSm),
            Text(newRequest.message!),
          ],
          if (types.isNotEmpty) ...[
            const SizedBox(height: AppDesignTokens.spacingSm),
            Text(
              l10n.studentCertificatesAvailableTypes(types),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
          const SizedBox(height: AppDesignTokens.spacingMd),
          if (isBlocked)
            Text(
              l10n.studentCertificatesBlockedWriteHint,
              style: Theme.of(context).textTheme.bodySmall,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          if (reexam.fee != null) ...[
            const SizedBox(height: AppDesignTokens.spacingSm),
            Text(
              l10n.studentCertificatesReexamFee(
                StudentCertificatesFormatters.fee(reexam.fee!),
              ),
            ),
          ],
          if (reexam.examScheduledLabel != null) ...[
            const SizedBox(height: AppDesignTokens.spacingSm),
            Text(
              l10n.studentCertificatesExamScheduled(reexam.examScheduledLabel!),
            ),
          ],
          if (reexam.registrationClosesLabel != null) ...[
            const SizedBox(height: AppDesignTokens.spacingSm),
            Text(
              l10n.studentCertificatesRegistrationCloses(
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
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
          const SizedBox(height: AppDesignTokens.spacingMd),
          if (isBlocked)
            Text(
              l10n.studentCertificatesBlockedWriteHint,
              style: Theme.of(context).textTheme.bodySmall,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.studentCertificatesStatusTitle,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppDesignTokens.spacingSm),
          Text(message),
        ],
      ),
    );
  }
}
