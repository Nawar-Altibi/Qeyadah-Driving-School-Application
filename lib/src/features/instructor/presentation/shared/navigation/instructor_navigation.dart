import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/dues/screens/instructor_dues_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/earnings/screens/instructor_earnings_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/invoices/screens/instructor_invoices_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/leave/screens/instructor_leave_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/profile/screens/instructor_profile_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/screens/instructor_schedule_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/screens/instructor_weekly_schedule_screen.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/navigation/notifications_navigation.dart';

abstract final class InstructorNavigation {
  static void openSchedule(BuildContext context) {
    CoreNavigator.toNamed(InstructorScheduleScreen.routeName, context: context);
  }

  static void openProfile(BuildContext context) {
    CoreNavigator.toNamed(InstructorProfileScreen.routeName, context: context);
  }

  static void openLeaves(BuildContext context) {
    CoreNavigator.pushNamed(InstructorLeaveScreen.routeName, context: context);
  }

  static void openWeeklySchedule(BuildContext context) {
    CoreNavigator.pushNamed(
      InstructorWeeklyScheduleScreen.routeName,
      context: context,
    );
  }

  static void openDues(BuildContext context) {
    CoreNavigator.pushNamed(InstructorDuesScreen.routeName, context: context);
  }

  static void openEarnings(BuildContext context) {
    CoreNavigator.pushNamed(
      InstructorEarningsScreen.routeName,
      context: context,
    );
  }

  static void openInvoices(BuildContext context) {
    CoreNavigator.pushNamed(
      InstructorInvoicesScreen.routeName,
      context: context,
    );
  }

  static void openNotifications(BuildContext context) {
    NotificationsNavigation.pushInbox(context: context);
  }

  static void handleBottomNav(BuildContext context, String tabId) {
    switch (tabId) {
      case 'schedule':
        openSchedule(context);
      case 'profile':
        openProfile(context);
      default:
        showComingSoon(context);
    }
  }

  static void showComingSoon(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(l10n.instructorFeatureComingSoon)));
  }
}
