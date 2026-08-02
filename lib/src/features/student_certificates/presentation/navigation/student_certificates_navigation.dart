import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/screens/student_certificates_hub_screen.dart';

abstract final class StudentCertificatesNavigation {
  static void pushHub({required BuildContext context}) {
    CoreNavigator.pushPath(
      StudentCertificatesHubScreen.routePath,
      context: context,
    );
  }

  static void goHub({BuildContext? context}) {
    CoreNavigator.toPath(
      StudentCertificatesHubScreen.routePath,
      context: context,
    );
  }
}
