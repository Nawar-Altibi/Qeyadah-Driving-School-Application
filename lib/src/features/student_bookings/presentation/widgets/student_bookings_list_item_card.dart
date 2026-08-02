import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_status_badge.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/formatters/student_bookings_formatters.dart';

class StudentBookingsListItemCard extends StatelessWidget {
  const StudentBookingsListItemCard({
    super.key,
    required this.item,
    this.onTap,
  });

  final StudentBookingListItemEntity item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final textTheme = Theme.of(context).textTheme;

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(AppDesignTokens.spacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  item.date != null
                      ? StudentBookingsFormatters.dayLabel(
                          item.date!,
                          localeName,
                        )
                      : item.dayName,
                  style: textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              AppStatusBadge(
                label: StudentBookingsFormatters.bookingStatusLabel(
                  l10n,
                  item.bookingStatus,
                ),
                tone: StudentBookingsFormatters.bookingStatusTone(
                  item.bookingStatus,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDesignTokens.spacingSm),
          _MetaRow(
            icon: PhosphorIconsBold.clock,
            label: StudentBookingsFormatters.timeRangeLabel(
              item.startTime,
              item.endTime,
            ),
          ),
          const SizedBox(height: 6),
          _MetaRow(icon: PhosphorIconsBold.user, label: item.instructorName),
          if (item.trainingType != null || item.vehicleSource != null) ...[
            const SizedBox(height: 6),
            _MetaRow(
              icon: PhosphorIconsBold.car,
              label: [
                if (item.trainingType != null)
                  StudentBookingsFormatters.trainingTypeLabel(
                    l10n,
                    item.trainingType!,
                  ),
                if (item.vehicleSource != null)
                  StudentBookingsFormatters.vehicleSourceLabel(
                    l10n,
                    item.vehicleSource!,
                  ),
                if (item.vehiclePlate != null && item.vehiclePlate!.isNotEmpty)
                  item.vehiclePlate!,
              ].join(' · '),
            ),
          ],
          const SizedBox(height: AppDesignTokens.spacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppStatusBadge(
                label: StudentBookingsFormatters.paymentStatusLabel(
                  l10n,
                  item.paymentStatus,
                ),
                tone: StudentBookingsFormatters.paymentStatusTone(
                  item.paymentStatus,
                ),
              ),
              if (item.remainingAmount != null)
                Text(
                  l10n.studentBookingsRemainingAtSchool(
                    StudentBookingsFormatters.currency(
                      l10n,
                      item.remainingAmount!,
                    ),
                  ),
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.muted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.muted),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
          ),
        ),
      ],
    );
  }
}
