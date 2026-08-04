import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_branded_splash.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static const String routePath = '/';
  static const String routeName = 'splash';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.brandPrimary,
      body: AppBrandedSplash(),
    );
  }
}
