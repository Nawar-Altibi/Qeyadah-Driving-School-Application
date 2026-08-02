import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_status_badge.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/entities/student_certificate_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/coordinators/student_certificates_read_coordinators.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificate_detail_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/formatters/student_certificates_formatters.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/exam_result.dart';
import 'package:url_launcher/url_launcher.dart';

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
    final certificate = detail.certificate;
    return RefreshIndicator(
      onRefresh: () => context.read<StudentCertificateDetailCubit>().refresh(),
      child: ListView(
        padding: const EdgeInsets.all(AppDesignTokens.spacingMd),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        l10n.studentCertificatesRequestId(certificate.id),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    AppStatusBadge(
                      label: StudentCertificatesFormatters.requestStatusLabel(
                        l10n,
                        certificate.requestStatus,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDesignTokens.spacingSm),
                Text(l10n.studentCertificatesStudentName(detail.student.name)),
                Text(
                  l10n.studentCertificatesCategory(
                    certificate.category?.apiValue ?? '-',
                  ),
                ),
                Text(
                  l10n.studentCertificatesTransmission(
                    certificate.transmissionType == null
                        ? '-'
                        : StudentCertificatesFormatters.transmissionTypeLabel(
                            l10n,
                            certificate.transmissionType!,
                          ),
                  ),
                ),
                if (certificate.courseNumber != null)
                  Text(
                    l10n.studentCertificatesCourseNumber(
                      certificate.courseNumber!,
                    ),
                  ),
              ],
            ),
          ),
          _Section(
            title: l10n.studentCertificatesDocumentsTitle,
            children: [
              _DocumentButton(
                label: l10n.studentCertificatesPersonalPhoto,
                url: detail.documents.personalPhotoUrl,
              ),
              _DocumentButton(
                label: l10n.studentCertificatesIdFront,
                url: detail.documents.idFrontUrl,
              ),
              _DocumentButton(
                label: l10n.studentCertificatesIdBack,
                url: detail.documents.idBackUrl,
              ),
            ],
          ),
          _Section(
            title: l10n.studentCertificatesSessionsTitle,
            empty: detail.sessions.isEmpty,
            children: detail.sessions
                .map(
                  (session) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      l10n.studentCertificatesSessionNumber(
                        session.sessionNumber,
                      ),
                    ),
                    subtitle: Text(session.label),
                  ),
                )
                .toList(),
          ),
          _Section(
            title: l10n.studentCertificatesExamsTitle,
            empty: detail.exams.isEmpty,
            children: detail.exams
                .map(
                  (exam) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      StudentCertificatesFormatters.examTypeLabel(
                        l10n,
                        exam.examType,
                      ),
                    ),
                    subtitle: Text(
                      exam.scheduledAt == null
                          ? l10n.studentCertificatesNotScheduled
                          : StudentCertificatesFormatters.dateTime(
                              exam.scheduledAt!,
                            ),
                    ),
                    trailing: exam.examResult == null
                        ? null
                        : Text(_examResultLabel(l10n, exam.examResult!)),
                  ),
                )
                .toList(),
          ),
          _Section(
            title: l10n.studentCertificatesChargesTitle,
            empty: detail.charges.isEmpty,
            children: detail.charges
                .map(
                  (charge) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      l10n.studentCertificatesAmountDue(charge.amountDue),
                    ),
                    subtitle: Text(
                      charge.chargeReason?.apiValue ??
                          charge.chargeStatus.apiValue,
                    ),
                  ),
                )
                .toList(),
          ),
          if (detail.actions.reexam.message?.isNotEmpty ?? false)
            Padding(
              padding: const EdgeInsets.only(top: AppDesignTokens.spacingMd),
              child: Text(detail.actions.reexam.message!),
            ),
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
    required this.children,
    this.empty = false,
  });

  final String title;
  final List<Widget> children;
  final bool empty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDesignTokens.spacingMd),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: AppDesignTokens.spacingSm),
            if (empty)
              Text(AppLocalizations.of(context).studentCertificatesSectionEmpty)
            else
              ...children,
          ],
        ),
      ),
    );
  }
}

class _DocumentButton extends StatelessWidget {
  const _DocumentButton({required this.label, required this.url});

  final String label;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDesignTokens.spacingSm),
      child: AppButton.secondary(
        label: label,
        onPressed: url == null
            ? null
            : () async {
                await launchUrl(
                  Uri.parse(url!),
                  mode: LaunchMode.externalApplication,
                );
              },
      ),
    );
  }
}
