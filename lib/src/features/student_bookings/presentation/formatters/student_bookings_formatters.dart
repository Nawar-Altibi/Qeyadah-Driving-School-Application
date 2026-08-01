import 'package:intl/intl.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_status_badge.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/shared/formatters/instructor_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/formatters/student_booking_formatters.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_payment_method.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_booking_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_charge_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_payment_status.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/vehicle_source.dart';

abstract final class StudentBookingsFormatters {
  static String bookingStatusLabel(
    AppLocalizations l10n,
    StudentBookingStatus status,
  ) {
    return switch (status) {
      StudentBookingStatus.pendingPayment =>
        l10n.studentBookingsStatusPendingPayment,
      StudentBookingStatus.booked => l10n.studentBookingsStatusBooked,
      StudentBookingStatus.completed => l10n.studentBookingsStatusCompleted,
      StudentBookingStatus.cancelled => l10n.studentBookingsStatusCancelled,
      StudentBookingStatus.expired => l10n.studentBookingsStatusExpired,
      StudentBookingStatus.noShow => l10n.studentBookingsStatusNoShow,
    };
  }

  static AppBadgeTone bookingStatusTone(StudentBookingStatus status) {
    return switch (status) {
      StudentBookingStatus.booked => AppBadgeTone.success,
      StudentBookingStatus.pendingPayment => AppBadgeTone.warning,
      StudentBookingStatus.completed => AppBadgeTone.info,
      StudentBookingStatus.cancelled => AppBadgeTone.danger,
      StudentBookingStatus.expired => AppBadgeTone.neutral,
      StudentBookingStatus.noShow => AppBadgeTone.danger,
    };
  }

  static String paymentStatusLabel(
    AppLocalizations l10n,
    StudentPaymentStatus status,
  ) {
    return switch (status) {
      StudentPaymentStatus.pendingDeposit =>
        l10n.studentBookingsPaymentPendingDeposit,
      StudentPaymentStatus.depositPaid =>
        l10n.studentBookingsPaymentDepositPaid,
      StudentPaymentStatus.fullyPaid => l10n.studentBookingsPaymentFullyPaid,
      StudentPaymentStatus.depositNonRefundable =>
        l10n.studentBookingsPaymentDepositNonRefundable,
      StudentPaymentStatus.depositAvailableForRebooking =>
        l10n.studentBookingsPaymentDepositAvailableForRebooking,
      StudentPaymentStatus.depositUsedInRebooking =>
        l10n.studentBookingsPaymentDepositUsedInRebooking,
    };
  }

  static AppBadgeTone paymentStatusTone(StudentPaymentStatus status) {
    return switch (status) {
      StudentPaymentStatus.fullyPaid => AppBadgeTone.success,
      StudentPaymentStatus.depositPaid => AppBadgeTone.info,
      StudentPaymentStatus.pendingDeposit => AppBadgeTone.warning,
      StudentPaymentStatus.depositAvailableForRebooking => AppBadgeTone.info,
      StudentPaymentStatus.depositUsedInRebooking => AppBadgeTone.neutral,
      StudentPaymentStatus.depositNonRefundable => AppBadgeTone.danger,
    };
  }

  static String chargeStatusLabel(
    AppLocalizations l10n,
    StudentChargeStatus status,
  ) {
    return switch (status) {
      StudentChargeStatus.unpaid => l10n.studentBookingsChargeUnpaid,
      StudentChargeStatus.partiallyPaid =>
        l10n.studentBookingsChargePartiallyPaid,
      StudentChargeStatus.paid => l10n.studentBookingsChargePaid,
      StudentChargeStatus.cancelled => l10n.studentBookingsChargeCancelled,
    };
  }

  static String trainingTypeLabel(AppLocalizations l10n, TrainingType type) =>
      StudentBookingFormatters.trainingTypeLabel(l10n, type);

  static String vehicleSourceLabel(
    AppLocalizations l10n,
    VehicleSource source,
  ) => StudentBookingFormatters.vehicleSourceLabel(l10n, source);

  /// Backend payment methods (e.g. `SHAM_CASH`) reuse the instructor
  /// payment-method vocabulary; falls back to the raw value if unmapped.
  static String paymentMethodLabel(AppLocalizations l10n, String raw) {
    final method = InstructorPaymentMethod.fromApi(raw);
    if (method == null) return raw;
    return InstructorFormatters.paymentMethodLabel(l10n, method);
  }

  static String dayLabel(DateTime date, String localeName) {
    return DateFormat('EEEE، d MMMM', localeName).format(date);
  }

  static String timeRangeLabel(String startTime, String endTime) {
    return '$startTime - $endTime';
  }

  /// Strips a redundant `.00` while preserving meaningful decimals, since
  /// backend amounts arrive as strings that may or may not carry decimals.
  static String amount(String raw) {
    final value = double.tryParse(raw) ?? 0;
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(2);
  }

  static String amountValue(double value) {
    if (value == value.roundToDouble()) {
      return value.toInt().toString();
    }
    return value.toStringAsFixed(2);
  }

  static String currency(AppLocalizations l10n, String raw) {
    return l10n.studentBookingsCurrencyAmount(amount(raw));
  }

  static String currencyValue(AppLocalizations l10n, double value) {
    return l10n.studentBookingsCurrencyAmount(amountValue(value));
  }
}
