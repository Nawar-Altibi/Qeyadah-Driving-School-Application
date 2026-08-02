import 'dart:async';

import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/route_resumed_refresh.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/coordinators/push_notifications_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificates_hub_cubit.dart';

class StudentCertificatesHubScreenCoordinator extends StatefulWidget {
  const StudentCertificatesHubScreenCoordinator({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<StudentCertificatesHubScreenCoordinator> createState() =>
      _StudentCertificatesHubScreenCoordinatorState();
}

class _StudentCertificatesHubScreenCoordinatorState
    extends State<StudentCertificatesHubScreenCoordinator> {
  StreamSubscription<void>? _certificateStatusSub;

  @override
  void initState() {
    super.initState();
    _certificateStatusSub = getIt<PushNotificationsCoordinator>()
        .certificateStatusChanged
        .listen((_) {
          if (!mounted) return;
          context.read<StudentCertificatesHubCubit>().refresh();
        });
  }

  @override
  void dispose() {
    _certificateStatusSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RouteResumedRefresh(
      onInitialLoad: () => context.read<StudentCertificatesHubCubit>().load(),
      onResumed: () => context.read<StudentCertificatesHubCubit>().refresh(),
      child: widget.child,
    );
  }
}
