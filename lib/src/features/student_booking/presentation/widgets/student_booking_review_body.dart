import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/entities/student_booking_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/cubit/student_booking_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/formatters/student_booking_formatters.dart';

class StudentBookingReviewBody extends StatelessWidget {
  const StudentBookingReviewBody({
    super.key,
    required this.selection,
    required this.isCreatingBooking,
  });

  final StudentBookingSelectionEntity selection;
  final bool isCreatingBooking;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = AppSemanticColors.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final filters = context.select(
      (StudentBookingCubit cubit) => cubit.state.filters,
    );

    return ListView(
      padding: const EdgeInsets.all(AppDesignTokens.screenHorizontalPadding),
      children: [
        Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colors.brandSoft,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const AppNonMirroredIcon(
                PhosphorIconsBold.checkCircle,
                color: AppColors.brandPrimary,
              ),
            ),
            const SizedBox(height: AppDesignTokens.spacingSm),
            Text(
              l10n.studentBookingReviewSummaryTitle,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
          ],
        ),
        const SizedBox(height: AppDesignTokens.spacingLg),
        AppCard(
          child: Column(
            children: [
              _ReviewRow(
                label: l10n.studentBookingReviewInstructorLabel,
                value: selection.instructor.name,
              ),
              const Divider(height: AppDesignTokens.spacingLg),
              _ReviewRow(
                label: l10n.studentBookingReviewDateLabel,
                value: StudentBookingFormatters.dayLabel(
                  selection.slot.date,
                  localeName,
                ),
              ),
              const Divider(height: AppDesignTokens.spacingLg),
              _ReviewRow(
                label: l10n.studentBookingReviewTimeLabel,
                value: StudentBookingFormatters.timeRangeLabel(
                  selection.slot.startTime,
                  selection.slot.endTime,
                ),
              ),
              const Divider(height: AppDesignTokens.spacingLg),
              _ReviewRow(
                label: l10n.studentBookingReviewTrainingTypeLabel,
                value: StudentBookingFormatters.trainingTypeLabel(
                  l10n,
                  filters.trainingType,
                ),
              ),
              const Divider(height: AppDesignTokens.spacingLg),
              _ReviewRow(
                label: l10n.studentBookingReviewVehicleSourceLabel,
                value: StudentBookingFormatters.vehicleSourceLabel(
                  l10n,
                  filters.vehicleSource,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDesignTokens.spacingLg),
        AppButton.primary(
          label: l10n.studentBookingReviewCreateButton,
          isLoading: isCreatingBooking,
          onPressed: context.read<StudentBookingCubit>().createBooking,
        ),
      ],
    );
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: colors.muted),
        ),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
