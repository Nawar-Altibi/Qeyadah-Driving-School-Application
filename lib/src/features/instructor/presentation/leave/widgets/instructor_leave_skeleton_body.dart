import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/leave/widgets/instructor_leave_body.dart';

/// Shimmer loading state for the instructor leave screen.
class InstructorLeaveSkeletonBody extends StatelessWidget {
  const InstructorLeaveSkeletonBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonizer(
      child: InstructorLeaveBody(leaves: [InstructorLeaveEntity.placeholder()]),
    );
  }
}
