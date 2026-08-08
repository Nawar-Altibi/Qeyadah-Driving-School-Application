import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/certificate_request_status.dart';

/// Vertical status journey for an active certificate request.
///
/// Hidden for [CertificateRequestStatus.failed] / [cancelled] (not a linear
/// success path). Built only from [requestStatus] — no extra API calls.
class StudentCertificateStatusTimeline extends StatelessWidget {
  const StudentCertificateStatusTimeline({
    super.key,
    required this.status,
    required this.l10n,
  });

  final CertificateRequestStatus status;
  final AppLocalizations l10n;

  static const _flow = <CertificateRequestStatus>[
    CertificateRequestStatus.waitingForTrainingSchedule,
    CertificateRequestStatus.inGovernmentTraining,
    CertificateRequestStatus.waitingForTheoreticalExam,
    CertificateRequestStatus.waitingForPracticalExam,
    CertificateRequestStatus.completed,
  ];

  static const _icons = <IconData>[
    PhosphorIconsBold.paperPlaneTilt,
    PhosphorIconsBold.buildings,
    PhosphorIconsBold.bookOpenText,
    PhosphorIconsBold.steeringWheel,
    PhosphorIconsBold.sealCheck,
  ];

  @override
  Widget build(BuildContext context) {
    if (status == CertificateRequestStatus.failed ||
        status == CertificateRequestStatus.cancelled) {
      return const SizedBox.shrink();
    }

    final currentIndex = _flow.indexOf(status);
    if (currentIndex < 0) return const SizedBox.shrink();

    final labels = <String>[
      l10n.studentCertificatesTimelineSubmitted,
      l10n.studentCertificatesTimelineGovTraining,
      l10n.studentCertificatesTimelineTheoryExam,
      l10n.studentCertificatesTimelinePracticalExam,
      l10n.studentCertificatesTimelineLicense,
    ];

    final colors = AppSemanticColors.of(context);
    final progress = (currentIndex + 1) / _flow.length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 6,
            backgroundColor: colors.line.withValues(alpha: 0.55),
            color: AppColors.brandPrimary,
          ),
        ),
        const SizedBox(height: AppDesignTokens.spacingMd),
        for (var i = 0; i < _flow.length; i++)
          _TimelineStep(
            icon: _icons[i],
            label: labels[i],
            isPast: i < currentIndex,
            isCurrent: i == currentIndex,
            isLast: i == _flow.length - 1,
          ),
      ],
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({
    required this.icon,
    required this.label,
    required this.isPast,
    required this.isCurrent,
    required this.isLast,
  });

  final IconData icon;
  final String label;
  final bool isPast;
  final bool isCurrent;
  final bool isLast;

  static const double _circleSize = 28;
  static const double _connectorHeight = 10;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final Color connectorColor;
    final Color labelColor;
    if (isPast) {
      connectorColor = colors.success;
      labelColor = colors.muted;
    } else if (isCurrent) {
      connectorColor = AppColors.brandPrimary.withValues(alpha: 0.35);
      labelColor = colors.ink;
    } else {
      connectorColor = colors.muted.withValues(alpha: 0.4);
      labelColor = colors.ink.withValues(alpha: 0.62);
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 36,
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: isCurrent ? 30 : _circleSize,
                height: isCurrent ? 30 : _circleSize,
                decoration: BoxDecoration(
                  color: isPast
                      ? colors.success
                      : isCurrent
                      ? AppColors.brandPrimary
                      : colors.card,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isCurrent
                        ? AppColors.brandPrimary
                        : isPast
                        ? colors.success
                        : colors.muted.withValues(alpha: 0.55),
                    width: isCurrent ? 2 : 1.5,
                  ),
                ),
                child: Icon(
                  isPast ? PhosphorIconsBold.check : icon,
                  size: isCurrent ? 14 : 13,
                  color: isPast || isCurrent
                      ? AppColors.white
                      : colors.ink.withValues(alpha: 0.55),
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: _connectorHeight,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  decoration: BoxDecoration(
                    color: connectorColor,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(width: AppDesignTokens.spacingSm),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              top: 5,
              bottom: isLast ? 0 : AppDesignTokens.spacingSm,
            ),
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(
                color: labelColor,
                fontWeight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                height: 1.35,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
