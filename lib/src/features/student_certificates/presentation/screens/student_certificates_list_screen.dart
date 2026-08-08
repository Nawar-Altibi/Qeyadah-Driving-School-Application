import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_async_body.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_datetime_chips.dart';
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
        appBar: AppBar(
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
                builder: (context, state) => AppAsyncBody(
                  state: state.apiState,
                  builder: (context, page) =>
                      _CertificatesListBody(state: state, page: page),
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
    final colors = AppSemanticColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final items = page.items;

    return RefreshIndicator(
      onRefresh: () => context.read<StudentCertificatesListCubit>().refresh(),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppDesignTokens.screenHorizontalPadding,
              AppDesignTokens.spacingMd,
              AppDesignTokens.screenHorizontalPadding,
              0,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  DropdownButtonFormField<CertificateRequestStatus?>(
                    initialValue: state.selectedStatus,
                    dropdownColor: colors.card,
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: colors.ink,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.ink,
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      labelText: l10n.studentCertificatesFilterStatus,
                      labelStyle: textTheme.bodySmall?.copyWith(
                        color: colors.ink.withValues(alpha: 0.72),
                        fontWeight: FontWeight.w600,
                      ),
                      filled: true,
                      fillColor: colors.card,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppDesignTokens.spacingMd,
                        vertical: AppDesignTokens.spacing,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppDesignTokens.radiusControl,
                        ),
                        borderSide: BorderSide(
                          color: colors.muted.withValues(alpha: 0.35),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppDesignTokens.radiusControl,
                        ),
                        borderSide: BorderSide(
                          color: colors.muted.withValues(alpha: 0.35),
                        ),
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
                    onChanged: context
                        .read<StudentCertificatesListCubit>()
                        .setStatus,
                  ),
                  const SizedBox(height: AppDesignTokens.spacingMd),
                  if (items.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDesignTokens.spacingXl,
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: colors.brandSoft,
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
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(color: colors.muted, height: 1.45),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (items.isNotEmpty)
            SliverPadding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDesignTokens.screenHorizontalPadding,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      bottom: AppDesignTokens.spacingSm,
                    ),
                    child: _CertificateCard(item: items[index]),
                  );
                }, childCount: items.length),
              ),
            ),
          if (page.hasMorePages)
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(
                AppDesignTokens.screenHorizontalPadding,
                0,
                AppDesignTokens.screenHorizontalPadding,
                AppDesignTokens.screenBottomPadding,
              ),
              sliver: SliverToBoxAdapter(
                child: AppButton.secondary(
                  label: l10n.studentCertificatesLoadMore,
                  isLoading: state.isLoadingMore,
                  onPressed: context
                      .read<StudentCertificatesListCubit>()
                      .loadMore,
                ),
              ),
            )
          else
            const SliverPadding(
              padding: EdgeInsets.only(
                bottom: AppDesignTokens.screenBottomPadding,
              ),
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
    final colors = AppSemanticColors.of(context);
    final textTheme = Theme.of(context).textTheme;
    final localeName = Localizations.localeOf(context).toLanguageTag();
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusLg),
        onTap: () => StudentCertificatesNavigation.pushDetail(
          context: context,
          certificateId: item.id,
        ),
        child: AppCard(
          borderColor: colors.muted.withValues(alpha: 0.28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: AppColors.brandPrimary,
                      borderRadius: BorderRadius.circular(
                        AppDesignTokens.radiusMd,
                      ),
                    ),
                    child: const Icon(
                      PhosphorIconsBold.certificate,
                      size: 22,
                      color: AppColors.white,
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
                            color: colors.ink,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.studentCertificatesCategory(
                            item.category?.apiValue ?? '-',
                          ),
                          style: textTheme.bodyMedium?.copyWith(
                            color: colors.ink.withValues(alpha: 0.68),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppDesignTokens.spacing),
              AppStatusBadge(
                label: StudentCertificatesFormatters.requestStatusLabel(
                  l10n,
                  item.requestStatus,
                ),
                tone: StudentCertificatesFormatters.requestStatusTone(
                  item.requestStatus,
                ),
              ),
              if (item.courseNumber != null || item.requestedAt != null) ...[
                const SizedBox(height: AppDesignTokens.spacingMd),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    if (item.courseNumber != null)
                      AppInfoChip(
                        icon: PhosphorIconsBold.numberCircleOne,
                        label: l10n.studentCertificatesCourseNumber(
                          item.courseNumber!,
                        ),
                        iconColor: colors.primary,
                        backgroundColor: colors.neutralBg,
                      ),
                    if (item.requestedAt != null)
                      AppInfoChip(
                        icon: PhosphorIconsBold.calendarBlank,
                        label: StudentCertificatesFormatters.date(
                          item.requestedAt!,
                          localeName: localeName,
                        ),
                        iconColor: colors.primary,
                        backgroundColor: colors.brandSoft,
                      ),
                  ],
                ),
              ],
              const SizedBox(height: AppDesignTokens.spacingSm),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Icon(
                  PhosphorIconsBold.caretLeft,
                  size: 16,
                  color: colors.muted,
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
