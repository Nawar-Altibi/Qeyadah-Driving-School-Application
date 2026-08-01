import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Whether an ancestor [Skeletonizer] is actively painting shimmer bones.
bool isAppSkeletonLoading(BuildContext context) =>
    Skeletonizer.maybeOf(context)?.enabled ?? false;

/// Shared on-brand shimmer colors for instructor/loading skeletons.
abstract final class AppSkeletonTheme {
  static const Color baseColor = AppColors.line;
  static const Color highlightColor = AppColors.brandMintSoft;

  static const ShimmerEffect effect = ShimmerEffect(
    baseColor: baseColor,
    highlightColor: highlightColor,
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
      effect: AppSkeletonTheme.effect,
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
