import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/presentation/widgets/instructor_schedule_body.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Shimmer loading state for the instructor schedule screen.
class InstructorScheduleSkeletonBody extends StatelessWidget {
  const InstructorScheduleSkeletonBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: InstructorScheduleBody(
        dashboard: InstructorScheduleDashboardEntity.placeholder(),
        interactive: false,
      ),
    );
  }
}
