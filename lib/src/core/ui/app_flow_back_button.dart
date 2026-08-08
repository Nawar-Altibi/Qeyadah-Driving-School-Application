import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';

/// AppBar back button for a multi-step flow.
///
/// Optionally runs [onCancel] (e.g. `cubit.resetDraft`) before popping.
/// Pass [onCancel] only when leaving the whole flow — not when popping one
/// step while preserving shared cubit state (e.g. review → slots).
class AppFlowBackButton extends StatelessWidget {
  const AppFlowBackButton({super.key, this.onCancel});

  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    return IconButton(
      icon: Icon(
        PhosphorIconsBold.arrowRight,
        color: colors.ink,
        size: 22,
        textDirection: TextDirection.ltr,
      ),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        onCancel?.call();
        Navigator.of(context).maybePop();
      },
    );
  }
}
