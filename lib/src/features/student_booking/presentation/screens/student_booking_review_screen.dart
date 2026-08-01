import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/ui/responsive/app_breakpoints.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/coordinators/student_booking_screen_coordinators.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/cubit/student_booking_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/widgets/student_booking_review_body.dart';

class StudentBookingReviewScreen extends StatelessWidget {
  const StudentBookingReviewScreen({super.key});

  static const String routePath = '/student/booking/review';
  static const String routeName = 'student-booking-review';

  @override
  Widget build(BuildContext context) {
    return StudentBookingReviewScreenCoordinator(
      child: Scaffold(
        backgroundColor: AppColors.appCanvas,
        appBar: AppBar(
          backgroundColor: AppColors.appCanvas,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: Text(AppLocalizations.of(context).studentBookingReviewTitle),
          centerTitle: true,
        ),
        body: SafeArea(
          child: ResponsiveShell(
            child: BlocBuilder<StudentBookingCubit, StudentBookingState>(
              buildWhen: (previous, current) =>
                  previous.selection != current.selection ||
                  previous.isCreatingBooking != current.isCreatingBooking,
              builder: (context, state) {
                final selection = state.selection;
                if (selection == null) {
                  return const SizedBox.shrink();
                }
                return StudentBookingReviewBody(
                  selection: selection,
                  isCreatingBooking: state.isCreatingBooking,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
