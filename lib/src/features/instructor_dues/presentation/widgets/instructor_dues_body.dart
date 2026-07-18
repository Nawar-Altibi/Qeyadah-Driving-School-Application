import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_metric_tile.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_section_heading.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/formatters/instructor_formatters.dart';

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
        AppMetricTile(
          value: InstructorFormatters.currencyAmount(l10n, dues.grandTotal),
          label: l10n.instructorDuesGrandTotal,
          icon: PhosphorIconsBold.wallet,
          iconColor: AppColors.warning,
        ),
        const SizedBox(height: AppDesignTokens.spacingLg),
        AppSectionHeading(title: l10n.instructorDuesDailyDetails),
        const SizedBox(height: AppDesignTokens.spacing),
        if (dues.dues.isEmpty)
          AppCard(child: Text(l10n.instructorDuesEmpty))
        else
          for (final due in dues.dues) ...[
            AppCard(
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
                        InstructorFormatters.currencyAmount(l10n, due.dayTotal),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      Text(
                        l10n.instructorDuesLessonCount(due.lessonCount),
                        style: const TextStyle(color: AppColors.muted),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppDesignTokens.spacingSm),
          ],
      ],
    );
  }
}
