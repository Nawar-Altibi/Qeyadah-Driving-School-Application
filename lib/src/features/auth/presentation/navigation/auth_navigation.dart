import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/screens/login_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_home/presentation/screens/instructor_home_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/screens/student_home_screen.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/user_role.dart';

abstract final class AuthNavigation {
  static void goLogin({BuildContext? context}) {
    CoreNavigator.toPath(LoginScreen.routePath, context: context);
  }

  static void goHome({BuildContext? context, UserRole? role}) {
    final path = role == UserRole.instructor
        ? InstructorHomeScreen.routePath
        : StudentHomeScreen.routePath;
    CoreNavigator.toPath(path, context: context);
  }
}
