import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_charge_tile.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_meta_row.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_section_heading.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_status_badge.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/navigation/student_booking_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/cubit/student_booking_detail_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/formatters/student_bookings_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/widgets/student_booking_cancel_sheet.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/widgets/student_booking_deposit_outcome_banner.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/student_booking_status.dart';

class StudentBookingDetailBody extends StatelessWidget {
  const StudentBookingDetailBody({
    super.key,
    required this.detail,
    this.isCancelling = false,
    this.interactive = true,
  });

  final StudentBookingDetailEntity detail;
  final bool isCancelling;
  final bool interactive;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final booking = detail.booking;
    final depositOutcome =
        booking.bookingStatus == StudentBookingStatus.cancelled
        ? StudentBookingDepositOutcomeMapper.fromPaymentStatus(
            booking.paymentStatus,
          )
        : StudentBookingDepositOutcome.none;

    return ListView(
      padding: AppDesignTokens.screenContentPadding(),
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppStatusBadge(
                    label: StudentBookingsFormatters.bookingStatusLabel(
                      l10n,
                      booking.bookingStatus,
                    ),
                    tone: StudentBookingsFormatters.bookingStatusTone(
                      booking.bookingStatus,
                    ),
                  ),
                  const SizedBox(width: AppDesignTokens.spacingSm),
                  AppStatusBadge(
                    label: StudentBookingsFormatters.paymentStatusLabel(
                      l10n,
                      booking.paymentStatus,
                    ),
                    tone: StudentBookingsFormatters.paymentStatusTone(
                      booking.paymentStatus,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDesignTokens.spacingMd),
              AppMetaRow(
                icon: PhosphorIconsBold.calendar,
                label: booking.date != null
                    ? StudentBookingsFormatters.dayLabel(
                        booking.date!,
                        localeName,
                      )
                    : (booking.dayName ?? '-'),
              ),
              const SizedBox(height: AppDesignTokens.spacingSm),
              AppMetaRow(
                icon: PhosphorIconsBold.clock,
                label: StudentBookingsFormatters.timeRangeLabel(
                  booking.startTime ?? '-',
                  booking.endTime ?? '-',
                ),
              ),
              if (booking.trainingType != null) ...[
                const SizedBox(height: AppDesignTokens.spacingSm),
                AppMetaRow(
                  icon: PhosphorIconsBold.car,
                  label: StudentBookingsFormatters.trainingTypeLabel(
                    l10n,
                    booking.trainingType!,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (depositOutcome != StudentBookingDepositOutcome.none) ...[
          const SizedBox(height: AppDesignTokens.spacing),
          StudentBookingDepositOutcomeBanner(
            outcome: depositOutcome,
            onRebook: interactive
                ? () =>
                      StudentBookingNavigation.pushPreferences(context: context)
                : null,
          ),
        ],
        if (interactive &&
            booking.bookingStatus == StudentBookingStatus.pendingPayment) ...[
          const SizedBox(height: AppDesignTokens.spacing),
          AppButton.primary(
            label: l10n.studentBookingDetailCompletePayment,
            onPressed: () => context
                .read<StudentBookingDetailCubit>()
                .resumePendingPayment(),
          ),
        ],
        const SizedBox(height: AppDesignTokens.spacingLg),
        AppSectionHeading(title: l10n.studentBookingDetailInstructorTitle),
        const SizedBox(height: AppDesignTokens.spacingSm),
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppMetaRow(
                icon: PhosphorIconsBold.user,
                label: detail.instructor.name,
              ),
              if (detail.instructor.phone != null) ...[
                const SizedBox(height: AppDesignTokens.spacingSm),
                AppMetaRow(
                  icon: PhosphorIconsBold.phone,
                  label: detail.instructor.phone!,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppDesignTokens.spacingLg),
        AppSectionHeading(title: l10n.studentBookingDetailVehicleTitle),
        const SizedBox(height: AppDesignTokens.spacingSm),
        AppCard(
          child: detail.vehicle != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (detail.vehicle!.source != null)
                      AppMetaRow(
                        icon: PhosphorIconsBold.car,
                        label: StudentBookingsFormatters.vehicleSourceLabel(
                          l10n,
                          detail.vehicle!.source!,
                        ),
                      ),
                    if (detail.vehicle!.plateNumber != null) ...[
                      const SizedBox(height: AppDesignTokens.spacingSm),
                      AppMetaRow(
                        icon: PhosphorIconsBold.identificationCard,
                        label: detail.vehicle!.plateNumber!,
                      ),
                    ],
                  ],
                )
              : AppMetaRow(
                  icon: PhosphorIconsBold.car,
                  label: l10n.studentBookingDetailOwnVehicleNote,
                ),
        ),
        const SizedBox(height: AppDesignTokens.spacingLg),
        AppSectionHeading(title: l10n.studentBookingDetailChargesTitle),
        const SizedBox(height: AppDesignTokens.spacingSm),
        if (detail.charges.isEmpty)
          AppCard(child: Text(l10n.studentBookingDetailChargesEmpty))
        else
          for (final charge in detail.charges) ...[
            AppChargeTile(
              useCardShell: true,
              title: charge.chargeReason,
              statusLabel: StudentBookingsFormatters.chargeStatusLabel(
                l10n,
                charge.chargeStatus,
              ),
              statusTone: AppBadgeTone.neutral,
              amountLabel: l10n.studentBookingDetailChargeAmountDue(
                StudentBookingsFormatters.currency(l10n, charge.amountDue),
              ),
              payments: [
                for (final payment in charge.payments)
                  AppChargePaymentLine(
                    method: StudentBookingsFormatters.paymentMethodLabel(
                      l10n,
                      payment.paymentMethod,
                    ),
                    amount: StudentBookingsFormatters.currency(
                      l10n,
                      payment.amountPaid,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: AppDesignTokens.spacingSm),
          ],
        const SizedBox(height: AppDesignTokens.spacingSm),
        AppCard(
          backgroundColor: AppColors.brandMintSoft,
          borderColor: Colors.transparent,
          child: Text(
            l10n.studentBookingDetailRemainingCallout(
              StudentBookingsFormatters.currencyValue(l10n, detail.totalPaid),
              StudentBookingsFormatters.currencyValue(
                l10n,
                detail.totalAmountDue,
              ),
              StudentBookingsFormatters.currencyValue(
                l10n,
                detail.totalRemaining,
              ),
            ),
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        if (interactive && booking.isCancellable) ...[
          const SizedBox(height: AppDesignTokens.spacingLg),
          AppButton.danger(
            label: l10n.studentBookingDetailCancelButton,
            isLoading: isCancelling,
            onPressed: () => showStudentBookingCancelSheet(
              context: context,
              cubit: context.read<StudentBookingDetailCubit>(),
            ),
          ),
        ],
      ],
    );
  }
}
