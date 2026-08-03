import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/presentation/screens/student_theory_intro_screen.dart';

abstract final class StudentTheoryNavigation {
  static void pushSelfTest({BuildContext? context}) {
    CoreNavigator.pushPath(
      StudentTheoryIntroScreen.routePath,
      context: context,
    );
  }
}
