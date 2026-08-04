import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppDesignTokens.spacingMd),
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius = AppDesignTokens.radiusLg,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final card = AnimatedContainer(
      duration: AppDesignTokens.animationFast,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? colors.surfaceContainer,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor ?? colors.outline),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F153023),
            blurRadius: 16,
            offset: Offset(0, 5),
          ),
          BoxShadow(
            color: Color(0x08153023),
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: child,
    );

    if (onTap == null) return card;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius),
        onTap: onTap,
        child: card,
      ),
    );
  }
}
