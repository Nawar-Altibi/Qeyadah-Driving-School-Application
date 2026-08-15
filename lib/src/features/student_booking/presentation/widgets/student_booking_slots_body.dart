import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
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
  static const double _stickyBarClearance = 148;

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
              _PricingCard(pricing: page.pricing),
              const SizedBox(height: AppDesignTokens.spacingMd),
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
        : _EmptySlotsView(l10n: l10n, pricing: page.pricing);

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

class _InstructorSlotsCard extends StatefulWidget {
  const _InstructorSlotsCard({
    required this.instructorSlots,
    required this.localeName,
    required this.interactive,
  });

  final StudentAvailableInstructorSlotsEntity instructorSlots;
  final String localeName;
  final bool interactive;

  @override
  State<_InstructorSlotsCard> createState() => _InstructorSlotsCardState();
}

class _InstructorSlotsCardState extends State<_InstructorSlotsCard> {
  List<StudentBookingSlotEntity>? _cachedSlots;
  Map<DateTime, List<StudentBookingSlotEntity>> _slotsByDate = const {};

  Map<DateTime, List<StudentBookingSlotEntity>> _groupSlots(
    List<StudentBookingSlotEntity> slots,
  ) {
    if (identical(_cachedSlots, slots)) return _slotsByDate;
    _cachedSlots = slots;
    final slotsByDate = <DateTime, List<StudentBookingSlotEntity>>{};
    for (final slot in slots) {
      slotsByDate.putIfAbsent(slot.date, () => []).add(slot);
    }
    _slotsByDate = slotsByDate;
    return _slotsByDate;
  }

  @override
  Widget build(BuildContext context) {
    final slots = widget.instructorSlots.slots;
    if (slots.isEmpty) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context);
    final colors = AppSemanticColors.of(context);
    final instructor = widget.instructorSlots.instructor;
    final dateEntries = _groupSlots(slots).entries.toList();

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [colors.brandSoft, AppColors.brandMint],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  PhosphorIconsBold.user,
                  color: AppColors.brandPrimary,
                  size: 22,
                ),
              ),
              const SizedBox(width: AppDesignTokens.spacing),
              Expanded(
                child: Text(
                  instructor.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
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
          const SizedBox(height: AppDesignTokens.spacingLg),
          for (var i = 0; i < dateEntries.length; i++) ...[
            if (i > 0) const SizedBox(height: AppDesignTokens.spacingMd),
            _DateGroupHeader(
              label: StudentBookingFormatters.dayLabel(
                dateEntries[i].key,
                widget.localeName,
              ),
            ),
            const SizedBox(height: AppDesignTokens.spacing),
            Wrap(
              spacing: AppDesignTokens.spacingSm,
              runSpacing: AppDesignTokens.spacingSm,
              children: [
                for (final slot in dateEntries[i].value)
                  _SlotChip(
                    instructor: instructor,
                    slot: slot,
                    interactive: widget.interactive,
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
    final colors = AppSemanticColors.of(context);
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: colors.brandSoft,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(
            PhosphorIconsBold.calendarBlank,
            size: 14,
            color: AppColors.brandPrimary,
            textDirection: TextDirection.ltr,
          ),
        ),
        const SizedBox(width: AppDesignTokens.spacingSm),
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: colors.ink,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
      ],
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
    final colors = AppSemanticColors.of(context);
    final selected = context.select((StudentBookingCubit cubit) {
      final selection = cubit.state.selection;
      return selection != null &&
          selection.instructor.id == instructor.id &&
          selection.slot.date == slot.date &&
          selection.slot.startTime == slot.startTime;
    });

    return AnimatedContainer(
      duration: AppDesignTokens.animationNormal,
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: selected ? AppColors.brandPrimary : colors.card,
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
        border: Border.all(
          color: selected
              ? AppColors.brandPrimary
              : colors.line.withValues(alpha: 0.9),
          width: selected ? 1.5 : 1,
        ),
        boxShadow: selected
            ? const [
                BoxShadow(
                  color: Color(0x33153023),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ]
            : const [
                BoxShadow(
                  color: Color(0x0A153023),
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
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
              horizontal: AppDesignTokens.spacingMd,
              vertical: 11,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedSwitcher(
                  duration: AppDesignTokens.animationFast,
                  child: selected
                      ? const Padding(
                          key: ValueKey('check'),
                          padding: EdgeInsetsDirectional.only(end: 6),
                          child: Icon(
                            PhosphorIconsBold.checkCircle,
                            size: 15,
                            color: AppColors.white,
                          ),
                        )
                      : const SizedBox.shrink(key: ValueKey('empty')),
                ),
                Text(
                  StudentBookingFormatters.timeRangeLabel(
                    slot.startTime,
                    slot.endTime,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: selected ? AppColors.white : colors.ink,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.5,
                  ),
                ),
              ],
            ),
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
    final colors = AppSemanticColors.of(context);
    final selection = context.select(
      (StudentBookingCubit cubit) => cubit.state.selection,
    );

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.card,
        boxShadow: const [
          BoxShadow(
            color: Color(0x14153023),
            blurRadius: 20,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppDesignTokens.screenHorizontalPadding,
            AppDesignTokens.spacingMd,
            AppDesignTokens.screenHorizontalPadding,
            AppDesignTokens.spacingMd,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedSize(
                duration: AppDesignTokens.animationNormal,
                curve: Curves.easeOutCubic,
                alignment: Alignment.topCenter,
                child: selection == null
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppDesignTokens.spacingMd,
                        ),
                        child: _SelectedSummaryCard(
                          l10n: l10n,
                          instructorName: selection.instructor.name,
                          timeLabel: StudentBookingFormatters.timeRangeLabel(
                            selection.slot.startTime,
                            selection.slot.endTime,
                          ),
                        ),
                      ),
              ),
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

class _SelectedSummaryCard extends StatelessWidget {
  const _SelectedSummaryCard({
    required this.l10n,
    required this.instructorName,
    required this.timeLabel,
  });

  final AppLocalizations l10n;
  final String instructorName;
  final String timeLabel;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.brandSoft,
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDesignTokens.spacingMd,
          vertical: AppDesignTokens.spacing,
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: colors.card,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                PhosphorIconsBold.checkCircle,
                color: AppColors.brandPrimary,
                size: 20,
              ),
            ),
            const SizedBox(width: AppDesignTokens.spacing),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.studentBookingSlotsSelectedHeading,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.brandPrimary,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    instructorName,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        PhosphorIconsBold.clock,
                        size: 14,
                        color: colors.muted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        timeLabel,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colors.ink,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PricingCard extends StatelessWidget {
  const _PricingCard({required this.pricing});

  final StudentBookingPricingEntity pricing;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final lessonPrice = StudentBookingFormatters.currency(
      l10n,
      pricing.lessonPrice,
    );
    final depositAmount = StudentBookingFormatters.currency(
      l10n,
      pricing.depositAmount,
    );

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.studentBookingSlotsPricingTitle,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppDesignTokens.spacingSm),
          Text(l10n.studentBookingSlotsLessonPrice(lessonPrice)),
          const SizedBox(height: 4),
          Text(l10n.studentBookingSlotsDepositAmount(depositAmount)),
          const SizedBox(height: 2),
          Text(
            l10n.studentBookingSlotsDepositPercentage(
              pricing.depositPercentage,
            ),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppSemanticColors.of(context).muted,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.studentBookingSlotsLessonDuration(
              pricing.lessonDurationMinutes,
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptySlotsView extends StatelessWidget {
  const _EmptySlotsView({required this.l10n, required this.pricing});

  final AppLocalizations l10n;
  final StudentBookingPricingEntity pricing;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    return ListView(
      padding: AppDesignTokens.screenContentPadding(),
      children: [
        _PricingCard(pricing: pricing),
        const SizedBox(height: AppDesignTokens.spacingXl),
        Container(
          width: 56,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colors.neutralBg,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            PhosphorIconsBold.calendarX,
            color: colors.muted,
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
          ).textTheme.bodyMedium?.copyWith(color: colors.muted),
        ),
      ],
    );
  }
}
