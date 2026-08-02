import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/domain/entities/app_notification_entity.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/cubit/notifications_inbox_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/widgets/notifications_inbox_body.dart';

class NotificationsInboxSkeletonBody extends StatelessWidget {
  const NotificationsInboxSkeletonBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonizer(
      child: NotificationsInboxBody(
        state: const NotificationsInboxState(),
        page: AppNotificationsPageEntity.empty(),
        interactive: false,
      ),
    );
  }
}
