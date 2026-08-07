import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

class AppMobileBottomNavItem {
  const AppMobileBottomNavItem({
    required this.id,
    required this.label,
    required this.icon,
  });

  final String id;
  final String label;
  final IconData icon;
}

class AppMobileBottomNav extends StatelessWidget {
  const AppMobileBottomNav({
    super.key,
    required this.items,
    required this.activeId,
    required this.onItemSelected,
  });

  final List<AppMobileBottomNavItem> items;
  final String activeId;
  final ValueChanged<String> onItemSelected;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: colors.card.withValues(alpha: colors.isDark ? 0.96 : 0.94),
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusLg),
        border: Border.all(color: colors.line),
        boxShadow: [
          BoxShadow(
            color: colors.shadow,
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDesignTokens.spacingSm,
          vertical: 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (final item in items)
              _BottomNavButton(
                item: item,
                isActive: item.id == activeId,
                onTap: () => onItemSelected(item.id),
              ),
          ],
        ),
      ),
    );
  }
}

class _BottomNavButton extends StatelessWidget {
  const _BottomNavButton({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final AppMobileBottomNavItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    final color = isActive ? colors.primary : colors.muted;

    return Material(
      color: isActive ? colors.brandSoft : Colors.transparent,
      borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
        child: SizedBox(
          width: 62,
          height: 50,
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (isActive)
                Positioned(
                  top: 4,
                  child: Container(
                    width: 22,
                    height: 3,
                    decoration: BoxDecoration(
                      color: colors.primary,
                      borderRadius: BorderRadius.circular(9),
                    ),
                  ),
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.icon,
                    size: 19,
                    color: color,
                    textDirection: TextDirection.ltr,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.label,
                    style: TextStyle(
                      color: color,
                      fontSize: 8,
                      fontWeight: isActive ? FontWeight.w800 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
