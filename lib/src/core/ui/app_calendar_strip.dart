import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

class AppCalendarStrip extends StatelessWidget {
  const AppCalendarStrip({
    super.key,
    required this.days,
    required this.selectedDate,
    required this.weekdayLabelBuilder,
    required this.dayNumberBuilder,
    required this.onDaySelected,
    this.hasEventsForDay,
  });

  final List<DateTime> days;
  final DateTime selectedDate;
  final String Function(DateTime date) weekdayLabelBuilder;
  final String Function(DateTime date) dayNumberBuilder;
  final ValueChanged<DateTime> onDaySelected;
  final bool Function(DateTime date)? hasEventsForDay;

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final day in days) ...[
          Expanded(
            child: _CalendarDayButton(
              weekday: weekdayLabelBuilder(day),
              dayNumber: dayNumberBuilder(day),
              isSelected: _isSameDay(day, selectedDate),
              hasEvent: hasEventsForDay?.call(day) ?? false,
              onTap: () => onDaySelected(day),
            ),
          ),
          if (day != days.last) const SizedBox(width: 6),
        ],
      ],
    );
  }
}

class _CalendarDayButton extends StatelessWidget {
  const _CalendarDayButton({
    required this.weekday,
    required this.dayNumber,
    required this.isSelected,
    required this.hasEvent,
    required this.onTap,
  });

  final String weekday;
  final String dayNumber;
  final bool isSelected;
  final bool hasEvent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? AppColors.brandPrimary : AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: isSelected ? AppColors.brandPrimary : AppColors.line,
        ),
      ),
      elevation: isSelected ? 4 : 0,
      shadowColor: AppColors.brandPrimary.withValues(alpha: 0.18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          height: 62,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weekday,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: isSelected ? AppColors.brandMint : AppColors.muted,
                      fontSize: 10,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    dayNumber,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: isSelected ? AppColors.white : AppColors.ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              if (hasEvent && !isSelected)
                Positioned(
                  bottom: 7,
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: AppColors.brandMint,
                      shape: BoxShape.circle,
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

class AppFloatingActionChip extends StatelessWidget {
  const AppFloatingActionChip({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon = Icons.add_rounded,
  });

  final String label;
  final VoidCallback onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.brandPrimary,
      borderRadius: BorderRadius.circular(16),
      elevation: 8,
      shadowColor: AppColors.brandPrimary.withValues(alpha: 0.3),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(7, 7, 18, 7),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(icon, color: AppColors.white, size: 22),
              ),
              const SizedBox(width: 9),
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InstructorAvatar extends StatelessWidget {
  const InstructorAvatar({
    super.key,
    required this.initials,
    this.size = 42,
    this.tone = InstructorAvatarTone.mint,
  });

  final String initials;
  final double size;
  final InstructorAvatarTone tone;

  @override
  Widget build(BuildContext context) {
    final (:background, :foreground) = switch (tone) {
      InstructorAvatarTone.mint => (
        background: AppColors.brandMint,
        foreground: AppColors.brandPrimary,
      ),
      InstructorAvatarTone.sage => (
        background: const Color(0xFFD9E8DF),
        foreground: AppColors.brandPrimary,
      ),
      InstructorAvatarTone.light => (
        background: AppColors.white.withValues(alpha: 0.13),
        foreground: AppColors.white,
      ),
    };

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(size * 0.33),
        border: tone == InstructorAvatarTone.light
            ? Border.all(color: AppColors.white.withValues(alpha: 0.18))
            : null,
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: TextStyle(
          color: foreground,
          fontWeight: FontWeight.w800,
          fontSize: size * 0.28,
        ),
      ),
    );
  }
}

enum InstructorAvatarTone { mint, sage, light }

class InstructorBookedRing extends StatelessWidget {
  const InstructorBookedRing({
    super.key,
    required this.percent,
    required this.label,
  });

  final int percent;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 66,
      height: 66,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: percent / 100,
            strokeWidth: 5,
            backgroundColor: AppColors.white.withValues(alpha: 0.18),
            color: const Color(0xFFCCE9DA),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$percent%',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: AppColors.white.withValues(alpha: 0.8),
                  fontSize: 9,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class InstructorSettingsRow extends StatelessWidget {
  const InstructorSettingsRow({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
    this.danger = false,
    this.showChevron = true,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;
  final bool danger;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    final color = danger ? AppColors.danger : AppColors.ink;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDesignTokens.spacingMd,
          vertical: 14,
        ),
        child: Row(
          children: [
            Icon(icon, size: 19, color: danger ? AppColors.danger : AppColors.brandPrimary),
            const SizedBox(width: AppDesignTokens.spacing),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (showChevron)
              Icon(
                Icons.chevron_left_rounded,
                color: danger ? AppColors.danger : AppColors.muted,
              ),
          ],
        ),
      ),
    );
  }
}
