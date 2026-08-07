import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/formatters/app_date_formatters.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_meta_row.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_metric_tile.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_section_heading.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_segmented_control.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_status_badge.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/invoices/cubit/instructor_invoices_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/shared/formatters/instructor_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/shared/widgets/instructor_load_more_button.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/shared/widgets/instructor_period_stepper.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/instructor_invoice_type.dart';

class InstructorInvoicesBody extends StatelessWidget {
  const InstructorInvoicesBody({
    super.key,
    required this.state,
    required this.page,
    this.interactive = true,
  });

  final InstructorInvoicesState state;
  final InstructorInvoicesPageEntity page;
  final bool interactive;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isDay = state.viewMode == InstructorInvoicesViewMode.day;
    final invoices = page.invoices;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(
            AppDesignTokens.screenHorizontalPadding,
            AppDesignTokens.screenHorizontalPadding,
            AppDesignTokens.screenHorizontalPadding,
            0,
          ),
          sliver: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppSegmentedControl<InstructorInvoicesViewMode>(
                  value: state.viewMode,
                  items: [
                    AppSegmentedItem(
                      value: InstructorInvoicesViewMode.day,
                      label: l10n.instructorPeriodDay,
                    ),
                    AppSegmentedItem(
                      value: InstructorInvoicesViewMode.month,
                      label: l10n.instructorPeriodMonth,
                    ),
                  ],
                  onChanged: interactive
                      ? context.read<InstructorInvoicesCubit>().setViewMode
                      : (_) {},
                ),
                const SizedBox(height: AppDesignTokens.spacingSm),
                Text(
                  isDay
                      ? l10n.instructorPeriodHintDay
                      : l10n.instructorPeriodHintMonth,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
                ),
                const SizedBox(height: AppDesignTokens.spacing),
                InstructorPeriodStepper(
                  isDay: isDay,
                  selectedDate: state.selectedDate,
                  interactive: interactive,
                  onPrevious: () => _stepPeriod(context, isDay, -1),
                  onNext: () => _stepPeriod(context, isDay, 1),
                  onPick: () => _pickPeriod(context, isDay),
                  onJumpCurrent: () => _jumpToCurrent(context, isDay),
                ),
                const SizedBox(height: AppDesignTokens.spacingMd),
                Row(
                  children: [
                    Expanded(
                      child: AppMetricTile(
                        value: InstructorFormatters.currencyAmount(
                          l10n,
                          page.totalReceived,
                        ),
                        label: l10n.instructorInvoicesTotalReceived,
                        icon: PhosphorIconsBold.money,
                      ),
                    ),
                    const SizedBox(width: AppDesignTokens.spacing),
                    Expanded(
                      child: AppMetricTile(
                        value: '${page.invoiceCount}',
                        label: l10n.instructorInvoicesCount,
                        icon: PhosphorIconsBold.receipt,
                      ),
                    ),
                    const SizedBox(width: AppDesignTokens.spacing),
                    Expanded(
                      child: AppMetricTile(
                        value: '${page.sessionCount}',
                        label: l10n.instructorInvoicesSessions,
                        icon: PhosphorIconsBold.calendarCheck,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDesignTokens.spacingLg),
                AppSectionHeading(title: l10n.instructorInvoicesListTitle),
                const SizedBox(height: AppDesignTokens.spacing),
                if (invoices.isEmpty)
                  AppCard(child: Text(l10n.instructorInvoicesEmpty)),
              ],
            ),
          ),
        ),
        if (invoices.isNotEmpty)
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
                  child: _InvoiceCard(invoice: invoices[index]),
                );
              }, childCount: invoices.length),
            ),
          ),
        if (invoices.isNotEmpty && page.hasMorePages)
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              AppDesignTokens.screenHorizontalPadding,
              0,
              AppDesignTokens.screenHorizontalPadding,
              AppDesignTokens.listEndPadding(
                safeBottom: MediaQuery.paddingOf(context).bottom,
              ),
            ),
            sliver: SliverToBoxAdapter(
              child: InstructorLoadMoreButton(
                isLoading: state.isLoadingMore,
                onPressed: interactive
                    ? () => context.read<InstructorInvoicesCubit>().loadMore()
                    : null,
              ),
            ),
          )
        else
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: AppDesignTokens.listEndPadding(
                safeBottom: MediaQuery.paddingOf(context).bottom,
              ),
            ),
          ),
      ],
    );
  }

  Future<void> _stepPeriod(BuildContext context, bool isDay, int delta) async {
    if (!interactive) return;
    final current = state.selectedDate;
    final next = isDay
        ? current.add(Duration(days: delta))
        : DateTime(current.year, current.month + delta);
    await context.read<InstructorInvoicesCubit>().selectDate(next);
  }

  Future<void> _jumpToCurrent(BuildContext context, bool isDay) async {
    if (!interactive) return;
    final now = DateTime.now();
    final target = isDay
        ? DateTime(now.year, now.month, now.day)
        : DateTime(now.year, now.month);
    await context.read<InstructorInvoicesCubit>().selectDate(target);
  }

  Future<void> _pickPeriod(BuildContext context, bool isDay) async {
    if (!interactive) return;
    final cubit = context.read<InstructorInvoicesCubit>();
    final selected = await pickInstructorPeriod(
      context: context,
      isDay: isDay,
      selectedDate: state.selectedDate,
    );
    if (selected == null) return;
    await cubit.selectDate(
      isDay ? selected : DateTime(selected.year, selected.month),
    );
  }
}

class _InvoiceCard extends StatelessWidget {
  const _InvoiceCard({required this.invoice});

  final InstructorInvoiceEntity invoice;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final textTheme = Theme.of(context).textTheme;
    final entryLabel = l10n.instructorInvoicesEntryCount(invoice.entryCount);
    final methodLabel = InstructorFormatters.paymentMethodLabel(
      l10n,
      invoice.paymentMethod,
    );
    final paidLabel = l10n.instructorInvoicesPaidAt(
      AppDateFormatters.dateTimeLabel(invoice.paidAt, localeName),
    );

    return AppCard(
      padding: const EdgeInsets.all(AppDesignTokens.spacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppStatusBadge(
                label: InstructorFormatters.invoiceTypeLabel(
                  l10n,
                  invoice.type,
                ),
                tone: InstructorFormatters.invoiceTypeTone(invoice.type),
                icon: invoice.type == InstructorInvoiceType.bonus
                    ? PhosphorIconsBold.gift
                    : PhosphorIconsBold.receipt,
              ),
              const Spacer(),
              Text(
                InstructorFormatters.currencyAmount(l10n, invoice.amount),
                style: textTheme.titleSmall?.copyWith(
                  color: AppColors.brandPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDesignTokens.spacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: AppMetaRow(
                  icon: PhosphorIconsBold.listBullets,
                  label: entryLabel,
                  iconSize: 14,
                  gap: 6,
                  labelColor: AppColors.muted,
                  expandLabel: false,
                  mainAxisSize: MainAxisSize.min,
                  labelStyle: textTheme.bodySmall?.copyWith(
                    color: AppColors.muted,
                  ),
                ),
              ),
              const SizedBox(width: AppDesignTokens.spacingSm),
              Flexible(
                child: AppMetaRow(
                  icon: PhosphorIconsBold.wallet,
                  label: methodLabel,
                  iconSize: 14,
                  gap: 6,
                  labelColor: AppColors.muted,
                  expandLabel: false,
                  mainAxisSize: MainAxisSize.min,
                  alignEnd: true,
                  labelStyle: textTheme.bodySmall?.copyWith(
                    color: AppColors.muted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDesignTokens.spacingSm),
          AppMetaRow(
            icon: PhosphorIconsBold.checkCircle,
            label: paidLabel,
            iconSize: 14,
            gap: 6,
            labelColor: AppColors.muted,
            expandLabel: false,
            mainAxisSize: MainAxisSize.min,
            iconColor: AppColors.success,
            labelStyle: textTheme.bodySmall?.copyWith(color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}
