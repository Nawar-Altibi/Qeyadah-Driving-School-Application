import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
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
    return ListView(
      padding: const EdgeInsets.all(AppDesignTokens.screenHorizontalPadding),
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
          isDay ? l10n.instructorPeriodHintDay : l10n.instructorPeriodHintMonth,
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
        if (page.invoices.isEmpty)
          AppCard(child: Text(l10n.instructorInvoicesEmpty))
        else ...[
          for (final invoice in page.invoices) ...[
            _InvoiceCard(invoice: invoice),
            const SizedBox(height: AppDesignTokens.spacingSm),
          ],
          if (page.hasMorePages)
            InstructorLoadMoreButton(
              isLoading: state.isLoadingMore,
              onPressed: interactive
                  ? () => context.read<InstructorInvoicesCubit>().loadMore()
                  : null,
            ),
        ],
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
      DateFormat.yMMMd(localeName).add_Hm().format(invoice.paidAt),
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
                child: _InvoiceMeta(
                  icon: PhosphorIconsBold.listBullets,
                  label: entryLabel,
                ),
              ),
              const SizedBox(width: AppDesignTokens.spacingSm),
              Flexible(
                child: _InvoiceMeta(
                  icon: PhosphorIconsBold.wallet,
                  label: methodLabel,
                  alignEnd: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDesignTokens.spacingSm),
          _InvoiceMeta(
            icon: PhosphorIconsBold.checkCircle,
            label: paidLabel,
            iconColor: AppColors.success,
          ),
        ],
      ),
    );
  }
}

class _InvoiceMeta extends StatelessWidget {
  const _InvoiceMeta({
    required this.icon,
    required this.label,
    this.iconColor = AppColors.muted,
    this.alignEnd = false,
  });

  final IconData icon;
  final String label;
  final Color iconColor;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: alignEnd
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      children: [
        Icon(icon, size: 14, color: iconColor),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            label,
            textAlign: alignEnd ? TextAlign.end : TextAlign.start,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
          ),
        ),
      ],
    );
  }
}
