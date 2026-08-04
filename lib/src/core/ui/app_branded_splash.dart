import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

/// Matches the native green splash (logo on brand green) so bootstrap and
/// in-app splash feel like one continuous screen.
class AppBrandedSplash extends StatelessWidget {
  const AppBrandedSplash({
    super.key,
    this.showLoader = true,
    this.errorMessage,
  });

  final bool showLoader;
  final String? errorMessage;

  static const _logoAsset = 'assets/images/qeyadah_logo.jpg';

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.brandPrimary,
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppDesignTokens.spacingLg),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppDesignTokens.radiusLg),
                  child: Image.asset(
                    _logoAsset,
                    width: 168,
                    height: 168,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const Icon(
                      Icons.school_rounded,
                      size: 96,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(height: AppDesignTokens.spacingXl),
                if (errorMessage != null) ...[
                  const Icon(
                    Icons.error_outline,
                    color: AppColors.white,
                    size: 36,
                  ),
                  const SizedBox(height: AppDesignTokens.spacing),
                  Text(
                    errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                ] else if (showLoader)
                  const SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: AppColors.white,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
