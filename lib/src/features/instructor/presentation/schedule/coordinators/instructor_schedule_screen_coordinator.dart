import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/route_resumed_refresh.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/cubit/instructor_schedule_cubit.dart';

class InstructorScheduleScreenCoordinator extends StatelessWidget {
  const InstructorScheduleScreenCoordinator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RouteResumedRefresh(
      onInitialLoad: () => context.read<InstructorScheduleCubit>().load(),
      onResumed: () =>
          context.read<InstructorScheduleCubit>().load(silent: true),
      child: child,
    );
  }
}
