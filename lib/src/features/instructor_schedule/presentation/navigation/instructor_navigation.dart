import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_leave/presentation/screens/instructor_leave_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_profile/presentation/screens/instructor_profile_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/screens/instructor_schedule_screen.dart';

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
