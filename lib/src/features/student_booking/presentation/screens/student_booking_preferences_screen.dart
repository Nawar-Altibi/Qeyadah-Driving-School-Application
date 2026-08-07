import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_flow_back_button.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/coordinators/student_booking_screen_coordinators.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/cubit/student_booking_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/widgets/student_booking_preferences_body.dart';

class StudentBookingPreferencesScreen extends StatelessWidget {
  const StudentBookingPreferencesScreen({super.key});

  static const String routePath = '/student/booking/preferences';
  static const String routeName = 'student-booking-preferences';

  @override
  Widget build(BuildContext context) {
    return StudentBookingPreferencesScreenCoordinator(
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: AppFlowBackButton(
            onCancel: context.read<StudentBookingCubit>().resetDraft,
          ),
          title: Text(
            AppLocalizations.of(context).studentBookingPreferencesTitle,
          ),
          centerTitle: true,
        ),
        body: const SafeArea(
          child: ResponsiveShell(child: StudentBookingPreferencesBody()),
        ),
      ),
    );
  }
}
