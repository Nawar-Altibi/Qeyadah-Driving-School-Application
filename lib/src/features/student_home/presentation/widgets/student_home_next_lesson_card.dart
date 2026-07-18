import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_status_badge.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/entities/student_home_dashboard_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/formatters/student_home_formatters.dart';

class StudentHomeNextLessonCard extends StatelessWidget {
  const StudentHomeNextLessonCard({
    super.key,
    required this.lesson,
    required this.localeName,
    this.onDirectionsTap,
  });

  final StudentHomeNextLessonEntity lesson;
  final String localeName;
  final VoidCallback? onDirectionsTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final transmissionLabel = lesson.isAutomatic
        ? l10n.studentHomeAutomatic
        : l10n.studentHomeManual;
    final vehicleSourceLabel = lesson.isSchoolVehicle
        ? l10n.studentHomeSchoolVehicle
        : l10n.studentHomeStudentVehicle;
    final instructorRoleLabel = lesson.instructorIsFemale
        ? l10n.studentHomeInstructorFemale
        : l10n.studentHomeInstructorMale;

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: AppGradients.heroEmerald,
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusLg),
        boxShadow: const [
          BoxShadow(
            color: Color(0x330F5132),
            blurRadius: 28,
            offset: Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: -73,
            right: -62,
            child: Container(
              width: 155,
              height: 155,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withValues(alpha: 0.03),
                    spreadRadius: 28,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          PhosphorIconsBold.calendarCheck,
                          size: 14,
                          color: Color(0xFFC4E3D2),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          l10n.studentHomeNextLesson,
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: const Color(0xFFC4E3D2),
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    AppStatusBadge(
                      label: l10n.studentHomeConfirmed,
                      tone: AppBadgeTone.success,
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 57,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.13),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.12),
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${lesson.startsAt.day}',
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w800,
                                  height: 1,
                                ),
                          ),
                          Text(
                            StudentHomeFormatters.monthLabel(
                              lesson.startsAt,
                              localeName,
                            ),
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: const Color(0xFFBFE2D0),
                                  fontSize: 8,
                                  letterSpacing: 0.8,
                                ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            StudentHomeFormatters.weekdayLabel(
                              lesson.startsAt,
                              localeName,
                            ),
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(
                                PhosphorIconsBold.clock,
                                size: 15,
                                color: Colors.white.withValues(alpha: 0.85),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                StudentHomeFormatters.timeRange(
                                  startsAt: lesson.startsAt,
                                  endsAt: lesson.endsAt,
                                  localeName: localeName,
                                ),
                                style: Theme.of(context).textTheme.labelMedium
                                    ?.copyWith(
                                      color: Colors.white.withValues(
                                        alpha: 0.72,
                                      ),
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  color: Colors.white.withValues(alpha: 0.13),
                ),
                Row(
                  children: [
                    _LessonMetaItem(
                      icon: PhosphorIconsBold.user,
                      label: instructorRoleLabel,
                      value: lesson.instructorName,
                    ),
                    const SizedBox(width: 27),
                    _LessonMetaItem(
                      icon: PhosphorIconsBold.car,
                      label: l10n.studentHomeVehicle,
                      value: '$transmissionLabel · $vehicleSourceLabel',
                    ),
                  ],
                ),
                if (lesson.meetingPointLabel != null) ...[
                  const SizedBox(height: 14),
                  TextButton.icon(
                    onPressed: onDirectionsTap,
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFFC9E6D7),
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: const Icon(
                      PhosphorIconsBold.mapPin,
                      size: 15,
                      color: Color(0xFFC9E6D7),
                    ),
                    label: Text(
                      l10n.studentHomeShowMeetingPoint,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: const Color(0xFFC9E6D7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LessonMetaItem extends StatelessWidget {
  const _LessonMetaItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.white.withValues(alpha: 0.9)),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Colors.white.withValues(alpha: 0.58),
                    fontSize: 8,
                  ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
