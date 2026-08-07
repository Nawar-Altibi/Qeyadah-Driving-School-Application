import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
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

    return Column(
      children: [
        for (var i = 0; i < _flow.length; i++)
          _TimelineStep(
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
    required this.label,
    required this.isPast,
    required this.isCurrent,
    required this.isLast,
  });

  final String label;
  final bool isPast;
  final bool isCurrent;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Color dotColor;
    final Color labelColor;
    if (isPast) {
      dotColor = AppColors.success;
      labelColor = AppColors.muted;
    } else if (isCurrent) {
      dotColor = AppColors.brandPrimary;
      labelColor = AppColors.ink;
    } else {
      dotColor = AppColors.line;
      labelColor = AppColors.muted.withValues(alpha: 0.75);
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 28,
            child: Column(
              children: [
                Container(
                  width: isCurrent ? 18 : 14,
                  height: isCurrent ? 18 : 14,
                  decoration: BoxDecoration(
                    color: isPast || isCurrent ? dotColor : AppColors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: dotColor,
                      width: isCurrent ? 3 : 2,
                    ),
                    boxShadow: isCurrent
                        ? [
                            BoxShadow(
                              color: AppColors.brandPrimary.withValues(
                                alpha: 0.22,
                              ),
                              blurRadius: 10,
                              spreadRadius: 1,
                            ),
                          ]
                        : null,
                  ),
                  child: isPast
                      ? const Icon(
                          PhosphorIconsBold.check,
                          size: 9,
                          color: AppColors.white,
                        )
                      : null,
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      color: isPast ? AppColors.success : AppColors.line,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppDesignTokens.spacingSm),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: isLast ? 0 : AppDesignTokens.spacing,
                top: 1,
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
      ),
    );
  }
}
