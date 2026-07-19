import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/route_resumed_refresh.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/notifications/cubit/instructor_notifications_cubit.dart';

class InstructorNotificationsScreenCoordinator extends StatelessWidget {
  const InstructorNotificationsScreenCoordinator({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RouteResumedRefresh(
      onInitialLoad: () => context.read<InstructorNotificationsCubit>().load(),
      onResumed: () => context.read<InstructorNotificationsCubit>().load(),
      child: child,
    );
  }
}
