import 'package:coore/lib.dart';
import 'package:flutter/material.dart';

class AppInputField extends StatelessWidget {
  const AppInputField({
    super.key,
    required this.name,
    required this.label,
    this.obscureText = false,
    this.keyboardType,
    this.initialText,
    this.hintText,
    this.prefixIcon,
    this.textInputAction,
    this.autoFillHints,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
  });

  final String name;
  final String label;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? initialText;
  final String? hintText;
  final Widget? prefixIcon;
  final TextInputAction? textInputAction;
  final Iterable<String>? autoFillHints;

  /// Set [maxLines] > 1 (with [minLines]) for a multiline text area.
  final int? maxLines;
  final int? minLines;

  /// When set, also renders Flutter's built-in "x/maxLength" counter below
  /// the field.
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onSurface = theme.colorScheme.onSurface;

    return CoreTextField(
      name: name,
      labelText: label,
      obscureText: obscureText,
      keyboardType: keyboardType,
      initialText: initialText,
      hintText: hintText,
      prefixIcon: prefixIcon,
      textInputAction: textInputAction,
      autoFillHints: autoFillHints,
      maxLines: maxLines,
      minLines: minLines,
      maxLength: maxLength,
      style: theme.textTheme.bodyLarge?.copyWith(color: onSurface),
      decoration: const InputDecoration().applyDefaults(
        theme.inputDecorationTheme,
      ),
    );
  }
}
