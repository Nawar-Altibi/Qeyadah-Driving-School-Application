import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_alert_banner.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_charge_tile.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_empty_state.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_full_screen_image_viewer.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_info_row.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_meta_row.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_status_badge.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/student_certificate_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/coordinators/student_certificates_read_coordinators.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificate_detail_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/formatters/student_certificates_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/navigation/student_certificates_navigation.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/exam_result.dart';

class StudentCertificateDetailScreen extends StatelessWidget {
  const StudentCertificateDetailScreen({
    required this.certificateId,
    super.key,
  });

  static const String routePath = '/student/certificates/:id';
  static const String routeName = 'student-certificate-detail';
  static String pathFor(String id) => '/student/certificates/$id';

  final String certificateId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return StudentCertificateDetailScreenCoordinator(
      certificateId: certificateId,
      child: Scaffold(
        backgroundColor: AppColors.appCanvas,
        appBar: AppBar(
          backgroundColor: AppColors.appCanvas,
          surfaceTintColor: Colors.transparent,
          title: Text(l10n.studentCertificatesDetailTitle),
          centerTitle: true,
        ),
        body: ResponsiveShell(
          child:
              BlocBuilder<
                StudentCertificateDetailCubit,
                StudentCertificateDetailState
              >(
                builder: (context, state) => state.apiState.when(
                  initial: () =>
                      const Center(child: CircularProgressIndicator()),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  succeeded: (detail) => _DetailBody(detail: detail),
                  failed: (failure, retry) => Center(
                    child: Padding(
                      padding: PaddingManager.paddingAll16,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            CoreFailureMessageMapper.messageFor(failure, l10n),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: AppDesignTokens.spacingMd),
                          AppButton.primary(
                            label: l10n.retry,
                            onPressed: retry,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
        ),
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.detail});

  final StudentCertificateDetailEntity detail;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final certificate = detail.certificate;
    final isBlocked =
        context.watch<AuthSessionCubit>().currentSession?.user.isBlocked ??
        false;
    final statusMessage = detail.actions.reexam.message;

    return RefreshIndicator(
      onRefresh: () => context.read<StudentCertificateDetailCubit>().refresh(),
      child: ListView(
        padding: AppDesignTokens.screenContentPadding(),
        children: [
          AppCard(
            padding: const EdgeInsets.all(AppDesignTokens.spacingLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        l10n.studentCertificatesRequestId(certificate.id),
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                          height: 1.3,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDesignTokens.spacingSm),
                    AppStatusBadge(
                      label: StudentCertificatesFormatters.requestStatusLabel(
                        l10n,
                        certificate.requestStatus,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDesignTokens.spacingMd),
                AppInfoRow.stacked(
                  icon: PhosphorIconsBold.user,
                  label: l10n.studentCertificatesStudentLabel,
                  value: detail.student.name,
                ),
                const SizedBox(height: AppDesignTokens.spacingSm),
                AppInfoRow.stacked(
                  icon: PhosphorIconsBold.identificationBadge,
                  label: l10n.studentCertificatesCategoryLabel,
                  value: certificate.category?.apiValue ?? '—',
                ),
                const SizedBox(height: AppDesignTokens.spacingSm),
                AppInfoRow.stacked(
                  icon: PhosphorIconsBold.car,
                  label: l10n.studentCertificatesTransmissionLabel,
                  value: certificate.transmissionType == null
                      ? '—'
                      : StudentCertificatesFormatters.transmissionTypeLabel(
                          l10n,
                          certificate.transmissionType!,
                        ),
                ),
                if (certificate.courseNumber != null) ...[
                  const SizedBox(height: AppDesignTokens.spacingSm),
                  AppInfoRow.stacked(
                    icon: PhosphorIconsBold.numberCircleOne,
                    label: l10n.studentCertificatesCourseLabel,
                    value: '${certificate.courseNumber}',
                  ),
                ],
              ],
            ),
          ),
          if (statusMessage != null && statusMessage.isNotEmpty) ...[
            const SizedBox(height: AppDesignTokens.spacingMd),
            AppAlertBanner(
              title: l10n.studentCertificatesStatusTitle,
              message: statusMessage,
              tone: AppAlertTone.info,
              icon: PhosphorIconsBold.info,
            ),
          ],
          _Section(
            title: l10n.studentCertificatesDocumentsTitle,
            icon: PhosphorIconsBold.files,
            children: [
              _DocumentTile(
                icon: PhosphorIconsBold.camera,
                label: l10n.studentCertificatesPersonalPhoto,
                url: detail.documents.personalPhotoUrl,
              ),
              _DocumentTile(
                icon: PhosphorIconsBold.identificationCard,
                label: l10n.studentCertificatesIdFront,
                url: detail.documents.idFrontUrl,
              ),
              _DocumentTile(
                icon: PhosphorIconsBold.identificationCard,
                label: l10n.studentCertificatesIdBack,
                url: detail.documents.idBackUrl,
              ),
            ],
          ),
          _Section(
            title: l10n.studentCertificatesSessionsTitle,
            icon: PhosphorIconsBold.steeringWheel,
            empty: detail.sessions.isEmpty,
            children: detail.sessions
                .map(
                  (session) => AppMetaTile(
                    title: l10n.studentCertificatesSessionNumber(
                      session.sessionNumber,
                    ),
                    subtitle: session.label,
                    icon: PhosphorIconsBold.calendarBlank,
                  ),
                )
                .toList(),
          ),
          _Section(
            title: l10n.studentCertificatesExamsTitle,
            icon: PhosphorIconsBold.exam,
            empty: detail.exams.isEmpty,
            children: detail.exams
                .map(
                  (exam) => AppMetaTile(
                    title: StudentCertificatesFormatters.examTypeLabel(
                      l10n,
                      exam.examType,
                    ),
                    subtitle: exam.scheduledAt == null
                        ? l10n.studentCertificatesNotScheduled
                        : StudentCertificatesFormatters.dateTime(
                            exam.scheduledAt!,
                          ),
                    icon: PhosphorIconsBold.clipboardText,
                    trailing: exam.examResult == null
                        ? null
                        : AppStatusBadge(
                            label: _examResultLabel(l10n, exam.examResult!),
                          ),
                  ),
                )
                .toList(),
          ),
          _Section(
            title: l10n.studentCertificatesChargesTitle,
            icon: PhosphorIconsBold.wallet,
            empty: detail.charges.isEmpty,
            children: detail.charges
                .map(
                  (charge) => Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppDesignTokens.spacingSm,
                    ),
                    child: AppChargeTile(
                      title: StudentCertificatesFormatters.chargeReasonLabel(
                        l10n,
                        charge.chargeReason,
                      ),
                      statusLabel:
                          StudentCertificatesFormatters.chargeStatusLabel(
                            l10n,
                            charge.chargeStatus,
                          ),
                      statusTone: AppBadgeTone.neutral,
                      amountLabel: l10n.studentCertificatesAmountDue(
                        StudentCertificatesFormatters.moneyAmount(
                          charge.amountDue,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          if (detail.actions.reexam.eligible && !isBlocked) ...[
            const SizedBox(height: AppDesignTokens.spacingMd),
            AppButton.primary(
              label: l10n.studentCertificatesReexamCta,
              onPressed: () => StudentCertificatesNavigation.pushReexam(
                context: context,
                certificateId: certificate.id,
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _examResultLabel(AppLocalizations l10n, ExamResult result) {
    return switch (result) {
      ExamResult.pass => l10n.studentCertificatesExamResultPass,
      ExamResult.fail => l10n.studentCertificatesExamResultFail,
      ExamResult.absent => l10n.studentCertificatesExamResultAbsent,
    };
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.icon,
    required this.children,
    this.empty = false,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;
  final bool empty;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(top: AppDesignTokens.spacingMd),
      child: AppCard(
        padding: const EdgeInsets.all(AppDesignTokens.spacingLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: AppColors.brandPrimary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDesignTokens.spacingMd),
            if (empty)
              AppEmptyState.inline(
                title: l10n.studentCertificatesSectionEmpty,
                message: l10n.studentCertificatesSectionEmptyHint,
              )
            else
              ...children,
          ],
        ),
      ),
    );
  }
}

class _DocumentTile extends StatelessWidget {
  const _DocumentTile({
    required this.icon,
    required this.label,
    required this.url,
  });

  final IconData icon;
  final String label;
  final String? url;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final enabled = url != null && url!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppDesignTokens.spacingSm),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled
              ? () {
                  AppFullScreenImageViewer.open(
                    context,
                    imageUrl: url!,
                    title: label,
                  );
                }
              : null,
          borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(
                AppDesignTokens.radiusControl,
              ),
              border: Border.all(color: AppColors.line.withValues(alpha: 0.9)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.brandMintSoft,
                      borderRadius: BorderRadius.circular(
                        AppDesignTokens.radiusControl,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Icon(icon, size: 18, color: AppColors.brandPrimary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.5,
                          ),
                        ),
                        if (!enabled) ...[
                          const SizedBox(height: 2),
                          Text(
                            l10n.studentCertificatesDocumentUnavailable,
                            style: textTheme.bodySmall?.copyWith(
                              color: AppColors.muted,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (enabled)
                    const Icon(
                      PhosphorIconsBold.caretLeft,
                      size: 16,
                      color: AppColors.muted,
                      textDirection: TextDirection.ltr,
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
