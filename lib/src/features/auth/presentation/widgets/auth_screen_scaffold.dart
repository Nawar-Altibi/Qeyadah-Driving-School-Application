import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_theme_data.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

class AuthScreenScaffold extends StatelessWidget {
  const AuthScreenScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // Auth canvases always use a light mint gradient — keep field chrome and
    // text contrast light even when the rest of the app follows system dark.
    final lightTheme = AppThemeData.lightThemeData;

    return Theme(
      data: lightTheme,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
          backgroundColor: AppColors.appCanvas,
          body: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: AppGradients.loginBackground,
            ),
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppDesignTokens.screenHorizontalPadding,
                  AppDesignTokens.spacingMd,
                  AppDesignTokens.screenHorizontalPadding,
                  AppDesignTokens.spacingLg,
                ),
                children: [child],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
