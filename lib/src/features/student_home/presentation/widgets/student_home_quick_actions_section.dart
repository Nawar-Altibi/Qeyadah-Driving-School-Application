import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_quick_action_tile.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_section_heading.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/domain/entities/student_home_dashboard_entity.dart';

class StudentHomeQuickActionsSection extends StatelessWidget {
  const StudentHomeQuickActionsSection({
    super.key,
    required this.actions,
    required this.onActionTap,
    this.onViewAllTap,
  });

  final List<StudentHomeQuickActionType> actions;
  final ValueChanged<StudentHomeQuickActionType> onActionTap;
  final VoidCallback? onViewAllTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppSectionHeading(
          title: l10n.studentHomeQuickActions,
          trailing: TextButton(
            onPressed: onViewAllTap,
            child: Text(l10n.studentHomeViewAll),
          ),
        ),
        const SizedBox(height: AppDesignTokens.spacing),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.55,
          children: [
            for (final action in actions)
              AppQuickActionTile(
                label: _labelForAction(l10n, action),
                icon: _iconForAction(action),
                onTap: () => onActionTap(action),
              ),
          ],
        ),
      ],
    );
  }

  String _labelForAction(
    AppLocalizations l10n,
    StudentHomeQuickActionType action,
  ) {
    return switch (action) {
      StudentHomeQuickActionType.newBooking => l10n.studentHomeNewBooking,
      StudentHomeQuickActionType.myBookings => l10n.studentHomeMyBookings,
      StudentHomeQuickActionType.certificateRequest =>
        l10n.studentHomeCertificateRequest,
      StudentHomeQuickActionType.theorySimulation =>
        l10n.studentHomeTheorySimulation,
    };
  }

  IconData _iconForAction(StudentHomeQuickActionType action) {
    return switch (action) {
      StudentHomeQuickActionType.newBooking => PhosphorIconsBold.plusCircle,
      StudentHomeQuickActionType.myBookings => PhosphorIconsBold.calendar,
      StudentHomeQuickActionType.certificateRequest =>
        PhosphorIconsBold.certificate,
      StudentHomeQuickActionType.theorySimulation => PhosphorIconsBold.exam,
    };
  }
}
