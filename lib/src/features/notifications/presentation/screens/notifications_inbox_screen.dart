import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_async_body.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/coordinators/notifications_inbox_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/cubit/notifications_inbox_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/widgets/notifications_inbox_body.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/widgets/notifications_inbox_skeleton_body.dart';

class NotificationsInboxScreen extends StatelessWidget {
  const NotificationsInboxScreen({super.key});

  static const String routePath = '/notifications';
  static const String routeName = 'notifications-inbox';

  @override
  Widget build(BuildContext context) {
    return NotificationsInboxScreenCoordinator(
      child: Scaffold(
        backgroundColor: AppColors.appCanvas,
        appBar: AppBar(
          backgroundColor: AppColors.appCanvas,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: Text(AppLocalizations.of(context).notificationsInboxTitle),
          centerTitle: true,
        ),
        body: ResponsiveShell(
          child: BlocBuilder<NotificationsInboxCubit, NotificationsInboxState>(
            builder: (context, state) => AppAsyncBody(
              state: state.apiState,
              loading: const NotificationsInboxSkeletonBody(),
              builder: (context, page) =>
                  NotificationsInboxBody(state: state, page: page),
            ),
          ),
        ),
      ),
    );
  }
}
