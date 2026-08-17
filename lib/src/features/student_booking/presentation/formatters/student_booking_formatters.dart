import 'package:intl/intl.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/formatters/app_date_formatters.dart';
import 'package:qeyadah_mobile_app/src/core/formatters/app_money_formatters.dart';
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
    return AppDateFormatters.fullDayLabel(date, localeName);
  }

  static String compactWeekday(DateTime date, String localeName) {
    return DateFormat('EEE', localeName).format(date);
  }

  static String compactDayNumber(DateTime date, String localeName) {
    return DateFormat('d', localeName).format(date);
  }

  static SlotDayPeriod dayPeriod(String startTime) {
    final hour = int.tryParse(startTime.split(':').first.trim()) ?? 0;
    if (hour < 12) return SlotDayPeriod.morning;
    if (hour < 17) return SlotDayPeriod.afternoon;
    return SlotDayPeriod.evening;
  }

  static String timeRangeLabel(String startTime, String endTime) {
    return AppDateFormatters.timeRangeLabel(startTime, endTime);
  }

  static String countdown(Duration remaining) {
    return AppDateFormatters.countdown(remaining);
  }

  /// Grouped currency label for API amount strings (`"33000.00"` → `"33,000 ل.س"`).
  static String currency(AppLocalizations l10n, String rawAmount) {
    return l10n.studentBookingsCurrencyAmount(
      AppMoneyFormatters.formatGrouped(rawAmount),
    );
  }
}

enum SlotDayPeriod { morning, afternoon, evening }
