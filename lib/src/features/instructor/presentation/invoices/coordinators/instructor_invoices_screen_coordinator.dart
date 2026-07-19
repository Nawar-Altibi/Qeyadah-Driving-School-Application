import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/route_resumed_refresh.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/invoices/cubit/instructor_invoices_cubit.dart';

class InstructorInvoicesScreenCoordinator extends StatelessWidget {
  const InstructorInvoicesScreenCoordinator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RouteResumedRefresh(
      onInitialLoad: () => context.read<InstructorInvoicesCubit>().load(),
      onResumed: () => context.read<InstructorInvoicesCubit>().load(),
      child: child,
    );
  }
}
