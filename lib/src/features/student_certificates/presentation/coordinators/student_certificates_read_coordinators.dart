import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/src/core/presentation/route_resumed_refresh.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificate_detail_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificates_list_cubit.dart';

class StudentCertificatesListScreenCoordinator extends StatelessWidget {
  const StudentCertificatesListScreenCoordinator({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RouteResumedRefresh(
      onInitialLoad: () => context.read<StudentCertificatesListCubit>().load(),
      onResumed: () => context.read<StudentCertificatesListCubit>().refresh(),
      child: child,
    );
  }
}

class StudentCertificateDetailScreenCoordinator extends StatelessWidget {
  const StudentCertificateDetailScreenCoordinator({
    required this.certificateId,
    required this.child,
    super.key,
  });

  final String certificateId;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RouteResumedRefresh(
      onInitialLoad: () =>
          context.read<StudentCertificateDetailCubit>().load(certificateId),
      onResumed: () => context.read<StudentCertificateDetailCubit>().refresh(),
      child: child,
    );
  }
}
