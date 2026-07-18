import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_dues/presentation/widgets/instructor_dues_body.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_schedule/domain/entities/instructor_entities.dart';

/// Shimmer loading state for the instructor dues screen.
class InstructorDuesSkeletonBody extends StatelessWidget {
  const InstructorDuesSkeletonBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonizer(
      child: InstructorDuesBody(dues: InstructorDuesEntity.placeholder()),
    );
  }
}
