import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_text_theme_extension.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

class AppSegmentedControl<T> extends StatelessWidget {
  const AppSegmentedControl({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  final List<AppSegmentedItem<T>> items;
  final T value;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextStylesExtension>();

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.neutralBg,
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: [
            for (final item in items)
              Expanded(
                child: _SegmentButton<T>(
                  item: item,
                  selected: item.value == value,
                  textStyle: textTheme?.semibold14,
                  onPressed: () => onChanged(item.value),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AppSegmentedItem<T> {
  const AppSegmentedItem({required this.value, required this.label});

  final T value;
  final String label;
}

class _SegmentButton<T> extends StatelessWidget {
  const _SegmentButton({
    required this.item,
    required this.selected,
    required this.onPressed,
    this.textStyle,
  });

  final AppSegmentedItem<T> item;
  final bool selected;
  final VoidCallback onPressed;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppDesignTokens.animationFast,
      decoration: BoxDecoration(
        color: selected ? AppColors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(11),
        boxShadow: selected
            ? const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ]
            : null,
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: selected ? AppColors.brandPrimary : AppColors.muted,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: Text(item.label, style: textStyle),
      ),
    );
  }
}
