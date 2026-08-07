import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/mappers/core_failure_message_mapper.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';

/// Standardized [ApiState] body for loading / failed / succeeded screens.
class AppAsyncBody<T> extends StatelessWidget {
  const AppAsyncBody({
    super.key,
    required this.state,
    required this.builder,
    this.loading,
    this.onRetry,
    this.failureMessage,
    this.retryLabel,
  });

  final ApiState<T> state;
  final Widget Function(BuildContext context, T data) builder;
  final Widget? loading;
  final VoidCallback? onRetry;
  final String Function(Failure failure)? failureMessage;
  final String? retryLabel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return state.when(
      initial: () => loading ?? const _AppAsyncLoading(),
      loading: () => loading ?? const _AppAsyncLoading(),
      succeeded: (data) => builder(context, data),
      failed: (failure, retryFunction) => _AppAsyncFailure(
        message:
            failureMessage?.call(failure) ??
            CoreFailureMessageMapper.messageFor(failure, l10n),
        retryLabel: retryLabel ?? l10n.retry,
        onRetry: onRetry ?? retryFunction,
      ),
    );
  }
}

class _AppAsyncLoading extends StatelessWidget {
  const _AppAsyncLoading();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _AppAsyncFailure extends StatelessWidget {
  const _AppAsyncFailure({
    required this.message,
    required this.retryLabel,
    this.onRetry,
  });

  final String message;
  final String retryLabel;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDesignTokens.spacingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppSemanticColors.of(context).muted,
                height: 1.4,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppDesignTokens.spacing),
              AppButton.primary(label: retryLabel, onPressed: onRetry),
            ],
          ],
        ),
      ),
    );
  }
}
