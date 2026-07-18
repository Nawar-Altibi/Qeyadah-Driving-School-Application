import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_profile/presentation/widgets/instructor_profile_body.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';

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
