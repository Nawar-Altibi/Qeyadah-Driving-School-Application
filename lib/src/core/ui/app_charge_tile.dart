import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_status_badge.dart';

class AppChargePaymentLine {
  const AppChargePaymentLine({required this.method, required this.amount});

  final String method;
  final String amount;
}

/// Presentational charge summary used by booking and certificate detail screens.
class AppChargeTile extends StatelessWidget {
  const AppChargeTile({
    super.key,
    required this.title,
    required this.statusLabel,
    required this.statusTone,
    required this.amountLabel,
    this.payments,
    this.useCardShell = false,
  });

  final String title;
  final String statusLabel;
  final AppBadgeTone statusTone;
  final String amountLabel;
  final List<AppChargePaymentLine>? payments;
  final bool useCardShell;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 14.5,
                ),
              ),
            ),
            AppStatusBadge(label: statusLabel, tone: statusTone),
          ],
        ),
        const SizedBox(height: AppDesignTokens.spacingXs),
        Text(
          amountLabel,
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.muted,
            fontSize: 13,
            height: 1.35,
          ),
        ),
        if (payments != null && payments!.isNotEmpty) ...[
          const SizedBox(height: AppDesignTokens.spacingSm),
          const Divider(height: 1),
          const SizedBox(height: AppDesignTokens.spacingSm),
          for (final payment in payments!) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    payment.method,
                    style: textTheme.bodySmall?.copyWith(
                      color: AppColors.muted,
                    ),
                  ),
                ),
                Text(
                  payment.amount,
                  style: textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.ink,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
          ],
        ],
      ],
    );

    if (useCardShell) {
      return AppCard(child: content);
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.brandMintSoft.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
      ),
      child: Padding(padding: const EdgeInsets.all(12), child: content),
    );
  }
}
