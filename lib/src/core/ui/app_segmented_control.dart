import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
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
    final colors = AppSemanticColors.of(context);
    final textTheme = Theme.of(context).extension<AppTextStylesExtension>();
    final selectedIndex = items.indexWhere((item) => item.value == value);
    final index = selectedIndex < 0 ? 0 : selectedIndex;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.neutralBg,
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final segmentWidth = constraints.maxWidth / items.length;
            return Stack(
              children: [
                AnimatedPositioned(
                  duration: AppDesignTokens.animationNormal,
                  curve: Curves.easeOutCubic,
                  left: Directionality.of(context) == TextDirection.rtl
                      ? null
                      : segmentWidth * index,
                  right: Directionality.of(context) == TextDirection.rtl
                      ? segmentWidth * index
                      : null,
                  top: 0,
                  bottom: 0,
                  width: segmentWidth,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: colors.card,
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: colors.cardShadows,
                    ),
                  ),
                ),
                Row(
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
              ],
            );
          },
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
    final colors = AppSemanticColors.of(context);
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: selected ? colors.primary : colors.muted,
        padding: const EdgeInsets.symmetric(vertical: 10),
        minimumSize: const Size(0, 40),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      ),
      child: AnimatedDefaultTextStyle(
        duration: AppDesignTokens.animationNormal,
        curve: Curves.easeOutCubic,
        style: (textStyle ?? const TextStyle()).copyWith(
          color: selected ? colors.primary : colors.muted,
          fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
        ),
        child: Text(item.label, textAlign: TextAlign.center),
      ),
    );
  }
}
