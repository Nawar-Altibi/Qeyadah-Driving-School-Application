import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_alert_banner.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';

/// Shown after a successful cancellation, explaining what happened to the
/// student's deposit based on the freshly-refetched payment status.
class StudentBookingDepositOutcomeBanner extends StatelessWidget {
  const StudentBookingDepositOutcomeBanner({
    super.key,
    required this.outcome,
    this.onRebook,
  });

  final StudentBookingDepositOutcome outcome;
  final VoidCallback? onRebook;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return switch (outcome) {
      StudentBookingDepositOutcome.availableForRebooking => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppAlertBanner(
            tone: AppAlertTone.info,
            icon: PhosphorIconsBold.arrowsClockwise,
            title: l10n.studentBookingDetailDepositRebookTitle,
            message: l10n.studentBookingDetailDepositRebookMessage,
          ),
          const SizedBox(height: AppDesignTokens.spacingSm),
          AppButton.secondary(
            label: l10n.studentBookingDetailDepositRebookCta,
            onPressed: onRebook,
          ),
        ],
      ),
      StudentBookingDepositOutcome.nonRefundable => AppAlertBanner(
        tone: AppAlertTone.danger,
        icon: PhosphorIconsBold.xCircle,
        title: l10n.studentBookingDetailDepositLostTitle,
        message: l10n.studentBookingDetailDepositLostMessage,
      ),
      StudentBookingDepositOutcome.none => const SizedBox.shrink(),
    };
  }
}
