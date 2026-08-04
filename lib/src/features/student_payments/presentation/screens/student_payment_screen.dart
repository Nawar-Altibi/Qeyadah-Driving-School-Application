import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_alert_banner.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_info_row.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/formatters/student_booking_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/coordinators/student_payment_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/cubit/student_payment_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/navigation/student_payment_hold_args.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/navigation/student_payment_navigation.dart';
import 'package:qeyadah_mobile_app/src/shared/payments/sham_cash_transaction_input.dart';

class StudentPaymentScreen extends StatefulWidget {
  const StudentPaymentScreen({super.key, required this.args});

  static const String routePath = '/student/booking/payment';
  static const String routeName = 'student-booking-payment';

  final StudentPaymentHoldArgs args;

  @override
  State<StudentPaymentScreen> createState() => _StudentPaymentScreenState();
}

class _StudentPaymentScreenState extends State<StudentPaymentScreen> {
  final _transactionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<StudentPaymentCubit>().initialize(widget.args);
    });
  }

  @override
  void dispose() {
    _transactionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return StudentPaymentScreenCoordinator(
      child: Scaffold(
        backgroundColor: AppColors.appCanvas,
        appBar: AppBar(
          backgroundColor: AppColors.appCanvas,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: Text(l10n.studentPaymentTitle),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ResponsiveShell(
            child: BlocBuilder<StudentPaymentCubit, StudentPaymentState>(
              builder: (context, state) {
                return ListView(
                  padding: const EdgeInsets.all(
                    AppDesignTokens.screenHorizontalPadding,
                  ),
                  children: [
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.brandMintSoft,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  PhosphorIconsBold.wallet,
                                  color: AppColors.brandPrimary,
                                ),
                              ),
                              const SizedBox(width: AppDesignTokens.spacing),
                              Expanded(
                                child: Text(
                                  l10n.studentPaymentShamCashTitle,
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppDesignTokens.spacingMd),
                          AppInfoRow.simple(
                            label: l10n.studentPaymentDepositAmount,
                            value: widget.args.depositAmount,
                          ),
                          const SizedBox(height: AppDesignTokens.spacingSm),
                          AppInfoRow.simple(
                            label: l10n.studentPaymentReceiverName,
                            value: widget.args.receiverName,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppDesignTokens.spacingMd),
                    AppAlertBanner(
                      icon: PhosphorIconsBold.timer,
                      tone: state.isExpired
                          ? AppAlertTone.danger
                          : AppAlertTone.warning,
                      title: state.isExpired
                          ? l10n.studentPaymentExpiredTitle
                          : l10n.studentPaymentCountdownTitle,
                      message: state.isExpired
                          ? l10n.studentPaymentExpiredMessage
                          : l10n.studentPaymentCountdownMessage(
                              StudentBookingFormatters.countdown(
                                state.remaining,
                              ),
                            ),
                    ),
                    const SizedBox(height: AppDesignTokens.spacingLg),
                    Text(
                      l10n.studentPaymentTransactionIdLabel,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n.studentPaymentTransactionIdHint,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                    ),
                    const SizedBox(height: AppDesignTokens.spacingMd),
                    Center(
                      child: ShamCashTransactionInput(
                        controller: _transactionController,
                        autofocus: true,
                      ),
                    ),
                    const SizedBox(height: AppDesignTokens.spacingLg),
                    AppButton.primary(
                      label: l10n.studentPaymentConfirmButton,
                      isLoading: state.isSubmitting,
                      onPressed: state.isExpired
                          ? null
                          : () => context
                                .read<StudentPaymentCubit>()
                                .confirmPayment(_transactionController.text),
                    ),
                    if (state.isExpired) ...[
                      const SizedBox(height: AppDesignTokens.spacing),
                      AppButton.secondary(
                        label: l10n.studentPaymentBackToHomeButton,
                        onPressed: () =>
                            StudentPaymentNavigation.goHome(context: context),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
