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

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
