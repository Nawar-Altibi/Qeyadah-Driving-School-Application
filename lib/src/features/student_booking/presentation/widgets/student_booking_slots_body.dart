import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_status_badge.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/entities/student_booking_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/cubit/student_booking_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/formatters/student_booking_formatters.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_gender.dart';

class StudentBookingSlotsBody extends StatelessWidget {
  const StudentBookingSlotsBody({
    super.key,
    required this.page,
    this.interactive = true,
  });

  final StudentAvailableSlotsPageEntity page;
  final bool interactive;

  /// Extra bottom clearance so the last cards clear the sticky continue bar.
  static const double _stickyBarClearance = 120;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();

    final list = page.hasAnySlots
        ? ListView(
            padding: AppDesignTokens.screenContentPadding(
              extraBottom: interactive ? _stickyBarClearance : 0,
            ),
            children: [
              for (final instructorSlots in page.instructors) ...[
                _InstructorSlotsCard(
                  instructorSlots: instructorSlots,
                  localeName: localeName,
                  interactive: interactive,
                ),
                const SizedBox(height: AppDesignTokens.spacingMd),
              ],
            ],
          )
        : _EmptySlotsView(l10n: l10n);

    return Stack(
      children: [
        Positioned.fill(
          child: interactive
              ? RefreshIndicator(
                  onRefresh: () => context
                      .read<StudentBookingCubit>()
                      .loadSlots(silent: true),
                  child: list,
                )
              : list,
        ),
        if (interactive)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: _StickyContinueBar(l10n: l10n),
          ),
      ],
    );
  }
}

class _InstructorSlotsCard extends StatelessWidget {
  const _InstructorSlotsCard({
    required this.instructorSlots,
    required this.localeName,
    required this.interactive,
  });

  final StudentAvailableInstructorSlotsEntity instructorSlots;
  final String localeName;
  final bool interactive;

  @override
  Widget build(BuildContext context) {
    if (instructorSlots.slots.isEmpty) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context);
    final instructor = instructorSlots.instructor;
    final slotsByDate = <DateTime, List<StudentBookingSlotEntity>>{};
    for (final slot in instructorSlots.slots) {
      slotsByDate.putIfAbsent(slot.date, () => []).add(slot);
    }
    final dateEntries = slotsByDate.entries.toList();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                  color: AppColors.brandMintSoft,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  PhosphorIconsBold.user,
                  color: AppColors.brandPrimary,
                  size: 20,
                ),
              ),
              const SizedBox(width: AppDesignTokens.spacingSm),
              Expanded(
                child: Text(
                  instructor.name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              AppStatusBadge(
                label: StudentBookingFormatters.instructorGenderLabel(
                  l10n,
                  instructor.gender,
                ),
                tone: instructor.gender == InstructorGender.female
                    ? AppBadgeTone.info
                    : AppBadgeTone.neutral,
              ),
            ],
          ),
          const SizedBox(height: AppDesignTokens.spacingMd),
          for (var i = 0; i < dateEntries.length; i++) ...[
            if (i > 0) ...[
              Divider(
                height: AppDesignTokens.spacingLg,
                color: AppColors.line.withValues(alpha: 0.55),
              ),
            ],
            _DateGroupHeader(
              label: StudentBookingFormatters.dayLabel(
                dateEntries[i].key,
                localeName,
              ),
            ),
            const SizedBox(height: AppDesignTokens.spacingSm),
            Wrap(
              spacing: AppDesignTokens.spacingSm,
              runSpacing: AppDesignTokens.spacingSm,
              children: [
                for (final slot in dateEntries[i].value)
                  _SlotChip(
                    instructor: instructor,
                    slot: slot,
                    interactive: interactive,
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _DateGroupHeader extends StatelessWidget {
  const _DateGroupHeader({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesignTokens.spacingSm,
        vertical: AppDesignTokens.spacingXs,
      ),
      decoration: BoxDecoration(
        color: AppColors.neutralBg,
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusSm),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: AppColors.muted,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SlotChip extends StatelessWidget {
  const _SlotChip({
    required this.instructor,
    required this.slot,
    required this.interactive,
  });

  final StudentBookingInstructorEntity instructor;
  final StudentBookingSlotEntity slot;
  final bool interactive;

  @override
  Widget build(BuildContext context) {
    final selection = context.select(
      (StudentBookingCubit cubit) => cubit.state.selection,
    );
    final selected =
        selection != null &&
        selection.instructor.id == instructor.id &&
        selection.slot.date == slot.date &&
        selection.slot.startTime == slot.startTime;

    return Material(
      color: selected ? AppColors.brandPrimary : AppColors.neutralBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
        side: BorderSide(
          color: selected ? AppColors.brandPrimary : AppColors.line,
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
        onTap: interactive
            ? () => context.read<StudentBookingCubit>().selectSlot(
                instructor,
                slot,
              )
            : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDesignTokens.spacing,
            vertical: AppDesignTokens.spacingSm,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selected) ...[
                const Icon(
                  PhosphorIconsBold.check,
                  size: 13,
                  color: AppColors.white,
                ),
                const SizedBox(width: 4),
              ],
              Text(
                StudentBookingFormatters.timeRangeLabel(
                  slot.startTime,
                  slot.endTime,
                ),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: selected ? AppColors.white : AppColors.ink,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StickyContinueBar extends StatelessWidget {
  const _StickyContinueBar({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final selection = context.select(
      (StudentBookingCubit cubit) => cubit.state.selection,
    );

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 16,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(
            AppDesignTokens.screenHorizontalPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (selection != null) ...[
                _SelectedSummaryText(
                  l10n: l10n,
                  instructorName: selection.instructor.name,
                  timeLabel: StudentBookingFormatters.timeRangeLabel(
                    selection.slot.startTime,
                    selection.slot.endTime,
                  ),
                ),
                const SizedBox(height: AppDesignTokens.spacingSm),
              ],
              AppButton.primary(
                label: l10n.studentBookingSlotsContinueButton,
                onPressed: selection == null
                    ? null
                    : context.read<StudentBookingCubit>().confirmSlotSelection,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectedSummaryText extends StatelessWidget {
  const _SelectedSummaryText({
    required this.l10n,
    required this.instructorName,
    required this.timeLabel,
  });

  final AppLocalizations l10n;
  final String instructorName;
  final String timeLabel;

  @override
  Widget build(BuildContext context) {
    final mutedStyle = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: AppColors.muted);
    final full = l10n.studentBookingSlotsSelectedLabel(
      instructorName,
      timeLabel,
    );
    final timeIndex = full.lastIndexOf(timeLabel);

    if (timeIndex < 0) {
      return Text(full, style: mutedStyle);
    }

    return Text.rich(
      TextSpan(
        style: mutedStyle,
        children: [
          TextSpan(text: full.substring(0, timeIndex)),
          TextSpan(
            text: timeLabel,
            style: mutedStyle?.copyWith(
              color: AppColors.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (timeIndex + timeLabel.length < full.length)
            TextSpan(text: full.substring(timeIndex + timeLabel.length)),
        ],
      ),
    );
  }
}

class _EmptySlotsView extends StatelessWidget {
  const _EmptySlotsView({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: AppDesignTokens.screenContentPadding(),
      children: [
        const SizedBox(height: AppDesignTokens.spacingXl),
        Container(
          width: 56,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.neutralBg,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(
            PhosphorIconsBold.calendarX,
            color: AppColors.muted,
            size: 26,
          ),
        ),
        const SizedBox(height: AppDesignTokens.spacingMd),
        Text(
          l10n.studentBookingSlotsEmptyTitle,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(
          l10n.studentBookingSlotsEmptyMessage,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
        ),
      ],
    );
  }
}
