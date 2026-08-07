import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';

/// AppBar back button for a multi-step flow: runs [onCancel] (typically
/// `cubit.resetDraft`) before popping, so leaving a flow always leaves a
/// clean draft behind — used by both the booking flow and the certificate
/// request flow instead of two separate ad hoc back handlers.
class AppFlowBackButton extends StatelessWidget {
  const AppFlowBackButton({super.key, required this.onCancel});

  final VoidCallback onCancel;

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
        onCancel();
        Navigator.of(context).maybePop();
      },
    );
  }
}
