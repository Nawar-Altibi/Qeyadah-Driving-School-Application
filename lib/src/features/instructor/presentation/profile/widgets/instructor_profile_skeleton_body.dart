import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/profile/widgets/instructor_profile_body.dart';

/// Shimmer loading state for the instructor profile screen.
class InstructorProfileSkeletonBody extends StatelessWidget {
  const InstructorProfileSkeletonBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonizer(
      child: InstructorProfileBody(
        dashboard: InstructorProfileDashboardEntity.placeholder(),
        interactive: false,
      ),
    );
  }
}
