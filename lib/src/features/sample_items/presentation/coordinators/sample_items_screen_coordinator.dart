import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/route_resumed_refresh.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/presentation/cubit/sample_items_cubit.dart';

class SampleItemsScreenCoordinator extends StatelessWidget {
  const SampleItemsScreenCoordinator({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RouteResumedRefresh(
      onInitialLoad: () => context.read<SampleItemsCubit>().load(),
      onResumed: () => context.read<SampleItemsCubit>().load(silent: true),
      child: child,
    );
  }
}
