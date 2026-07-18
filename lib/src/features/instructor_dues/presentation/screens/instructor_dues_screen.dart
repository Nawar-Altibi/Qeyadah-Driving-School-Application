import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_metric_tile.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_section_heading.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_dues/presentation/cubit/instructor_dues_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/formatters/instructor_formatters.dart';

class InstructorDuesScreen extends StatefulWidget {
  const InstructorDuesScreen({super.key});

  static const routePath = '/instructor/dues';
  static const routeName = 'instructor-dues';

  @override
  State<InstructorDuesScreen> createState() => _InstructorDuesScreenState();
}

class _InstructorDuesScreenState extends State<InstructorDuesScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InstructorDuesCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: AppColors.appCanvas,
      appBar: AppBar(title: Text(l10n.instructorDuesTitle)),
      body: BlocBuilder<InstructorDuesCubit, InstructorDuesState>(
        builder: (context, state) => state.apiState.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const Center(child: CircularProgressIndicator()),
          succeeded: (dues) => _DuesBody(dues: dues),
          failed: (failure, retry) => Center(
            child: AppButton.primary(
              label: CoreFailureMessageMapper.messageFor(failure, l10n),
              onPressed: retry,
            ),
          ),
        ),
      ),
    );
  }
}

class _DuesBody extends StatelessWidget {
  const _DuesBody({required this.dues});

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
                  const Icon(
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
