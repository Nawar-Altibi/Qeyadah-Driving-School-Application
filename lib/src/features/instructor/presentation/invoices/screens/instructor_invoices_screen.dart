import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_async_body.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/invoices/coordinators/instructor_invoices_screen_coordinator.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/invoices/cubit/instructor_invoices_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/invoices/widgets/instructor_invoices_body.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/invoices/widgets/instructor_invoices_skeleton_body.dart';

class InstructorInvoicesScreen extends StatelessWidget {
  const InstructorInvoicesScreen({super.key});

  static const String routePath = '/instructor/invoices';
  static const String routeName = 'instructor-invoices';

  @override
  Widget build(BuildContext context) {
    return InstructorInvoicesScreenCoordinator(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: Text(AppLocalizations.of(context).instructorInvoicesTitle),
          centerTitle: true,
        ),
        body: ResponsiveShell(
          child: BlocBuilder<InstructorInvoicesCubit, InstructorInvoicesState>(
            builder: (context, state) => AppAsyncBody(
              state: state.apiState,
              loading: const InstructorInvoicesSkeletonBody(),
              builder: (context, page) =>
                  InstructorInvoicesBody(state: state, page: page),
            ),
          ),
        ),
      ),
    );
  }
}
