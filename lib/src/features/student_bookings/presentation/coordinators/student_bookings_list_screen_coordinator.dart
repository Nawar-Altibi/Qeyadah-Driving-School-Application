import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/route_resumed_refresh.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/cubit/student_bookings_list_cubit.dart';

class StudentBookingsListScreenCoordinator extends StatelessWidget {
  const StudentBookingsListScreenCoordinator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RouteResumedRefresh(
      onInitialLoad: () => context.read<StudentBookingsListCubit>().load(),
      onResumed: () => context.read<StudentBookingsListCubit>().load(),
      child: child,
    );
  }
}
