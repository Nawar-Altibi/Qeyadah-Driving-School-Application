import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

class AuthScreenScaffold extends StatelessWidget {
  const AuthScreenScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(gradient: AppGradients.loginBackground),
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
    );
  }
}
