import 'package:intl/intl.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_gender.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/vehicle_source.dart';

abstract final class StudentBookingFormatters {
  static String trainingTypeLabel(AppLocalizations l10n, TrainingType type) {
    return switch (type) {
      TrainingType.manual => l10n.studentBookingTrainingTypeManual,
      TrainingType.automatic => l10n.studentBookingTrainingTypeAutomatic,
    };
  }

  static String vehicleSourceLabel(
    AppLocalizations l10n,
    VehicleSource source,
  ) {
    return switch (source) {
      VehicleSource.schoolCar => l10n.studentBookingVehicleSourceSchool,
      VehicleSource.studentCar => l10n.studentBookingVehicleSourceStudent,
    };
  }

  static String instructorGenderLabel(
    AppLocalizations l10n,
    InstructorGender gender,
  ) {
    return switch (gender) {
      InstructorGender.male => l10n.studentBookingInstructorGenderMale,
      InstructorGender.female => l10n.studentBookingInstructorGenderFemale,
    };
  }

  static String dayLabel(DateTime date, String localeName) {
    return DateFormat('EEEE، d MMMM', localeName).format(date);
  }

  static String timeRangeLabel(String startTime, String endTime) {
    return '$startTime - $endTime';
  }

  static String countdown(Duration remaining) {
    final clamped = remaining.isNegative ? Duration.zero : remaining;
    final minutes = clamped.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = clamped.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
