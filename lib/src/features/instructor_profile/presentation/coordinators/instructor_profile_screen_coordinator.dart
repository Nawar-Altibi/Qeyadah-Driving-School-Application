import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/route_resumed_refresh.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_profile/presentation/cubit/instructor_profile_cubit.dart';

class InstructorProfileScreenCoordinator extends StatelessWidget {
  const InstructorProfileScreenCoordinator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RouteResumedRefresh(
      onInitialLoad: () => context.read<InstructorProfileCubit>().load(),
      onResumed: () => context.read<InstructorProfileCubit>().load(silent: true),
      child: child,
    );
  }
}
