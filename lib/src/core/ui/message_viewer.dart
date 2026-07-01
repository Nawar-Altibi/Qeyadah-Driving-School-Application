import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

final GlobalKey<ScaffoldMessengerState> appScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>(debugLabel: 'appScaffoldMessenger');

void showErrorMessage({required String message, BuildContext? context}) {
  _showMessage(
    message: message,
    context: context,
    backgroundColor: Colors.red.shade700,
  );
}

void showSuccessMessage({required String message, BuildContext? context}) {
  _showMessage(
    message: message,
    context: context,
    backgroundColor: Colors.green.shade700,
  );
}

void _showMessage({
  required String message,
  BuildContext? context,
  Color? backgroundColor,
}) {
  void show({int attempt = 0}) {
    final messenger = _resolveScaffoldMessenger(context);
    if (messenger != null) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(message, style: const TextStyle(color: Colors.white)),
          backgroundColor: backgroundColor,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 4),
        ),
      );
      return;
    }

    if (attempt < 8) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => show(attempt: attempt + 1),
      );
    }
  }

  final phase = SchedulerBinding.instance.schedulerPhase;
  if (phase == SchedulerPhase.persistentCallbacks ||
      phase == SchedulerPhase.midFrameMicrotasks) {
    WidgetsBinding.instance.addPostFrameCallback((_) => show());
    return;
  }

  show();
}

ScaffoldMessengerState? _resolveScaffoldMessenger(BuildContext? context) {
  if (context != null && context.mounted) {
    final messenger = ScaffoldMessenger.maybeOf(context);
    if (messenger != null) return messenger;
  }
  return appScaffoldMessengerKey.currentState;
}
