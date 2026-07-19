import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/notifications/cubit/instructor_notifications_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/notifications/widgets/instructor_notifications_body.dart';

/// Shimmer loading state for the instructor notifications screen.
class InstructorNotificationsSkeletonBody extends StatelessWidget {
  const InstructorNotificationsSkeletonBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonizer(
      child: InstructorNotificationsBody(
        state: const InstructorNotificationsState(),
        page: InstructorNotificationsPageEntity.placeholder(),
        interactive: false,
      ),
    );
  }
}
