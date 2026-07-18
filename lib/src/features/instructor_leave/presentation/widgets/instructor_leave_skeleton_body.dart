import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_leave/presentation/widgets/instructor_leave_body.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Shimmer loading state for the instructor leave screen.
class InstructorLeaveSkeletonBody extends StatelessWidget {
  const InstructorLeaveSkeletonBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: InstructorLeaveBody(leaves: [InstructorLeaveEntity.placeholder()]),
    );
  }
}
