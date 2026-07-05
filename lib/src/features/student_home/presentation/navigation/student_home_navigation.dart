import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/navigation/auth_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/entities/student_home_dashboard_entity.dart';

abstract final class StudentHomeNavigation {
  static void goProfile({BuildContext? context}) {
    AuthNavigation.pushProfile(context: context);
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
          content: Text(AppLocalizations.of(context).studentHomeFeatureComingSoon),
        ),
      );
  }

  static void handleQuickAction(
    BuildContext context,
    StudentHomeQuickActionType action,
  ) {
    switch (action) {
      case StudentHomeQuickActionType.newBooking:
      case StudentHomeQuickActionType.myBookings:
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
      case 'certificate':
        showComingSoon(context);
    }
  }
}
