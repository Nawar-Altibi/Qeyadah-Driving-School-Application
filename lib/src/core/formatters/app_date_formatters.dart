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
    return timeRangeLabel(timeLabel(start, localeName), timeLabel(end, localeName));
  }

  static String countdown(Duration remaining) {
    final clamped = remaining.isNegative ? Duration.zero : remaining;
    final minutes = clamped.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = clamped.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  static String paymentCountdown({required int minutes, required int seconds}) {
    final mm = minutes.clamp(0, 99).toString().padLeft(2, '0');
    final ss = seconds.clamp(0, 59).toString().padLeft(2, '0');
    return '$mm:$ss';
  }
}
