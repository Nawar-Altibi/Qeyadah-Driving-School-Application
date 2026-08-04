import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
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
    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onTap : null,
          borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
          child: Ink(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(
                AppDesignTokens.radiusControl,
              ),
              border: Border.all(color: AppColors.line.withValues(alpha: 0.85)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0F153023),
                  blurRadius: 14,
                  offset: Offset(0, 4),
                ),
                BoxShadow(
                  color: Color(0x08153023),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: AppColors.brandMintSoft,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Icon(
                      icon,
                      size: 18,
                      color: AppColors.brandPrimary,
                      // Keep calendar / badge icons from flipping in RTL.
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
                      ),
                    ),
                  ),
                  // Always point left (forward in RTL); never mirror.
                  Icon(
                    PhosphorIconsBold.caretLeft,
                    size: 16,
                    color: AppColors.muted.withValues(alpha: 0.7),
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
