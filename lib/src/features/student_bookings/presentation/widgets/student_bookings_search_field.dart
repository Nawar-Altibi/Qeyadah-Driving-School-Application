import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

/// A plain search text field (no form validation needed) that reports
/// changes back to the cubit, which handles debouncing internally.
class StudentBookingsSearchField extends StatefulWidget {
  const StudentBookingsSearchField({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.interactive = true,
  });

  final String initialValue;
  final ValueChanged<String> onChanged;
  final bool interactive;

  @override
  State<StudentBookingsSearchField> createState() =>
      _StudentBookingsSearchFieldState();
}

class _StudentBookingsSearchFieldState
    extends State<StudentBookingsSearchField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialValue,
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(_handleTextChanged);
  }

  void _handleTextChanged() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return TextField(
      controller: _controller,
      enabled: widget.interactive,
      onChanged: widget.onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        hintText: l10n.studentBookingsSearchHint,
        prefixIcon: const Icon(
          PhosphorIconsBold.magnifyingGlass,
          size: 18,
          color: AppColors.muted,
        ),
        suffixIcon: _controller.text.isEmpty
            ? null
            : IconButton(
                icon: const Icon(Icons.clear, size: 18),
                onPressed: () {
                  _controller.clear();
                  widget.onChanged('');
                  setState(() {});
                },
              ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppDesignTokens.spacing,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
          borderSide: const BorderSide(color: AppColors.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
          borderSide: const BorderSide(color: AppColors.line),
        ),
      ),
      onTapOutside: (_) => FocusScope.of(context).unfocus(),
    );
  }
}
