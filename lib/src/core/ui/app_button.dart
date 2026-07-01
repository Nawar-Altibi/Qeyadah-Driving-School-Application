import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

class AppButton extends StatelessWidget {
  const AppButton.primary({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.icon,
  }) : _variant = _AppButtonVariant.primary;

  const AppButton.secondary({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.icon,
  }) : _variant = _AppButtonVariant.secondary;

  const AppButton.ghost({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.icon,
  }) : _variant = _AppButtonVariant.ghost;

  const AppButton.danger({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.icon,
  }) : _variant = _AppButtonVariant.danger;

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final IconData? icon;
  final _AppButtonVariant _variant;

  @override
  Widget build(BuildContext context) {
    final child = isLoading
        ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : _ButtonContent(label: label, icon: icon);

    final button = switch (_variant) {
      _AppButtonVariant.primary => FilledButton(
        onPressed: isLoading ? null : onPressed,
        child: child,
      ),
      _AppButtonVariant.secondary => OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        child: child,
      ),
      _AppButtonVariant.ghost => TextButton(
        onPressed: isLoading ? null : onPressed,
        child: child,
      ),
      _AppButtonVariant.danger => FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.dangerBg,
          foregroundColor: AppColors.danger,
          elevation: 0,
          minimumSize: const Size.fromHeight(AppDesignTokens.buttonHeight),
        ),
        onPressed: isLoading ? null : onPressed,
        child: child,
      ),
    };

    if (width != null) {
      return SizedBox(width: width, child: button);
    }
    return SizedBox(width: double.infinity, child: button);
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({required this.label, this.icon});

  final String label;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    if (icon == null) return Text(label);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 18),
        const SizedBox(width: AppDesignTokens.spacingSm),
        Text(label),
      ],
    );
  }
}

enum _AppButtonVariant { primary, secondary, ghost, danger }
