import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/screens/student_certificate_detail_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/screens/student_certificate_new_request_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/screens/student_certificate_reexam_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/screens/student_certificates_hub_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/screens/student_certificates_list_screen.dart';

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

  static void pushHistory({required BuildContext context}) {
    CoreNavigator.pushPath(
      StudentCertificatesListScreen.routePath,
      context: context,
    );
  }

  static void pushNewRequest({required BuildContext context}) {
    CoreNavigator.pushPath(
      StudentCertificateNewRequestScreen.routePath,
      context: context,
    );
  }

  static void pushReexam({
    required BuildContext context,
    required String certificateId,
  }) {
    CoreNavigator.pushPath(
      StudentCertificateReexamScreen.pathFor(certificateId),
      context: context,
    );
  }

  static void pushDetail({
    BuildContext? context,
    required String certificateId,
  }) {
    CoreNavigator.pushPath(
      StudentCertificateDetailScreen.pathFor(certificateId),
      context: context,
    );
  }

  static void goDetail({BuildContext? context, required String certificateId}) {
    CoreNavigator.toPath(
      StudentCertificateDetailScreen.pathFor(certificateId),
      context: context,
    );
  }
}
