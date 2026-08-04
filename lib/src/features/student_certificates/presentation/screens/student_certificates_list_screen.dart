import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
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
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificates_list_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/formatters/student_certificates_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/navigation/student_certificates_navigation.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/certificate_request_status.dart';

class StudentCertificatesListScreen extends StatelessWidget {
  const StudentCertificatesListScreen({super.key});

  static const String routePath = '/student/certificates/history';
  static const String routeName = 'student-certificates-history';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return StudentCertificatesListScreenCoordinator(
      child: Scaffold(
        backgroundColor: AppColors.appCanvas,
        appBar: AppBar(
          backgroundColor: AppColors.appCanvas,
          surfaceTintColor: Colors.transparent,
          title: Text(l10n.studentCertificatesHistoryTitle),
          centerTitle: true,
        ),
        body: ResponsiveShell(
          child:
              BlocBuilder<
                StudentCertificatesListCubit,
                StudentCertificatesListState
              >(
                builder: (context, state) => state.apiState.when(
                  initial: () =>
                      const Center(child: CircularProgressIndicator()),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  succeeded: (page) =>
                      _CertificatesListBody(state: state, page: page),
                  failed: (failure, retry) => _FailureView(
                    message: CoreFailureMessageMapper.messageFor(failure, l10n),
                    onRetry: retry,
                  ),
                ),
              ),
        ),
      ),
    );
  }
}

class _CertificatesListBody extends StatelessWidget {
  const _CertificatesListBody({required this.state, required this.page});

  final StudentCertificatesListState state;
  final StudentCertificatesPageEntity page;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return RefreshIndicator(
      onRefresh: () => context.read<StudentCertificatesListCubit>().refresh(),
      child: ListView(
        padding: AppDesignTokens.screenContentPadding(),
        children: [
          DropdownButtonFormField<CertificateRequestStatus?>(
            initialValue: state.selectedStatus,
            dropdownColor: AppColors.white,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.ink,
            ),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.ink,
              fontSize: 15,
            ),
            decoration: InputDecoration(
              labelText: l10n.studentCertificatesFilterStatus,
              filled: true,
              fillColor: AppColors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppDesignTokens.spacingMd,
                vertical: AppDesignTokens.spacing,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AppDesignTokens.radiusControl,
                ),
                borderSide: const BorderSide(color: AppColors.line),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AppDesignTokens.radiusControl,
                ),
                borderSide: const BorderSide(color: AppColors.line),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AppDesignTokens.radiusControl,
                ),
                borderSide: const BorderSide(
                  color: AppColors.brandPrimary,
                  width: 1.5,
                ),
              ),
            ),
            items: [
              DropdownMenuItem<CertificateRequestStatus?>(
                child: Text(l10n.studentCertificatesFilterAll),
              ),
              ...CertificateRequestStatus.values.map(
                (status) => DropdownMenuItem(
                  value: status,
                  child: Text(
                    StudentCertificatesFormatters.requestStatusLabel(
                      l10n,
                      status,
                    ),
                  ),
                ),
              ),
            ],
            onChanged: context.read<StudentCertificatesListCubit>().setStatus,
          ),
          const SizedBox(height: AppDesignTokens.spacingMd),
          if (page.items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppDesignTokens.spacingXl,
              ),
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: AppColors.brandMintSoft,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      PhosphorIconsBold.certificate,
                      color: AppColors.brandPrimary,
                      size: 26,
                    ),
                  ),
                  const SizedBox(height: AppDesignTokens.spacingMd),
                  Text(
                    l10n.studentCertificatesHistoryEmpty,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.muted,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            )
          else
            for (final item in page.items) ...[
              _CertificateCard(item: item),
              const SizedBox(height: AppDesignTokens.spacingSm),
            ],
          if (page.hasMorePages)
            AppButton.secondary(
              label: l10n.studentCertificatesLoadMore,
              isLoading: state.isLoadingMore,
              onPressed: context.read<StudentCertificatesListCubit>().loadMore,
            ),
        ],
      ),
    );
  }
}

class _CertificateCard extends StatelessWidget {
  const _CertificateCard({required this.item});

  final StudentCertificateListItemEntity item;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusLg),
        onTap: () => StudentCertificatesNavigation.pushDetail(
          context: context,
          certificateId: item.id,
        ),
        child: AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: const BoxDecoration(
                      color: AppColors.brandMintSoft,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      PhosphorIconsBold.certificate,
                      size: 20,
                      color: AppColors.brandPrimary,
                    ),
                  ),
                  const SizedBox(width: AppDesignTokens.spacing),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.studentCertificatesRequestId(item.id),
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.studentCertificatesCategory(
                            item.category?.apiValue ?? '-',
                          ),
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.muted,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppDesignTokens.spacingSm),
                  AppStatusBadge(
                    label: StudentCertificatesFormatters.requestStatusLabel(
                      l10n,
                      item.requestStatus,
                    ),
                  ),
                ],
              ),
              if (item.courseNumber != null || item.requestedAt != null) ...[
                const SizedBox(height: AppDesignTokens.spacingMd),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppDesignTokens.spacing),
                  decoration: BoxDecoration(
                    color: AppColors.neutralBg,
                    borderRadius: BorderRadius.circular(
                      AppDesignTokens.radiusMd,
                    ),
                  ),
                  child: Column(
                    children: [
                      if (item.courseNumber != null)
                        _HistoryMetaRow(
                          icon: PhosphorIconsBold.numberCircleOne,
                          text: l10n.studentCertificatesCourseNumber(
                            item.courseNumber!,
                          ),
                        ),
                      if (item.courseNumber != null && item.requestedAt != null)
                        const SizedBox(height: AppDesignTokens.spacingSm),
                      if (item.requestedAt != null)
                        _HistoryMetaRow(
                          icon: PhosphorIconsBold.calendarBlank,
                          text: l10n.studentCertificatesRequestedAt(
                            StudentCertificatesFormatters.date(
                              item.requestedAt!,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: AppDesignTokens.spacingSm),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Icon(
                  PhosphorIconsBold.caretLeft,
                  size: 16,
                  color: AppColors.muted.withValues(alpha: 0.7),
                  textDirection: TextDirection.ltr,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HistoryMetaRow extends StatelessWidget {
  const _HistoryMetaRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.muted),
        const SizedBox(width: AppDesignTokens.spacingSm),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.ink,
              fontSize: 13,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}

class _FailureView extends StatelessWidget {
  const _FailureView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: PaddingManager.paddingAll16,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: AppDesignTokens.spacingMd),
            AppButton.primary(
              label: AppLocalizations.of(context).retry,
              onPressed: onRetry,
            ),
          ],
        ),
      ),
    );
  }
}
