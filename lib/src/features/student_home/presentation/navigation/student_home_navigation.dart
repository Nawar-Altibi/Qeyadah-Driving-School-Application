import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/navigation/auth_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/navigation/student_booking_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/navigation/student_bookings_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/entities/student_home_dashboard_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/navigation/student_payment_hold_args.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/navigation/student_payment_navigation.dart';

abstract final class StudentHomeNavigation {
  static void goProfile({BuildContext? context}) {
    AuthNavigation.pushProfile(context: context);
  }

  /// Resumes the ShamCash payment screen for an existing pending booking,
  /// when the home dashboard reports enough details to do so.
  static void resumePendingPayment({
    required BuildContext context,
    required StudentHomePendingPaymentEntity pendingPayment,
  }) {
    if (!pendingPayment.canResumePayment) return;
    StudentPaymentNavigation.pushPayment(
      context: context,
      args: StudentPaymentHoldArgs(
        bookingId: pendingPayment.bookingId!,
        depositAmount: pendingPayment.depositAmount!,
        receiverName: pendingPayment.receiverName!,
        lockedUntil: pendingPayment.lockedUntil!,
      ),
    );
  }

  static void showComingSoon(BuildContext context) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger == null) {
      return;
    }

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).studentHomeFeatureComingSoon,
          ),
        ),
      );
  }

  static void handleQuickAction(
    BuildContext context,
    StudentHomeQuickActionType action,
  ) {
    switch (action) {
      case StudentHomeQuickActionType.newBooking:
        StudentBookingNavigation.pushPreferences(context: context);
      case StudentHomeQuickActionType.myBookings:
        StudentBookingsNavigation.pushList(context: context);
      case StudentHomeQuickActionType.certificateRequest:
      case StudentHomeQuickActionType.theorySimulation:
        showComingSoon(context);
    }
  }

  static void handleBottomNav(BuildContext context, String tabId) {
    switch (tabId) {
      case 'home':
        return;
      case 'profile':
        goProfile(context: context);
      case 'bookings':
        StudentBookingsNavigation.pushList(context: context);
      case 'certificate':
        showComingSoon(context);
    }
  }
}
