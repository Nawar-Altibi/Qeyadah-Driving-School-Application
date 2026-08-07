import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_segmented_control.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/cubit/student_booking_cubit.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_gender.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/vehicle_source.dart';

class StudentBookingPreferencesBody extends StatelessWidget {
  const StudentBookingPreferencesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = AppSemanticColors.of(context);
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
                PhosphorIconsBold.steeringWheel,
                color: AppColors.brandPrimary,
              ),
            ),
            const SizedBox(height: AppDesignTokens.spacingSm),
            Text(
              l10n.studentBookingPreferencesIntroTitle,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.studentBookingPreferencesIntroBody,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: colors.muted),
            ),
          ],
        ),
        const SizedBox(height: AppDesignTokens.spacingLg),
        _PreferenceLabel(l10n.studentBookingTrainingTypeLabel),
        const SizedBox(height: AppDesignTokens.spacingSm),
        AppSegmentedControl<TrainingType>(
          value: filters.trainingType,
          items: [
            AppSegmentedItem(
              value: TrainingType.manual,
              label: l10n.studentBookingTrainingTypeManual,
            ),
            AppSegmentedItem(
              value: TrainingType.automatic,
              label: l10n.studentBookingTrainingTypeAutomatic,
            ),
          ],
          onChanged: context.read<StudentBookingCubit>().updateTrainingType,
        ),
        const SizedBox(height: AppDesignTokens.spacingMd),
        _PreferenceLabel(l10n.studentBookingVehicleSourceLabel),
        const SizedBox(height: AppDesignTokens.spacingSm),
        AppSegmentedControl<VehicleSource>(
          value: filters.vehicleSource,
          items: [
            AppSegmentedItem(
              value: VehicleSource.schoolCar,
              label: l10n.studentBookingVehicleSourceSchool,
            ),
            AppSegmentedItem(
              value: VehicleSource.studentCar,
              label: l10n.studentBookingVehicleSourceStudent,
            ),
          ],
          onChanged: context.read<StudentBookingCubit>().updateVehicleSource,
        ),
        const SizedBox(height: AppDesignTokens.spacingMd),
        _PreferenceLabel(l10n.studentBookingInstructorGenderLabel),
        const SizedBox(height: AppDesignTokens.spacingSm),
        AppSegmentedControl<InstructorGender>(
          value: filters.instructorGender,
          items: [
            AppSegmentedItem(
              value: InstructorGender.male,
              label: l10n.studentBookingInstructorGenderMale,
            ),
            AppSegmentedItem(
              value: InstructorGender.female,
              label: l10n.studentBookingInstructorGenderFemale,
            ),
          ],
          onChanged: context.read<StudentBookingCubit>().updateInstructorGender,
        ),
        const SizedBox(height: AppDesignTokens.spacingLg),
        AppButton.primary(
          label: l10n.studentBookingContinueButton,
          onPressed: context.read<StudentBookingCubit>().confirmPreferences,
        ),
      ],
    );
  }
}

class _PreferenceLabel extends StatelessWidget {
  const _PreferenceLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: Theme.of(
        context,
      ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
    );
  }
}
