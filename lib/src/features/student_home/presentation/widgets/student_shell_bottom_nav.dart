import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_mobile_bottom_nav.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/navigation/student_home_navigation.dart';

/// Shared student tab bar — embed on home / bookings / certificates / profile.
class StudentShellBottomNav extends StatelessWidget {
  const StudentShellBottomNav({super.key, required this.activeId});

  final String activeId;

  static List<AppMobileBottomNavItem> items(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return [
      AppMobileBottomNavItem(
        id: 'home',
        label: l10n.home,
        icon: PhosphorIconsBold.house,
      ),
      AppMobileBottomNavItem(
        id: 'bookings',
        label: l10n.studentHomeNavBookings,
        icon: PhosphorIconsBold.calendarDots,
      ),
      AppMobileBottomNavItem(
        id: 'certificate',
        label: l10n.studentHomeNavCertificate,
        icon: PhosphorIconsBold.certificate,
      ),
      AppMobileBottomNavItem(
        id: 'profile',
        label: l10n.studentHomeNavProfile,
        icon: PhosphorIconsBold.user,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: AppDesignTokens.screenHorizontalPadding,
      right: AppDesignTokens.screenHorizontalPadding,
      bottom: AppDesignTokens.spacing,
      child: AppMobileBottomNav(
        activeId: activeId,
        items: items(context),
        onItemSelected: (tabId) =>
            StudentHomeNavigation.handleBottomNav(context, tabId),
      ),
    );
  }
}
