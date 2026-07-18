import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/route_resumed_refresh.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_leave/presentation/cubit/instructor_leave_cubit.dart';

class InstructorLeaveScreenCoordinator extends StatelessWidget {
  const InstructorLeaveScreenCoordinator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RouteResumedRefresh(
      onInitialLoad: () => context.read<InstructorLeaveCubit>().load(),
      onResumed: () => context.read<InstructorLeaveCubit>().load(),
      child: child,
    );
  }
}
