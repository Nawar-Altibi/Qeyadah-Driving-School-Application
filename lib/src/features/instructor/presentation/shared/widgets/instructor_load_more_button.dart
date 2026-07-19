import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_button.dart';

/// Secondary "load more" control shared by paginated instructor lists.
class InstructorLoadMoreButton extends StatelessWidget {
  const InstructorLoadMoreButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: AppDesignTokens.spacingSm),
      child: AppButton.secondary(
        label: l10n.instructorLoadMore,
        isLoading: isLoading,
        onPressed: isLoading ? null : onPressed,
      ),
    );
  }
}
