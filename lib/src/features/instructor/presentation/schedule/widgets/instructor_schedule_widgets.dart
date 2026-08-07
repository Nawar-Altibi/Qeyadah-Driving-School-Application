import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_calendar_strip.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_status_badge.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/shared/formatters/instructor_formatters.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_booking_status.dart';

class InstructorScheduleGreetingHeader extends StatelessWidget {
  const InstructorScheduleGreetingHeader({
    super.key,
    required this.name,
    required this.onNotificationsTap,
    this.unreadCount = 0,
  });

  final String name;
  final VoidCallback? onNotificationsTap;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = AppSemanticColors.of(context);
    return Row(
      children: [
        InstructorAvatar(
          initials: InstructorFormatters.initials(name),
          tone: InstructorAvatarTone.sage,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.instructorWelcomeBackEyebrow,
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: colors.muted),
              ),
              Text(
                InstructorFormatters.welcomeBack(l10n, name),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
        _NotificationBellButton(
          onTap: onNotificationsTap,
          unreadCount: unreadCount,
        ),
      ],
    );
  }
}

class _NotificationBellButton extends StatelessWidget {
  const _NotificationBellButton({this.onTap, this.unreadCount = 0});

  final VoidCallback? onTap;
  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    return Material(
      color: colors.card.withValues(alpha: 0.75),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
        side: BorderSide(color: colors.line),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(13),
        child: SizedBox(
          width: 38,
          height: 38,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Icon(PhosphorIconsBold.bell, size: 21, color: colors.ink),
              if (unreadCount > 0)
                Positioned(
                  top: 4,
                  left: 4,
                  child: Container(
                    constraints: const BoxConstraints(minWidth: 14),
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    height: 14,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: colors.danger,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      unreadCount > 99 ? '99+' : '$unreadCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class InstructorScheduleSummaryCard extends StatelessWidget {
  const InstructorScheduleSummaryCard({
    super.key,
    required this.dashboard,
    required this.localeName,
  });

  final InstructorScheduleDashboardEntity dashboard;
  final String localeName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppGradients.primaryButton,
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.brandPrimary.withValues(alpha: 0.18),
            blurRadius: 25,
            offset: const Offset(0, 13),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.instructorTodaySchedule,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: const Color(0xFFBFE1D0),
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                    ),
                  ),
                  Text(
                    l10n.instructorSessionsCount(dashboard.sessionCount),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    InstructorFormatters.trainingHoursLabel(
                      l10n,
                      dashboard.trainingHours,
                    ),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.white.withValues(alpha: 0.66),
                    ),
                  ),
                ],
              ),
            ),
            InstructorBookedRing(
              percent: dashboard.bookedPercent,
              label: l10n.instructorBookedLabel,
            ),
          ],
        ),
      ),
    );
  }
}

class InstructorTimelineSection extends StatefulWidget {
  const InstructorTimelineSection({
    super.key,
    required this.bookings,
    required this.localeName,
  });

  final List<InstructorBookingEntity> bookings;
  final String localeName;

  @override
  State<InstructorTimelineSection> createState() =>
      _InstructorTimelineSectionState();
}

class _InstructorTimelineSectionState extends State<InstructorTimelineSection> {
  List<InstructorBookingEntity>? _cachedBookings;
  List<InstructorBookingEntity> _sorted = const [];

  @override
  void didUpdateWidget(covariant InstructorTimelineSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!identical(oldWidget.bookings, widget.bookings)) {
      _cachedBookings = null;
    }
  }

  List<InstructorBookingEntity> _sortedFor(
    List<InstructorBookingEntity> bookings,
  ) {
    if (identical(_cachedBookings, bookings)) return _sorted;
    _cachedBookings = bookings;
    _sorted = [...bookings]
      ..sort((a, b) => a.startDateTime.compareTo(b.startDateTime));
    return _sorted;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = AppSemanticColors.of(context);
    final sorted = _sortedFor(widget.bookings);

    if (sorted.isEmpty) {
      return AppCard(
        child: Text(
          l10n.instructorNoSessionsToday,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: colors.muted),
        ),
      );
    }

    return Column(
      children: [
        for (var index = 0; index < sorted.length; index++)
          _TimelineRow(
            booking: sorted[index],
            localeName: widget.localeName,
            showConnector: index < sorted.length - 1,
          ),
      ],
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({
    required this.booking,
    required this.localeName,
    required this.showConnector,
  });

  final InstructorBookingEntity booking;
  final String localeName;
  final bool showConnector;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = AppSemanticColors.of(context);
    final durationMinutes = booking.duration.inMinutes;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 38,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  InstructorFormatters.timeLabel(booking.startTime),
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '$durationMinutes ${l10n.instructorMinuteUnit}',
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: colors.muted,
                    fontSize: 9,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 17,
            child: Column(
              children: [
                Container(
                  width: 9,
                  height: 9,
                  margin: const EdgeInsets.only(top: 3),
                  decoration: BoxDecoration(
                    color: AppColors.brandPrimary,
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.canvas, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.brandPrimary.withValues(alpha: 0.2),
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
                if (showConnector)
                  Expanded(child: Container(width: 1, color: colors.line)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: AppCard(
                padding: const EdgeInsets.all(12),
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: AppColors.brandPrimary,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                booking.student.name,
                                style: Theme.of(context).textTheme.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w700),
                              ),
                            ),
                            AppStatusBadge(
                              label: InstructorFormatters.bookingStatusLabel(
                                l10n,
                                booking.bookingStatus,
                              ),
                              tone:
                                  booking.bookingStatus ==
                                      InstructorBookingStatus.booked
                                  ? AppBadgeTone.success
                                  : AppBadgeTone.neutral,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          InstructorFormatters.trainingTypeLabel(
                            l10n,
                            booking.trainingType,
                          ),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${InstructorFormatters.vehicleSourceLabel(l10n, booking.vehicleSource)} · ${InstructorFormatters.durationLabel(l10n, booking.duration)}',
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall?.copyWith(color: colors.muted),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
