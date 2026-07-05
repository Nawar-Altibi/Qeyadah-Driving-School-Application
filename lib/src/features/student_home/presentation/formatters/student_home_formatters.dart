import 'package:intl/intl.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';

abstract final class StudentHomeFormatters {
  static String greetingFor({
    required AppLocalizations l10n,
    required String name,
    required DateTime referenceDate,
  }) {
    final hour = referenceDate.hour;
    final trimmedName = name.trim();
    final displayName = trimmedName.isEmpty ? l10n.studentHomeGuestName : trimmedName;

    if (hour < 12) {
      return l10n.studentHomeGreetingMorning(displayName);
    }
    if (hour < 17) {
      return l10n.studentHomeGreetingAfternoon(displayName);
    }
    return l10n.studentHomeGreetingEvening(displayName);
  }

  static String dateLabel(DateTime date, String localeName) {
    return DateFormat('EEEE، d MMMM', localeName).format(date);
  }

  static String monthLabel(DateTime date, String localeName) {
    return DateFormat('MMMM', localeName).format(date);
  }

  static String weekdayLabel(DateTime date, String localeName) {
    return DateFormat('EEEE', localeName).format(date);
  }

  static String timeRange({
    required DateTime startsAt,
    required DateTime endsAt,
    required String localeName,
  }) {
    final formatter = DateFormat('HH:mm', localeName);
    return '${formatter.format(startsAt)} - ${formatter.format(endsAt)}';
  }

  static String paymentCountdown({
    required int minutes,
    required int seconds,
  }) {
    final paddedMinutes = minutes.toString().padLeft(2, '0');
    final paddedSeconds = seconds.toString().padLeft(2, '0');
    return '$paddedMinutes:$paddedSeconds';
  }
}
