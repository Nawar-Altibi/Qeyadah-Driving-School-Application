import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/navigation/student_booking_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/navigation/student_bookings_navigation.dart';

/// Shown when create-booking returns [paymentRequired] = false (saved deposit).
class StudentBookingCreditSuccessScreen extends StatelessWidget {
  const StudentBookingCreditSuccessScreen({super.key, required this.bookingId});

  static const String routePath = '/student/booking/credit-success';
  static const String routeName = 'student-booking-credit-success';

  final int bookingId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = AppSemanticColors.of(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        StudentBookingNavigation.goHome(context: context);
      },
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(l10n.studentBookingCreditSuccessTitle),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ResponsiveShell(
            child: Padding(
              padding: const EdgeInsets.all(
                AppDesignTokens.screenHorizontalPadding,
              ),
              child: Column(
                children: [
                  const Spacer(),
                  AppCard(
                    child: Column(
                      children: [
                        Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: colors.brandSoft,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Icon(
                            PhosphorIconsBold.checkCircle,
                            color: AppColors.brandPrimary,
                            size: 28,
                          ),
                        ),
                        const SizedBox(height: AppDesignTokens.spacingMd),
                        Text(
                          l10n.studentBookingCreditSuccessTitle,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(height: AppDesignTokens.spacingSm),
                        Text(
                          l10n.studentBookingCreditSuccessMessage,
                          textAlign: TextAlign.center,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium?.copyWith(color: colors.muted),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  AppButton.primary(
                    label: l10n.studentBookingCreditSuccessViewDetails,
                    onPressed: () => StudentBookingsNavigation.pushDetail(
                      context: context,
                      bookingId: bookingId,
                    ),
                  ),
                  const SizedBox(height: AppDesignTokens.spacing),
                  AppButton.secondary(
                    label: l10n.studentBookingCreditSuccessBackHome,
                    onPressed: () =>
                        StudentBookingNavigation.goHome(context: context),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
