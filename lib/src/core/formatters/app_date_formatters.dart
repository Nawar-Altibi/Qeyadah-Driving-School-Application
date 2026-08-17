import 'package:intl/intl.dart';

abstract final class AppDateFormatters {
  static String fullDayLabel(DateTime date, String localeName) {
    return DateFormat('EEEE، d MMMM', localeName).format(date);
  }

  /// Locale-aware date only (no time).
  static String dateLabel(DateTime value, String localeName) {
    return DateFormat('d MMMM yyyy', localeName).format(value);
  }

  /// Locale-aware clock time.
  static String timeLabel(DateTime value, String localeName) {
    return DateFormat.Hm(localeName).format(value);
  }

  /// Locale-aware date + time with an explicit separator (not glued together).
  static String dateTimeLabel(DateTime value, String localeName) {
    return '${dateLabel(value, localeName)} · ${timeLabel(value, localeName)}';
  }

  static String timeRangeLabel(String startTime, String endTime) {
    return '$startTime – $endTime';
  }

  static String timeRangeFromDates(
    DateTime start,
    DateTime end,
    String localeName,
  ) {
    return timeRangeLabel(
      timeLabel(start, localeName),
      timeLabel(end, localeName),
    );
  }

  /// Short hold windows (Sham Cash payment): `MM:SS`.
  static String countdown(Duration remaining) {
    final clamped = remaining.isNegative ? Duration.zero : remaining;
    final minutes = clamped.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = clamped.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// Splits a countdown into days + leftover hours/minutes/seconds.
  static ({int days, int hours, int minutes, int seconds}) countdownParts(
    Duration remaining,
  ) {
    final clamped = remaining.isNegative ? Duration.zero : remaining;
    return (
      days: clamped.inDays,
      hours: clamped.inHours.remainder(24),
      minutes: clamped.inMinutes.remainder(60),
      seconds: clamped.inSeconds.remainder(60),
    );
  }

  /// Longer deadlines (certificate reexam registration).
  ///
  /// Over 24 hours includes days, e.g. `13 يوم · 16 س · 30 د · 23 ث`.
  /// Under 24 hours omits days, e.g. `16 س · 30 د · 23 ث`.
  static String countdownHms(
    Duration remaining, {
    required String hoursUnit,
    required String minutesUnit,
    required String secondsUnit,
    String? daysUnit,
  }) {
    final parts = countdownParts(remaining);
    final hours = parts.hours.toString().padLeft(2, '0');
    final minutes = parts.minutes.toString().padLeft(2, '0');
    final seconds = parts.seconds.toString().padLeft(2, '0');
    final hms =
        '$hours $hoursUnit · $minutes $minutesUnit · $seconds $secondsUnit';
    if (parts.days > 0 && daysUnit != null && daysUnit.isNotEmpty) {
      return '${parts.days} $daysUnit · $hms';
    }
    return hms;
  }

  static String paymentCountdown({required int minutes, required int seconds}) {
    final mm = minutes.clamp(0, 99).toString().padLeft(2, '0');
    final ss = seconds.clamp(0, 59).toString().padLeft(2, '0');
    return '$mm:$ss';
  }
}
