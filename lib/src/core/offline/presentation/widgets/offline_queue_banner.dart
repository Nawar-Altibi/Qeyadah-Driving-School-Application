import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/constants/environment_variables.dart';
import 'package:qeyadah_mobile_app/src/core/offline/presentation/cubit/offline_queue_cubit.dart';

class OfflineQueueBanner extends StatelessWidget {
  const OfflineQueueBanner({super.key});

  @override
  Widget build(BuildContext context) {
    if (!EnvironmentVariables.enableOfflineQueue) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<OfflineQueueCubit, OfflineQueueState>(
      builder: (context, state) {
        final status = state.status;
        if (status == null || status.pendingCount == 0) {
          return const SizedBox.shrink();
        }

        final l10n = AppLocalizations.of(context);
        final message = status.isProcessing
            ? l10n.offlineQueueSyncing
            : l10n.offlineQueuePending(status.pendingCount);

        return MaterialBanner(
          content: Text(message),
          leading: Icon(status.isOnline ? Icons.cloud_sync : Icons.cloud_off),
          actions: const [SizedBox.shrink()],
        );
      },
    );
  }
}
