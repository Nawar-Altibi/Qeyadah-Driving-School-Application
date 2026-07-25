import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/notifications/widgets/instructor_notifications_body.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_entity.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/cubit/notifications_inbox_cubit.dart';

/// Shimmer loading state for the instructor notifications screen.
class InstructorNotificationsSkeletonBody extends StatelessWidget {
  const InstructorNotificationsSkeletonBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonizer(
      child: InstructorNotificationsBody(
        state: const NotificationsInboxState(),
        page: AppNotificationsPageEntity.empty(),
        interactive: false,
      ),
    );
  }
}
