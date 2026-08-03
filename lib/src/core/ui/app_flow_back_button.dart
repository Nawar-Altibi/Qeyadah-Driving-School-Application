import 'package:flutter/material.dart';

/// AppBar back button for a multi-step flow: runs [onCancel] (typically
/// `cubit.resetDraft`) before popping, so leaving a flow always leaves a
/// clean draft behind — used by both the booking flow and the certificate
/// request flow instead of two separate ad hoc back handlers.
class AppFlowBackButton extends StatelessWidget {
  const AppFlowBackButton({super.key, required this.onCancel});

  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const BackButtonIcon(),
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      onPressed: () {
        onCancel();
        Navigator.of(context).maybePop();
      },
    );
  }
}
