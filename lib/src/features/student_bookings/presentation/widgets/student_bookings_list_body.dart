import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/paginated_scroll_controller.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/entities/student_bookings_entities.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/cubit/student_bookings_list_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/navigation/student_bookings_navigation.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/widgets/student_bookings_list_item_card.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/widgets/student_bookings_search_field.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/widgets/student_bookings_status_filter.dart';

class StudentBookingsListBody extends StatefulWidget {
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
  State<StudentBookingsListBody> createState() =>
      _StudentBookingsListBodyState();
}

class _StudentBookingsListBodyState extends State<StudentBookingsListBody> {
  late final PaginatedScrollController _scrollController =
      PaginatedScrollController(onLoadMore: _onLoadMore);

  void _onLoadMore() {
    if (!widget.interactive || !mounted) return;
    context.read<StudentBookingsListCubit>().loadMore();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = widget.state.sortOrder == StudentBookingsSortOrder.oldestFirst
        ? widget.page.items.reversed.toList()
        : widget.page.items;

    final list = ListView(
      controller: widget.interactive ? _scrollController : null,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: AppDesignTokens.screenContentPadding(
        extraBottom: AppDesignTokens.bottomNavHeight,
      ),
      children: [
        if (items.isEmpty)
          _EmptyState(l10n: l10n)
        else ...[
          for (final item in items) ...[
            StudentBookingsListItemCard(
              item: item,
              onTap: widget.interactive
                  ? () => StudentBookingsNavigation.pushDetail(
                      context: context,
                      bookingId: int.tryParse(item.id) ?? 0,
                    )
                  : null,
            ),
            const SizedBox(height: AppDesignTokens.spacingSm),
          ],
          if (widget.state.isLoadingMore) ...[
            const SizedBox(height: AppDesignTokens.spacingSm),
            const Center(
              child: Padding(
                padding: EdgeInsets.all(AppDesignTokens.spacingMd),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2.5),
                ),
              ),
            ),
          ],
        ],
      ],
    );

    if (!widget.interactive) return list;

    return RefreshIndicator(
      onRefresh: () => context.read<StudentBookingsListCubit>().refresh(),
      child: list,
    );
  }
}

/// Sticky header: search, sort toggle, and status filters.
/// Kept outside [apiState.when] so the search field is not disposed on reload.
class StudentBookingsListFiltersHeader extends StatelessWidget {
  const StudentBookingsListFiltersHeader({
    super.key,
    required this.state,
    this.interactive = true,
  });

  final StudentBookingsListState state;
  final bool interactive;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cubit = context.read<StudentBookingsListCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppDesignTokens.screenHorizontalPadding,
            AppDesignTokens.spacingMd,
            AppDesignTokens.screenHorizontalPadding,
            0,
          ),
          child: Row(
            children: [
              Expanded(
                child: StudentBookingsSearchField(
                  initialValue: state.searchQuery,
                  interactive: interactive,
                  onChanged: interactive ? cubit.setSearchQuery : (_) {},
                ),
              ),
              const SizedBox(width: AppDesignTokens.spacingSm),
              IconButton(
                tooltip: state.sortOrder == StudentBookingsSortOrder.newestFirst
                    ? l10n.studentBookingsSortOldestFirst
                    : l10n.studentBookingsSortNewestFirst,
                onPressed: interactive ? cubit.toggleSortOrder : null,
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.white,
                  side: const BorderSide(color: AppColors.line),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppDesignTokens.radiusControl,
                    ),
                  ),
                ),
                icon: Icon(
                  state.sortOrder == StudentBookingsSortOrder.newestFirst
                      ? PhosphorIconsBold.sortDescending
                      : PhosphorIconsBold.sortAscending,
                  color: AppColors.ink,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDesignTokens.spacing),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDesignTokens.screenHorizontalPadding,
          ),
          child: StudentBookingsStatusFilter(
            selected: state.selectedStatus,
            interactive: interactive,
            onChanged: interactive ? cubit.setStatusFilter : (_) {},
          ),
        ),
        if (state.isRefreshing)
          const Padding(
            padding: EdgeInsets.only(top: AppDesignTokens.spacingSm),
            child: LinearProgressIndicator(minHeight: 2),
          )
        else
          const SizedBox(height: AppDesignTokens.spacingSm),
      ],
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
