import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/widgets/instructor_schedule_body.dart';

/// Shimmer loading state for the instructor schedule screen.
class InstructorScheduleSkeletonBody extends StatelessWidget {
  const InstructorScheduleSkeletonBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonizer(
      child: InstructorScheduleBody(
        dashboard: InstructorScheduleDashboardEntity.placeholder(),
        interactive: false,
      ),
    );
  }
}
