import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_status_badge.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/formatters/instructor_formatters.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_booking_status.dart';

class InstructorScheduleTimeline extends StatelessWidget {
  const InstructorScheduleTimeline({
    super.key,
    required this.bookings,
    required this.localeName,
  });

  final List<InstructorBookingEntity> bookings;
  final String localeName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = _buildItems();

    if (items.isEmpty) {
      return AppCard(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDesignTokens.spacingMd,
          vertical: AppDesignTokens.spacingLg,
        ),
        child: Row(
          children: [
            const Icon(
              PhosphorIconsBold.calendarBlank,
              color: AppColors.muted,
              size: 22,
            ),
            const SizedBox(width: AppDesignTokens.spacing),
            Expanded(
              child: Text(
                l10n.instructorNoSessionsToday,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        for (var index = 0; index < items.length; index++)
          _TimelineRow(
            item: items[index],
            localeName: localeName,
            showConnector: index < items.length - 1,
          ),
      ],
    );
  }

  List<_TimelineItem> _buildItems() {
    return <_TimelineItem>[...bookings.map(_LessonTimelineItem.new)]
      ..sort((a, b) => a.startMinute.compareTo(b.startMinute));
  }
}

sealed class _TimelineItem {
  const _TimelineItem();

  int get startMinute;
  int get durationMinutes;
}

class _LessonTimelineItem extends _TimelineItem {
  const _LessonTimelineItem(this.booking);

  final InstructorBookingEntity booking;

  @override
  int get startMinute => _timeToMinutes(booking.startTime);

  @override
  int get durationMinutes => booking.duration.inMinutes;
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.item,
    required this.localeName,
    required this.showConnector,
  });

  final _TimelineItem item;
  final String localeName;
  final bool showConnector;

  @override
  Widget build(BuildContext context) {
    const accent = AppColors.brandPrimary;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 48,
            child: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _formatMinutes(item.startMinute),
                    textDirection: TextDirection.ltr,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.ink,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${item.durationMinutes} ${AppLocalizations.of(context).instructorMinuteUnit}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.muted,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 24,
            child: Column(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: BoxDecoration(
                    color: accent,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: accent.withValues(alpha: 0.24),
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
                if (showConnector)
                  Expanded(
                    child: Container(
                      width: 1.5,
                      margin: const EdgeInsets.symmetric(vertical: 3),
                      color: AppColors.brandMint,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: AppDesignTokens.spacing),
              child: InstructorLessonCard(
                booking: (item as _LessonTimelineItem).booking,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InstructorLessonCard extends StatelessWidget {
  const InstructorLessonCard({super.key, required this.booking});

  final InstructorBookingEntity booking;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      borderColor: AppColors.brandMint,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusLg - 1),
        child: DecoratedBox(
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(color: AppColors.brandPrimary, width: 4),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 12, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        booking.student.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: AppColors.ink,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDesignTokens.spacingSm),
                    AppStatusBadge(
                      label: InstructorFormatters.bookingStatusLabel(
                        l10n,
                        booking.bookingStatus,
                      ),
                      tone: _statusTone(booking.bookingStatus),
                    ),
                  ],
                ),
                const SizedBox(height: AppDesignTokens.spacing),
                Row(
                  children: [
                    const Icon(
                      PhosphorIconsBold.steeringWheel,
                      size: 16,
                      color: AppColors.brandPrimary,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        InstructorFormatters.trainingTypeLabel(
                          l10n,
                          booking.trainingType,
                        ),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      PhosphorIconsBold.car,
                      size: 15,
                      color: AppColors.muted,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        '${InstructorFormatters.vehicleSourceLabel(l10n, booking.vehicleSource)} · ${InstructorFormatters.durationLabel(l10n, booking.duration)}',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.muted,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

AppBadgeTone _statusTone(InstructorBookingStatus status) {
  return switch (status) {
    InstructorBookingStatus.booked => AppBadgeTone.success,
    InstructorBookingStatus.pendingPayment => AppBadgeTone.warning,
    InstructorBookingStatus.cancelled => AppBadgeTone.danger,
    InstructorBookingStatus.noShow => AppBadgeTone.danger,
    InstructorBookingStatus.completed => AppBadgeTone.info,
    InstructorBookingStatus.expired => AppBadgeTone.neutral,
  };
}

int _timeToMinutes(String value) {
  final parts = value.split(':');
  return (int.tryParse(parts.first) ?? 0) * 60 +
      (parts.length > 1 ? int.tryParse(parts[1]) ?? 0 : 0);
}

String _formatMinutes(int value) {
  final hour = (value ~/ 60).toString().padLeft(2, '0');
  final minute = (value % 60).toString().padLeft(2, '0');
  return '$hour:$minute';
}
