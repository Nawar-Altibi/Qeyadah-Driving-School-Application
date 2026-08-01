import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/screens/student_home_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/navigation/student_payment_hold_args.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/navigation/student_payment_screen_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/screens/student_payment_screen.dart';

abstract final class StudentPaymentNavigation {
  static void pushPayment({
    required BuildContext context,
    required StudentPaymentHoldArgs args,
  }) {
    CoreNavigator.pushPath(
      StudentPaymentScreen.routePath,
      context: context,
      arguments: StudentPaymentScreenParams(args: args),
    );
  }

  /// Replaces the whole payment flow with the payment screen (used when
  /// resuming from the home "pending payment" banner).
  static void goToPayment({
    required BuildContext context,
    required StudentPaymentHoldArgs args,
  }) {
    CoreNavigator.toPath(
      StudentPaymentScreen.routePath,
      context: context,
      arguments: StudentPaymentScreenParams(args: args),
    );
  }

  static void goHome({BuildContext? context}) {
    CoreNavigator.toPath(StudentHomeScreen.routePath, context: context);
  }

  static void pop({BuildContext? context}) {
    CoreNavigator.pop(context);
  }
}
