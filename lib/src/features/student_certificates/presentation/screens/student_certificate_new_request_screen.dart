import 'dart:io';

import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_flow_back_button.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/services/student_certificate_write_validation_rules.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificate_write_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/formatters/student_certificates_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/mappers/student_certificate_write_failure_mapper.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/navigation/student_certificates_navigation.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/training_type.dart';
import 'package:qeyadah_mobile_app/src/shared/payments/sham_cash_transaction_input.dart';

class StudentCertificateNewRequestScreen extends StatefulWidget {
  const StudentCertificateNewRequestScreen({super.key});

  static const routePath = '/student/certificates/new';
  static const routeName = 'student-certificate-new';

  @override
  State<StudentCertificateNewRequestScreen> createState() =>
      _StudentCertificateNewRequestScreenState();
}

class _StudentCertificateNewRequestScreenState
    extends State<StudentCertificateNewRequestScreen> {
  final _transactionController = TextEditingController();
  final _picker = ImagePicker();
  TrainingType? _transmissionType;
  bool _transportRequested = false;
  File? _personalPhoto;
  File? _idFront;
  File? _idBack;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StudentCertificateWriteCubit>().initializeNewRequest();
    });
  }

  @override
  void dispose() {
    _transactionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(void Function(File) assign) async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked == null || !mounted) return;
    final file = File(picked.path);
    final validation = StudentCertificateWriteValidationRules.validateImage(
      file,
    );
    validation.fold(
      (failure) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            StudentCertificateWriteFailureMapper.messageFor(
              failure,
              AppLocalizations.of(context),
            ),
          ),
        ),
      ),
      (validFile) => setState(() => assign(validFile)),
    );
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
              SnackBar(content: Text(l10n.studentCertificatesNewSuccess)),
            );
            Navigator.of(context).pop(true);
          case StudentCertificateWriteConflict():
            StudentCertificatesNavigation.goHub(context: context);
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
          case StudentCertificateReexamNoLongerEligible():
            break;
        }
        context.read<StudentCertificateWriteCubit>().clearEffect();
      },
      builder: (context, state) => Scaffold(
        backgroundColor: AppColors.appCanvas,
        appBar: AppBar(
          title: Text(l10n.studentCertificatesNewTitle),
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
            final available = eligibility.newRequest.availableTransmissionTypes;
            if (!eligibility.newRequest.allowed || available.isEmpty) {
              return Center(
                child: Padding(
                  padding: AppDesignTokens.screenContentPadding(),
                  child: Text(
                    eligibility.newRequest.message ??
                        l10n.studentCertificatesStatusFallback,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            _transmissionType ??= available.first;
            if (!available.contains(_transmissionType)) {
              _transmissionType = available.first;
            }
            return ListView(
              padding: AppDesignTokens.screenContentPadding(),
              children: [
                Text(
                  eligibility.newRequest.message ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: AppDesignTokens.spacingMd),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.studentCertificatesTransmissionChoice,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: AppDesignTokens.spacingSm),
                      SegmentedButton<TrainingType>(
                        segments: available
                            .map(
                              (type) => ButtonSegment(
                                value: type,
                                label: Text(
                                  StudentCertificatesFormatters.transmissionTypeLabel(
                                    l10n,
                                    type,
                                  ),
                                ),
                              ),
                            )
                            .toList(growable: false),
                        selected: {_transmissionType!},
                        onSelectionChanged: (selection) =>
                            setState(() => _transmissionType = selection.first),
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(l10n.studentCertificatesTransportRequested),
                        value: _transportRequested,
                        onChanged: (value) =>
                            setState(() => _transportRequested = value),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDesignTokens.spacingMd),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.studentCertificatesImagesTitle,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: AppDesignTokens.spacingXs),
                      Text(
                        l10n.studentCertificatesImagesHint,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.muted,
                        ),
                      ),
                      const SizedBox(height: AppDesignTokens.spacingSm),
                      _ImagePickerTile(
                        label: l10n.studentCertificatesPersonalPhoto,
                        file: _personalPhoto,
                        onTap: () =>
                            _pickImage((file) => _personalPhoto = file),
                      ),
                      _ImagePickerTile(
                        label: l10n.studentCertificatesIdFront,
                        file: _idFront,
                        onTap: () => _pickImage((file) => _idFront = file),
                      ),
                      _ImagePickerTile(
                        label: l10n.studentCertificatesIdBack,
                        file: _idBack,
                        onTap: () => _pickImage((file) => _idBack = file),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDesignTokens.spacingMd),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.studentCertificatesFeeGuidance,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: AppDesignTokens.spacingMd),
                      Text(l10n.studentPaymentTransactionIdLabel),
                      const SizedBox(height: AppDesignTokens.spacingSm),
                      ShamCashTransactionInput(
                        controller: _transactionController,
                        onChanged: context
                            .read<StudentCertificateWriteCubit>()
                            .persistNewTransactionId,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDesignTokens.spacingLg),
                AppButton.primary(
                  label: l10n.studentCertificatesSubmitNew,
                  isLoading: state.isSubmitting,
                  onPressed:
                      state.isSubmitting ||
                          _personalPhoto == null ||
                          _idFront == null ||
                          _idBack == null
                      ? null
                      : () => context
                            .read<StudentCertificateWriteCubit>()
                            .submitNewRequest(
                              transmissionType: _transmissionType!,
                              transportRequested: _transportRequested,
                              rawTransactionId: _transactionController.text,
                              personalPhoto: _personalPhoto!,
                              idFront: _idFront!,
                              idBack: _idBack!,
                            ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ImagePickerTile extends StatelessWidget {
  const _ImagePickerTile({
    required this.label,
    required this.file,
    required this.onTap,
  });

  final String label;
  final File? file;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: file == null
          ? const Icon(Icons.add_photo_alternate_outlined)
          : ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                file!,
                width: 52,
                height: 52,
                fit: BoxFit.cover,
              ),
            ),
      title: Text(label),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
