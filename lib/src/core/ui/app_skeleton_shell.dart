import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Whether an ancestor [Skeletonizer] is actively painting shimmer bones.
bool isAppSkeletonLoading(BuildContext context) =>
    Skeletonizer.maybeOf(context)?.enabled ?? false;

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
