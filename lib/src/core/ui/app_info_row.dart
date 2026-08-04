import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

enum AppInfoRowLayout {
  /// Icon in a rounded square, label stacked above value.
  stacked,

  /// Circular icon, label left / value right.
  inline,

  /// Label left / value right, no icon.
  simple,
}

class AppInfoRow extends StatelessWidget {
  const AppInfoRow.stacked({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  }) : layout = AppInfoRowLayout.stacked,
       padding = null;

  const AppInfoRow.inline({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppDesignTokens.spacingMd,
      vertical: 14,
    ),
  }) : layout = AppInfoRowLayout.inline;

  const AppInfoRow.simple({super.key, required this.label, required this.value})
    : layout = AppInfoRowLayout.simple,
      icon = null,
      padding = null;

  final AppInfoRowLayout layout;
  final IconData? icon;
  final String label;
  final String value;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final Widget child = switch (layout) {
      AppInfoRowLayout.stacked => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _iconBox(rounded: true),
          const SizedBox(width: AppDesignTokens.spacingSm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: textTheme.bodySmall?.copyWith(
                    color: AppColors.muted,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      AppInfoRowLayout.inline => Row(
        children: [
          _iconBox(rounded: false),
          const SizedBox(width: AppDesignTokens.spacing),
          Expanded(
            child: Text(
              label,
              style: textTheme.bodyMedium?.copyWith(color: AppColors.muted),
            ),
          ),
          const SizedBox(width: AppDesignTokens.spacingSm),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: textTheme.bodyMedium?.copyWith(
                color: AppColors.ink,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
      AppInfoRowLayout.simple => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: textTheme.bodyMedium?.copyWith(color: AppColors.muted),
          ),
          Text(
            value,
            style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    };

    if (padding == null) return child;
    return Padding(padding: padding!, child: child);
  }

  Widget _iconBox({required bool rounded}) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: AppColors.brandMintSoft,
        borderRadius: rounded
            ? BorderRadius.circular(AppDesignTokens.radiusControl)
            : null,
        shape: rounded ? BoxShape.rectangle : BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(icon, size: 18, color: AppColors.brandPrimary),
    );
  }
}
