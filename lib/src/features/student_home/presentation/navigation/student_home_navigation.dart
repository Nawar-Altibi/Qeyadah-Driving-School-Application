import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/navigation/auth_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/navigation/notifications_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/navigation/student_booking_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/navigation/student_bookings_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/screens/student_bookings_list_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/navigation/student_certificates_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/screens/student_certificates_hub_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/entities/student_home_dashboard_entity.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/screens/student_home_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/navigation/student_payment_hold_args.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/navigation/student_payment_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/presentation/navigation/student_theory_navigation.dart';

abstract final class StudentHomeNavigation {
  static void goHome({BuildContext? context}) {
    AuthNavigation.goHome(context: context);
  }

  static void goProfile({BuildContext? context}) {
    AuthNavigation.goProfile(context: context);
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

  static void openNotifications({BuildContext? context}) {
    NotificationsNavigation.pushInbox(context: context);
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
        StudentCertificatesNavigation.pushHub(context: context);
      case StudentHomeQuickActionType.theorySimulation:
        StudentTheoryNavigation.pushSelfTest(context: context);
    }
  }

  static void handleBottomNav(BuildContext context, String tabId) {
    switch (tabId) {
      case 'home':
        if (GoRouterState.of(context).uri.path == StudentHomeScreen.routePath) {
          return;
        }
        goHome(context: context);
      case 'profile':
        if (GoRouterState.of(context).uri.path == ProfileScreen.routePath) {
          return;
        }
        goProfile(context: context);
      case 'bookings':
        if (GoRouterState.of(context).uri.path ==
            StudentBookingsListScreen.routePath) {
          return;
        }
        StudentBookingsNavigation.goList(context: context);
      case 'certificate':
        if (GoRouterState.of(context).uri.path ==
            StudentCertificatesHubScreen.routePath) {
          return;
        }
        StudentCertificatesNavigation.goHub(context: context);
    }
  }
}
