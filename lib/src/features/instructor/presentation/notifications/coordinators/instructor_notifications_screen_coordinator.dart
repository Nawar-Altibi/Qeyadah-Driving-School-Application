import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/route_resumed_refresh.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/cubit/notifications_inbox_cubit.dart';

class InstructorNotificationsScreenCoordinator extends StatelessWidget {
  const InstructorNotificationsScreenCoordinator({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RouteResumedRefresh(
      onInitialLoad: () => context.read<NotificationsInboxCubit>().load(),
      onResumed: () => context.read<NotificationsInboxCubit>().load(),
      child: child,
    );
  }
}
