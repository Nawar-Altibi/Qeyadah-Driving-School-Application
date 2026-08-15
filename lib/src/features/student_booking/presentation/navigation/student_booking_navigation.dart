import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/cubit/student_booking_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/navigation/student_booking_screen_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/screens/student_booking_credit_success_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/screens/student_booking_preferences_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/screens/student_booking_review_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/screens/student_booking_slots_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/screens/student_home_screen.dart';

abstract final class StudentBookingNavigation {
  static void pushPreferences({BuildContext? context}) {
    CoreNavigator.pushPath(
      StudentBookingPreferencesScreen.routePath,
      context: context,
    );
  }

  static void pushSlots({required BuildContext context}) {
    CoreNavigator.pushPath(
      StudentBookingSlotsScreen.routePath,
      context: context,
      arguments: StudentBookingScreenParams(
        cubit: context.read<StudentBookingCubit>(),
      ),
    );
  }

  static void pushReview({required BuildContext context}) {
    CoreNavigator.pushPath(
      StudentBookingReviewScreen.routePath,
      context: context,
      arguments: StudentBookingScreenParams(
        cubit: context.read<StudentBookingCubit>(),
      ),
    );
  }

  static void goCreditSuccess({BuildContext? context, required int bookingId}) {
    CoreNavigator.toPath(
      StudentBookingCreditSuccessScreen.routePath,
      context: context,
      arguments: StudentBookingCreditSuccessScreenParams(bookingId: bookingId),
    );
  }

  static void popToSlots({required BuildContext context}) {
    CoreNavigator.pop(context);
  }

  static void goHome({BuildContext? context}) {
    CoreNavigator.toPath(StudentHomeScreen.routePath, context: context);
  }

  static void pop({BuildContext? context}) {
    CoreNavigator.pop(context);
  }
}
