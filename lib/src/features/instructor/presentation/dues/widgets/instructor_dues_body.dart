import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_metric_tile.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_section_heading.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/dues/cubit/instructor_dues_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/shared/formatters/instructor_formatters.dart';

class InstructorDuesBody extends StatelessWidget {
  const InstructorDuesBody({super.key, required this.dues});

  final InstructorDuesEntity dues;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = AppSemanticColors.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();
    final sortOrder = context.select(
      (InstructorDuesCubit cubit) => cubit.state.sortOrder,
    );
    final fromCubit = context.select(
      (InstructorDuesCubit cubit) => cubit.state.visibleDues,
    );
    // Skeleton uses placeholder dues before the cubit has sorted visibleDues.
    final visibleDues = fromCubit.isNotEmpty || dues.dues.isEmpty
        ? fromCubit
        : InstructorDuesState.sortDues(dues.dues, sortOrder);

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
                AppMetricTile(
                  value: InstructorFormatters.currencyAmount(
                    l10n,
                    dues.grandTotal,
                  ),
                  label: l10n.instructorDuesGrandTotal,
                  icon: PhosphorIconsBold.wallet,
                  iconColor: colors.warning,
                ),
                const SizedBox(height: AppDesignTokens.spacingLg),
                AppSectionHeading(
                  title: l10n.instructorDuesDailyDetails,
                  trailing: IconButton(
                    tooltip: sortOrder == InstructorDuesSortOrder.newestFirst
                        ? l10n.studentBookingsSortOldestFirst
                        : l10n.studentBookingsSortNewestFirst,
                    onPressed: () =>
                        context.read<InstructorDuesCubit>().toggleSortOrder(),
                    style: IconButton.styleFrom(
                      backgroundColor: colors.card,
                      side: BorderSide(color: colors.line),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppDesignTokens.radiusControl,
                        ),
                      ),
                    ),
                    icon: Icon(
                      sortOrder == InstructorDuesSortOrder.newestFirst
                          ? PhosphorIconsBold.sortDescending
                          : PhosphorIconsBold.sortAscending,
                      color: colors.ink,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: AppDesignTokens.spacing),
                if (visibleDues.isEmpty)
                  AppCard(child: Text(l10n.instructorDuesEmpty)),
              ],
            ),
          ),
        ),
        if (visibleDues.isNotEmpty)
          SliverPadding(
            padding: EdgeInsets.fromLTRB(
              AppDesignTokens.screenHorizontalPadding,
              0,
              AppDesignTokens.screenHorizontalPadding,
              AppDesignTokens.listEndPadding(
                safeBottom: MediaQuery.paddingOf(context).bottom,
              ),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final due = visibleDues[index];
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: index < visibleDues.length - 1
                        ? AppDesignTokens.spacingSm
                        : 0,
                  ),
                  child: AppCard(
                    child: Row(
                      children: [
                        const AppNonMirroredIcon(
                          PhosphorIconsBold.calendar,
                          color: AppColors.brandPrimary,
                        ),
                        const SizedBox(width: AppDesignTokens.spacing),
                        Expanded(
                          child: Text(
                            DateFormat(
                              'EEEE، d MMMM',
                              localeName,
                            ).format(due.expenseDate),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              InstructorFormatters.currencyAmount(
                                l10n,
                                due.dayTotal,
                              ),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              l10n.instructorDuesLessonCount(due.lessonCount),
                              style: TextStyle(color: colors.muted),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: visibleDues.length),
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
}
