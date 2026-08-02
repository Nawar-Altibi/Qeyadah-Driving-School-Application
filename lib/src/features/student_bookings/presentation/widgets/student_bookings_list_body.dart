import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/shared/widgets/instructor_load_more_button.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/cubit/student_bookings_list_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/navigation/student_bookings_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/widgets/student_bookings_list_item_card.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/widgets/student_bookings_search_field.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/widgets/student_bookings_status_filter.dart';

class StudentBookingsListBody extends StatelessWidget {
  const StudentBookingsListBody({
    super.key,
    required this.state,
    required this.page,
    this.interactive = true,
  });

  final StudentBookingsListState state;
  final StudentBookingsPageEntity page;
  final bool interactive;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final list = ListView(
      padding: const EdgeInsets.all(AppDesignTokens.screenHorizontalPadding),
      children: [
        StudentBookingsSearchField(
          initialValue: state.searchQuery,
          interactive: interactive,
          onChanged: interactive
              ? context.read<StudentBookingsListCubit>().setSearchQuery
              : (_) {},
        ),
        const SizedBox(height: AppDesignTokens.spacing),
        StudentBookingsStatusFilter(
          selected: state.selectedStatus,
          interactive: interactive,
          onChanged: interactive
              ? context.read<StudentBookingsListCubit>().setStatusFilter
              : (_) {},
        ),
        const SizedBox(height: AppDesignTokens.spacingMd),
        if (page.items.isEmpty)
          _EmptyState(l10n: l10n)
        else ...[
          for (final item in page.items) ...[
            StudentBookingsListItemCard(
              item: item,
              onTap: interactive
                  ? () => StudentBookingsNavigation.pushDetail(
                      context: context,
                      bookingId: int.tryParse(item.id) ?? 0,
                    )
                  : null,
            ),
            const SizedBox(height: AppDesignTokens.spacingSm),
          ],
          if (page.hasMorePages)
            InstructorLoadMoreButton(
              isLoading: state.isLoadingMore,
              onPressed: interactive
                  ? () => context.read<StudentBookingsListCubit>().loadMore()
                  : null,
            ),
        ],
      ],
    );

    if (!interactive) return list;

    return RefreshIndicator(
      onRefresh: () => context.read<StudentBookingsListCubit>().refresh(),
      child: list,
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          const Icon(
            PhosphorIconsBold.calendarX,
            size: 32,
            color: AppColors.muted,
          ),
          const SizedBox(height: AppDesignTokens.spacingSm),
          Text(
            l10n.studentBookingsEmptyTitle,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            l10n.studentBookingsEmptyMessage,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: AppColors.muted),
          ),
        ],
      ),
    );
  }
}
