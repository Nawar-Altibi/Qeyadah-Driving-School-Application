import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_skeleton_shell.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/domain/entities/instructor_entities.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/invoices/cubit/instructor_invoices_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/invoices/widgets/instructor_invoices_body.dart';

/// Shimmer loading state for the instructor invoices screen.
class InstructorInvoicesSkeletonBody extends StatelessWidget {
  const InstructorInvoicesSkeletonBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeletonizer(
      child: InstructorInvoicesBody(
        state: InstructorInvoicesState.initial(),
        page: InstructorInvoicesPageEntity.placeholder(),
        interactive: false,
      ),
    );
  }
}
