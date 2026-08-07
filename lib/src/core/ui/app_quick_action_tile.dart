import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

class AppQuickActionTile extends StatelessWidget {
  const AppQuickActionTile({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
    this.enabled = true,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
          child: Ink(
            decoration: BoxDecoration(
              color: colors.card,
              borderRadius: BorderRadius.circular(
                AppDesignTokens.radiusControl,
              ),
              border: Border.all(color: colors.line.withValues(alpha: 0.85)),
              boxShadow: colors.cardShadows,
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: colors.brandSoft,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Icon(
                      icon,
                      size: 18,
                      color: colors.primary,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      label,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                        fontSize: 13,
                        color: colors.ink,
                      ),
                    ),
                  ),
                  Icon(
                    PhosphorIconsBold.caretLeft,
                    size: 16,
                    color: colors.muted.withValues(alpha: 0.7),
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
