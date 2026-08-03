import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/navigation/student_bookings_screen_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/screens/student_booking_detail_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/screens/student_bookings_list_screen.dart';

abstract final class StudentBookingsNavigation {
  static void pushList({BuildContext? context}) {
    CoreNavigator.pushPath(
      StudentBookingsListScreen.routePath,
      context: context,
    );
  }

  static void goList({BuildContext? context}) {
    CoreNavigator.toPath(StudentBookingsListScreen.routePath, context: context);
  }

  static void pushDetail({BuildContext? context, required int bookingId}) {
    CoreNavigator.pushPath(
      StudentBookingDetailScreen.routePath,
      context: context,
      arguments: StudentBookingDetailScreenParams(bookingId: bookingId),
    );
  }

  static void goDetail({BuildContext? context, required int bookingId}) {
    CoreNavigator.toPath(
      StudentBookingDetailScreen.routePath,
      context: context,
      arguments: StudentBookingDetailScreenParams(bookingId: bookingId),
    );
  }

  static void pop({BuildContext? context}) {
    CoreNavigator.pop(context);
  }
}
