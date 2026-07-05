import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/password_reset_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/registration_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/navigation/auth_screen_params.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/screens/login_screen.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/screens/new_password_screen.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/screens/register_otp_screen.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/screens/register_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor_home/presentation/screens/instructor_home_screen.dart';
import 'package:qeyadah_mobile_app/src/features/profile/presentation/screens/profile_screen.dart';
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

  static void goForcePasswordChange({BuildContext? context}) {
    CoreNavigator.toPath(NewPasswordScreen.forcedRoutePath, context: context);
  }

  static void pushRegister({BuildContext? context}) {
    CoreNavigator.pushPath(RegisterScreen.routePath, context: context);
  }

  static void pushRegisterOtp({required BuildContext context}) {
    CoreNavigator.pushPath(
      RegisterOtpScreen.routePath,
      context: context,
      arguments: RegisterOtpScreenParams(
        cubit: context.read<RegistrationCubit>(),
      ),
    );
  }

  static void pushForgotPassword({BuildContext? context}) {
    CoreNavigator.pushPath(ForgotPasswordScreen.routePath, context: context);
  }

  static void pushNewPassword({
    required BuildContext context,
    required String phone,
  }) {
    CoreNavigator.pushPath(
      NewPasswordScreen.routePath,
      context: context,
      arguments: NewPasswordScreenParams(
        cubit: context.read<PasswordResetCubit>(),
        phone: phone,
      ),
    );
  }

  static void pushProfile({BuildContext? context}) {
    CoreNavigator.pushPath(ProfileScreen.routePath, context: context);
  }

  static void pop({BuildContext? context}) {
    CoreNavigator.pop(context);
  }
}
