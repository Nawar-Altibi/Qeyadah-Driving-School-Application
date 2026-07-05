import 'package:intl/intl.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_booking_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_type.dart';

abstract final class InstructorFormatters {
  static String initials(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '؟';
    if (parts.length == 1) {
      final word = parts.first;
      return word.length >= 2 ? word.substring(0, 2) : word;
    }
    return '${parts.first[0]} ${parts.last[0]}';
  }

  static String welcomeBack(AppLocalizations l10n, String name) {
    final trimmed = name.trim();
    return l10n.instructorWelcomeBack(
      trimmed.isEmpty ? l10n.instructorGuestName : trimmed,
    );
  }

  static String monthYearLabel(DateTime date, String localeName) {
    return DateFormat('MMMM yyyy', localeName).format(date);
  }

  static String fullDateLabel(DateTime date, String localeName) {
    return DateFormat('EEEE، d MMMM', localeName).format(date);
  }

  static String shortWeekday(DateTime date, String localeName) {
    return DateFormat('EEE', localeName).format(date);
  }

  static String dayNumber(DateTime date) {
    return DateFormat('d').format(date);
  }

  static String timeLabel(String time) => time;

  static String trainingHoursLabel(AppLocalizations l10n, double hours) {
    if (hours == hours.roundToDouble()) {
      return l10n.instructorTrainingHoursCount(hours.round());
    }
    return l10n.instructorTrainingHoursDecimal(hours);
  }

  static String trainingTypeLabel(
    AppLocalizations l10n,
    InstructorType type,
  ) {
    return switch (type) {
      InstructorType.manual => l10n.studentHomeManual,
      InstructorType.automatic => l10n.studentHomeAutomatic,
    };
  }

  static String bookingStatusLabel(
    AppLocalizations l10n,
    InstructorBookingStatus status,
  ) {
    return switch (status) {
      InstructorBookingStatus.booked => l10n.instructorBookingConfirmed,
      InstructorBookingStatus.completed => l10n.instructorBookingCompleted,
      InstructorBookingStatus.noShow => l10n.instructorBookingNoShow,
      InstructorBookingStatus.cancelled => l10n.instructorBookingCancelled,
      InstructorBookingStatus.expired => l10n.instructorBookingExpired,
      InstructorBookingStatus.pendingPayment => l10n.instructorBookingPendingPayment,
    };
  }

  static String vehicleSourceLabel(
    AppLocalizations l10n,
    String vehicleSource,
  ) {
    return switch (vehicleSource.toUpperCase()) {
      'SCHOOL_CAR' => l10n.studentHomeSchoolVehicle,
      'STUDENT_CAR' => l10n.studentHomeStudentVehicle,
      _ => vehicleSource,
    };
  }

  static String currencyAmount(AppLocalizations l10n, int amount) {
    return l10n.instructorCurrencyAmount(amount);
  }

  static String durationLabel(AppLocalizations l10n, Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours > 0 && minutes > 0) {
      return l10n.instructorDurationHoursMinutes(hours, minutes);
    }
    if (hours > 0) {
      return l10n.instructorDurationHours(hours);
    }
    return l10n.instructorDurationMinutes(minutes);
  }

  static String leavePeriodLabel(
    AppLocalizations l10n,
    InstructorLeaveEntity leave,
    String localeName,
  ) {
    if (leave.isFullDay) {
      return l10n.instructorLeaveFullDay(
        fullDateLabel(leave.startAt, localeName),
      );
    }
    final formatter = DateFormat('HH:mm', localeName);
    return l10n.instructorLeaveHourly(
      fullDateLabel(leave.startAt, localeName),
      formatter.format(leave.startAt),
      formatter.format(leave.endAt),
    );
  }

  static List<DateTime> weekAround(DateTime anchor) {
    final normalized = DateTime(anchor.year, anchor.month, anchor.day);
    return List.generate(7, (index) => normalized.add(Duration(days: index - 3)));
  }
}
