import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_flow_back_button.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificate_write_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/formatters/student_certificates_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/mappers/student_certificate_write_failure_mapper.dart';
import 'package:qeyadah_mobile_app/src/shared/payments/sham_cash_transaction_input.dart';

class StudentCertificateReexamScreen extends StatefulWidget {
  const StudentCertificateReexamScreen({
    required this.certificateId,
    super.key,
  });

  static const routePath = '/student/certificates/:id/reexam';
  static const routeName = 'student-certificate-reexam';
  static String pathFor(String id) => '/student/certificates/$id/reexam';

  final String certificateId;

  @override
  State<StudentCertificateReexamScreen> createState() =>
      _StudentCertificateReexamScreenState();
}

class _StudentCertificateReexamScreenState
    extends State<StudentCertificateReexamScreen> {
  final _transactionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StudentCertificateWriteCubit>().initializeReexam(
        widget.certificateId,
      );
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
    return BlocConsumer<
      StudentCertificateWriteCubit,
      StudentCertificateWriteState
    >(
      listenWhen: (previous, current) =>
          previous.restoredTransactionId != current.restoredTransactionId ||
          previous.effect != current.effect,
      listener: (context, state) {
        final restored = state.restoredTransactionId;
        if (restored != null && _transactionController.text.isEmpty) {
          _transactionController.text = restored;
        }
        final effect = state.effect;
        if (effect == null) return;
        switch (effect) {
          case StudentCertificateWriteSucceeded():
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.studentCertificatesReexamSuccess)),
            );
            Navigator.of(context).pop(true);
          case StudentCertificateReexamNoLongerEligible(:final message):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  message.isEmpty
                      ? l10n.studentCertificatesStatusFallback
                      : message,
                ),
              ),
            );
            Navigator.of(context).pop();
          case StudentCertificateWriteFailed(:final failure):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  StudentCertificateWriteFailureMapper.messageFor(
                    failure,
                    l10n,
                  ),
                ),
              ),
            );
          case StudentCertificateWriteConflict():
            break;
        }
        context.read<StudentCertificateWriteCubit>().clearEffect();
      },
      builder: (context, state) => Scaffold(
        backgroundColor: AppColors.appCanvas,
        appBar: AppBar(
          title: Text(l10n.studentCertificatesReexamTitle),
          backgroundColor: AppColors.appCanvas,
          surfaceTintColor: Colors.transparent,
          leading: AppFlowBackButton(
            onCancel: context.read<StudentCertificateWriteCubit>().resetDraft,
          ),
        ),
        body: state.eligibilityState.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          failed: (failure, retry) => Center(
            child: AppButton.primary(label: l10n.retry, onPressed: retry),
          ),
          succeeded: (eligibility) {
            final reexam = eligibility.reexam;
            if (!reexam.eligible) {
              return Center(child: Text(reexam.message ?? ''));
            }
            final examType = reexam.examType;
            return ListView(
              padding: const EdgeInsets.all(AppDesignTokens.spacingMd),
              children: [
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        examType == null
                            ? l10n.studentCertificatesReexamTitle
                            : l10n.studentCertificatesReexamTitleTyped(
                                StudentCertificatesFormatters.examTypeLabel(
                                  l10n,
                                  examType,
                                ),
                              ),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      if (reexam.fee != null)
                        Text(
                          l10n.studentCertificatesReexamFee(
                            StudentCertificatesFormatters.fee(reexam.fee!),
                          ),
                        ),
                      if (reexam.examScheduledLabel != null)
                        Text(
                          l10n.studentCertificatesExamScheduled(
                            reexam.examScheduledLabel!,
                          ),
                        ),
                      if (reexam.registrationClosesLabel != null)
                        Text(
                          l10n.studentCertificatesRegistrationCloses(
                            reexam.registrationClosesLabel!,
                          ),
                        ),
                      if (state.reexamRemaining > Duration.zero)
                        Text(
                          l10n.studentCertificatesRegistrationCountdown(
                            StudentCertificatesFormatters.countdown(
                              state.reexamRemaining,
                            ),
                          ),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDesignTokens.spacingMd),
                Text(l10n.studentPaymentTransactionIdLabel),
                const SizedBox(height: AppDesignTokens.spacingSm),
                ShamCashTransactionInput(
                  controller: _transactionController,
                  autofocus: true,
                  onChanged: context
                      .read<StudentCertificateWriteCubit>()
                      .persistReexamTransactionId,
                ),
                const SizedBox(height: AppDesignTokens.spacingLg),
                if (state.reexamRemaining > Duration.zero)
                  AppButton.primary(
                    label: l10n.studentCertificatesReexamPayCta,
                    isLoading: state.isSubmitting,
                    onPressed: state.isSubmitting
                        ? null
                        : () => context
                              .read<StudentCertificateWriteCubit>()
                              .submitReexamRequest(_transactionController.text),
                  )
                else
                  Text(
                    reexam.message ??
                        l10n.studentCertificatesRegistrationExpired,
                    textAlign: TextAlign.center,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
