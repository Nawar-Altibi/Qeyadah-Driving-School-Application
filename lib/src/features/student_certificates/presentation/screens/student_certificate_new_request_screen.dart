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
  final _transmissionNotifier = ValueNotifier<_TransmissionChoice?>(null);
  final _photosNotifier = ValueNotifier<_CertificatePhotos>(
    const _CertificatePhotos(),
  );

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
    _transmissionNotifier.dispose();
    _photosNotifier.dispose();
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
            return ListView(
              padding: AppDesignTokens.screenContentPadding(),
              children: [
                Text(
                  eligibility.newRequest.message ?? '',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: AppDesignTokens.spacingMd),
                _TransmissionOptionsCard(
                  available: available,
                  notifier: _transmissionNotifier,
                ),
                const SizedBox(height: AppDesignTokens.spacingMd),
                _CertificateImagesCard(notifier: _photosNotifier),
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
                ListenableBuilder(
                  listenable: Listenable.merge([
                    _transmissionNotifier,
                    _photosNotifier,
                  ]),
                  builder: (context, _) {
                    final choice = _transmissionNotifier.value;
                    final photos = _photosNotifier.value;
                    final canSubmit =
                        !state.isSubmitting &&
                        choice != null &&
                        photos.personalPhoto != null &&
                        photos.idFront != null &&
                        photos.idBack != null;
                    return AppButton.primary(
                      label: l10n.studentCertificatesSubmitNew,
                      isLoading: state.isSubmitting,
                      onPressed: !canSubmit
                          ? null
                          : () => context
                                .read<StudentCertificateWriteCubit>()
                                .submitNewRequest(
                                  transmissionType: choice.transmissionType,
                                  transportRequested: choice.transportRequested,
                                  rawTransactionId: _transactionController.text,
                                  personalPhoto: photos.personalPhoto!,
                                  idFront: photos.idFront!,
                                  idBack: photos.idBack!,
                                ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TransmissionChoice {
  const _TransmissionChoice({
    required this.transmissionType,
    required this.transportRequested,
  });

  final TrainingType transmissionType;
  final bool transportRequested;
}

class _CertificatePhotos {
  const _CertificatePhotos({this.personalPhoto, this.idFront, this.idBack});

  final File? personalPhoto;
  final File? idFront;
  final File? idBack;

  _CertificatePhotos copyWith({
    File? personalPhoto,
    File? idFront,
    File? idBack,
  }) => _CertificatePhotos(
    personalPhoto: personalPhoto ?? this.personalPhoto,
    idFront: idFront ?? this.idFront,
    idBack: idBack ?? this.idBack,
  );
}

class _TransmissionOptionsCard extends StatefulWidget {
  const _TransmissionOptionsCard({
    required this.available,
    required this.notifier,
  });

  final List<TrainingType> available;
  final ValueNotifier<_TransmissionChoice?> notifier;

  @override
  State<_TransmissionOptionsCard> createState() =>
      _TransmissionOptionsCardState();
}

class _TransmissionOptionsCardState extends State<_TransmissionOptionsCard> {
  late TrainingType _transmissionType;
  bool _transportRequested = false;

  @override
  void initState() {
    super.initState();
    _transmissionType = widget.available.first;
    _syncNotifier();
  }

  @override
  void didUpdateWidget(covariant _TransmissionOptionsCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!widget.available.contains(_transmissionType)) {
      _transmissionType = widget.available.first;
      _syncNotifier();
    }
  }

  void _syncNotifier() {
    widget.notifier.value = _TransmissionChoice(
      transmissionType: _transmissionType,
      transportRequested: _transportRequested,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.studentCertificatesTransmissionChoice,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppDesignTokens.spacingSm),
          SegmentedButton<TrainingType>(
            segments: widget.available
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
            selected: {_transmissionType},
            onSelectionChanged: (selection) {
              setState(() => _transmissionType = selection.first);
              _syncNotifier();
            },
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.studentCertificatesTransportRequested),
            value: _transportRequested,
            onChanged: (value) {
              setState(() => _transportRequested = value);
              _syncNotifier();
            },
          ),
        ],
      ),
    );
  }
}

class _CertificateImagesCard extends StatefulWidget {
  const _CertificateImagesCard({required this.notifier});

  final ValueNotifier<_CertificatePhotos> notifier;

  @override
  State<_CertificateImagesCard> createState() => _CertificateImagesCardState();
}

class _CertificateImagesCardState extends State<_CertificateImagesCard> {
  final _picker = ImagePicker();

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
      (validFile) {
        assign(validFile);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final photos = widget.notifier.value;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.studentCertificatesImagesTitle,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: AppDesignTokens.spacingXs),
          Text(
            l10n.studentCertificatesImagesHint,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.muted),
          ),
          const SizedBox(height: AppDesignTokens.spacingSm),
          _ImagePickerTile(
            label: l10n.studentCertificatesPersonalPhoto,
            file: photos.personalPhoto,
            onTap: () => _pickImage((file) {
              widget.notifier.value = widget.notifier.value.copyWith(
                personalPhoto: file,
              );
            }),
          ),
          _ImagePickerTile(
            label: l10n.studentCertificatesIdFront,
            file: photos.idFront,
            onTap: () => _pickImage((file) {
              widget.notifier.value = widget.notifier.value.copyWith(
                idFront: file,
              );
            }),
          ),
          _ImagePickerTile(
            label: l10n.studentCertificatesIdBack,
            file: photos.idBack,
            onTap: () => _pickImage((file) {
              widget.notifier.value = widget.notifier.value.copyWith(
                idBack: file,
              );
            }),
          ),
        ],
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
