import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_quick_action_tile.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_section_heading.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';

/// Shimmer loading state that mirrors the student home layout.
class StudentHomeSkeletonBody extends StatelessWidget {
  const StudentHomeSkeletonBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonizer(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: AppDesignTokens.screenContentPadding(
          extraBottom: AppDesignTokens.bottomNavHeight,
        ),
        children: [
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sunday, 16 August'),
                    SizedBox(height: 3),
                    Text('Good morning student name'),
                  ],
                ),
              ),
              SizedBox(
                width: 38,
                height: 38,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: const Text('bell'),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDesignTokens.spacingLg),
          const AppCard(
            child: SizedBox(
              height: 168,
              width: double.infinity,
              child: Text('Loading next lesson card'),
            ),
          ),
          const SizedBox(height: AppDesignTokens.spacingLg),
          const AppSectionHeading(title: 'Quick actions'),
          const SizedBox(height: AppDesignTokens.spacing),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.55,
            children: const [
              AppQuickActionTile(
                label: 'New booking',
                icon: PhosphorIconsBold.plusCircle,
                onTap: null,
              ),
              AppQuickActionTile(
                label: 'My bookings',
                icon: PhosphorIconsBold.calendarDots,
                onTap: null,
              ),
              AppQuickActionTile(
                label: 'Certificate',
                icon: PhosphorIconsBold.certificate,
                onTap: null,
              ),
              AppQuickActionTile(
                label: 'Theory exam',
                icon: PhosphorIconsBold.exam,
                onTap: null,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
