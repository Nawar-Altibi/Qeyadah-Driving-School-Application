import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/screens/login_screen.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/presentation/screens/sample_items_screen.dart';

abstract final class AuthNavigation {
  static void goLogin({BuildContext? context}) {
    CoreNavigator.toPath(LoginScreen.routePath, context: context);
  }

  static void goHome({BuildContext? context}) {
    CoreNavigator.toPath(SampleItemsScreen.routePath, context: context);
  }
}
