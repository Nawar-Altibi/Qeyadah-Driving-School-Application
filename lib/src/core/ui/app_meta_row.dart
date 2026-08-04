import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

/// Compact icon + label row used across list/detail cards.
class AppMetaRow extends StatelessWidget {
  const AppMetaRow({
    super.key,
    required this.icon,
    required this.label,
    this.iconSize = 16,
    this.iconColor = AppColors.muted,
    this.labelColor = AppColors.ink,
    this.labelStyle,
    this.gap,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.alignEnd = false,
    this.expandLabel = true,
    this.padding,
  });

  final IconData icon;
  final String label;
  final double iconSize;
  final Color iconColor;
  final Color? labelColor;
  final TextStyle? labelStyle;
  final double? gap;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final bool alignEnd;
  final bool expandLabel;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final resolvedStyle =
        labelStyle ??
        Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: labelColor,
          fontSize: 14,
          height: 1.4,
        );

    final labelWidget = Text(
      label,
      textAlign: alignEnd ? TextAlign.end : TextAlign.start,
      style: resolvedStyle,
    );

    final row = Row(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: alignEnd
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Icon(icon, size: iconSize, color: iconColor),
        SizedBox(width: gap ?? AppDesignTokens.spacingSm),
        if (expandLabel)
          Expanded(child: labelWidget)
        else
          Flexible(child: labelWidget),
      ],
    );

    if (padding == null) return row;
    return Padding(padding: padding!, child: row);
  }
}

/// Title + subtitle meta tile with leading icon and optional trailing.
class AppMetaTile extends StatelessWidget {
  const AppMetaTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.padding = const EdgeInsets.only(bottom: AppDesignTokens.spacingSm),
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Widget? trailing;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: AppColors.muted),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.5,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: textTheme.bodySmall?.copyWith(
                  color: AppColors.muted,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) ...[const SizedBox(width: 8), trailing!],
      ],
    );

    if (padding == null) return content;
    return Padding(padding: padding!, child: content);
  }
}
