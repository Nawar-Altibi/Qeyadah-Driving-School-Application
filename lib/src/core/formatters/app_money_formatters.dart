import 'package:intl/intl.dart';

abstract final class AppMoneyFormatters {
  /// Strips a redundant `.00` while preserving meaningful decimals.
  static String stripAmount(String raw) {
    final value = double.tryParse(raw.replaceAll(',', '')) ?? 0;
    return stripAmountValue(value);
  }

  static String stripAmountValue(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(2);
  }

  /// Grouped thousands formatting (`1,234` / `1,234.56`).
  static String formatGrouped(String raw) {
    final parsed = num.tryParse(raw.replaceAll(',', ''));
    if (parsed == null) return raw;
    if (parsed % 1 == 0) {
      return NumberFormat('#,###').format(parsed);
    }
    return NumberFormat('#,##0.00').format(parsed);
  }

  static String formatGroupedInt(int amount) {
    return NumberFormat('#,###').format(amount);
  }
}
