import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Whether an ancestor [Skeletonizer] is actively painting shimmer bones.
bool isAppSkeletonLoading(BuildContext context) =>
    Skeletonizer.maybeOf(context)?.enabled ?? false;

/// Shared on-brand shimmer colors for instructor/loading skeletons.
abstract final class AppSkeletonTheme {
  static const Color lightBaseColor = AppColors.line;
  static const Color lightHighlightColor = AppColors.brandMintSoft;
  static const Color darkBaseColor = Color(0xFF2A3A32);
  static const Color darkHighlightColor = Color(0xFF3A4F44);

  static ShimmerEffect effectOf(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ShimmerEffect(
      baseColor: isDark ? darkBaseColor : lightBaseColor,
      highlightColor: isDark ? darkHighlightColor : lightHighlightColor,
      duration: const Duration(milliseconds: 1400),
    );
  }

  /// Light-only legacy constant kept for any non-context call sites.
  static const ShimmerEffect effect = ShimmerEffect(
    baseColor: lightBaseColor,
    highlightColor: lightHighlightColor,
    duration: Duration(milliseconds: 1400),
  );
}

/// Applies the shared [AppSkeletonTheme] shimmer around [child].
class AppSkeletonizer extends StatelessWidget {
  const AppSkeletonizer({super.key, required this.child, this.enabled = true});

  final Widget child;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: enabled,
      effect: AppSkeletonTheme.effectOf(context),
      child: child,
    );
  }
}

/// Keeps [shell] painted as-is while [content] receives skeleton shimmer.
///
/// Use for buttons and chips: stable background/border, shimmer on label/icon only.
Widget appSkeletonContentOverlay({
  required Widget shell,
  required Widget content,
  AlignmentGeometry alignment = Alignment.center,
  EdgeInsetsGeometry contentPadding = EdgeInsets.zero,
}) {
  return Stack(
    alignment: alignment,
    clipBehavior: Clip.none,
    children: <Widget>[
      Positioned.fill(child: Skeleton.keep(child: shell)),
      Padding(
        padding: contentPadding,
        child: Skeleton.ignorePointer(child: content),
      ),
    ],
  );
}

/// Prevents RTL auto-mirroring for asymmetric icons (e.g. Phosphor calendar).
class AppNonMirroredIcon extends StatelessWidget {
  const AppNonMirroredIcon(this.icon, {super.key, this.size, this.color});

  final IconData icon;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Icon(icon, size: size, color: color),
    );
  }
}
