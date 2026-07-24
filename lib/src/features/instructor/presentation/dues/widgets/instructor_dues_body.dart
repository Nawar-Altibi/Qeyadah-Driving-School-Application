import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_section_heading.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/shared/formatters/instructor_formatters.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/shared/widgets/instructor_empty_state.dart';

class InstructorDuesBody extends StatelessWidget {
  const InstructorDuesBody({super.key, required this.dues});

  final InstructorDuesEntity dues;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final localeName = Localizations.localeOf(context).toLanguageTag();
    return ListView(
      padding: const EdgeInsets.all(AppDesignTokens.screenHorizontalPadding),
      children: [
        _DuesHeroTotal(
          amountLabel: InstructorFormatters.currencyAmount(
            l10n,
            dues.grandTotal,
          ),
          caption: l10n.instructorDuesGrandTotal,
        ),
        const SizedBox(height: AppDesignTokens.spacingLg),
        AppSectionHeading(title: l10n.instructorDuesDailyDetails),
        const SizedBox(height: AppDesignTokens.spacing),
        if (dues.dues.isEmpty)
          InstructorEmptyState(
            message: l10n.instructorDuesEmpty,
            icon: PhosphorIconsBold.wallet,
          )
        else
          for (final due in dues.dues) ...[
            _DueDayCard(due: due, localeName: localeName),
            const SizedBox(height: AppDesignTokens.spacingSm),
          ],
      ],
    );
  }
}

class _DuesHeroTotal extends StatelessWidget {
  const _DuesHeroTotal({required this.amountLabel, required this.caption});

  final String amountLabel;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            AppColors.warning.withValues(alpha: 0.95),
            const Color(0xFFB7791F),
          ],
        ),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusLg),
        boxShadow: [
          BoxShadow(
            color: AppColors.warning.withValues(alpha: 0.22),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDesignTokens.spacingLg),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                PhosphorIconsBold.wallet,
                color: AppColors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: AppDesignTokens.spacingMd),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    caption,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.white.withValues(alpha: 0.82),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    amountLabel,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DueDayCard extends StatelessWidget {
  const _DueDayCard({required this.due, required this.localeName});

  final InstructorDueDayEntity due;
  final String localeName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppCard(
      padding: EdgeInsets.zero,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 4,
              decoration: const BoxDecoration(
                color: AppColors.warning,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(AppDesignTokens.radiusLg),
                  bottomStart: Radius.circular(AppDesignTokens.radiusLg),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDesignTokens.spacingMd,
                  vertical: AppDesignTokens.spacing,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: AppColors.warningBg,
                        shape: BoxShape.circle,
                      ),
                      child: const AppNonMirroredIcon(
                        PhosphorIconsBold.calendar,
                        color: AppColors.warning,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: AppDesignTokens.spacing),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat(
                              'EEEE، d MMMM',
                              localeName,
                            ).format(due.expenseDate),
                            style: Theme.of(context).textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            l10n.instructorDuesLessonCount(due.lessonCount),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: AppColors.muted),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      InstructorFormatters.currencyAmount(l10n, due.dayTotal),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.warning,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
