import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/main_common.dart';

Future<void> main() async {
  await mainCommon(
    CoreEnvironment.development,
    forcedLocale: const Locale('en'),
  );
}
