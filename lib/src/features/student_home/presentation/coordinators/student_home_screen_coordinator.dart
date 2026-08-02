import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/route_resumed_refresh.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/cubit/notifications_unread_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/cubit/student_home_cubit.dart';

class StudentHomeScreenCoordinator extends StatelessWidget {
  const StudentHomeScreenCoordinator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RouteResumedRefresh(
      onInitialLoad: () {
        context.read<StudentHomeCubit>().load();
        context.read<NotificationsUnreadCubit>().refresh();
      },
      onResumed: () {
        context.read<StudentHomeCubit>().load(silent: true);
        context.read<NotificationsUnreadCubit>().refresh();
      },
      child: child,
    );
  }
}
