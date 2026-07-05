import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/entities/student_home_dashboard_entity.dart';

class StudentHomeTrainingProgressCard extends StatelessWidget {
  const StudentHomeTrainingProgressCard({
    super.key,
    required this.progress,
  });

  final StudentHomeTrainingProgressEntity progress;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AppCard(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.studentHomeTrainingProgress,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.muted,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      l10n.studentHomeTrainingProgressDetail(
                        progress.completedHours,
                        progress.totalHours,
                      ),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${progress.progressPercent}%',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: AppColors.brandPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 11),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: progress.progressPercent / 100,
              minHeight: 7,
              backgroundColor: const Color(0xFFE7ECE9),
              color: AppColors.brandPrimary,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            l10n.studentHomeTrainingProgressFootnote,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.muted,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
