import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

class AppCardHeader extends StatelessWidget {
  const AppCardHeader({
    super.key,
    required this.icon,
    required this.title,
    this.badge,
  });

  final IconData icon;
  final String title;
  final Widget? badge;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: colors.brandSoft,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 20, color: colors.primary),
        ),
        const SizedBox(width: AppDesignTokens.spacing),
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 17,
              height: 1.3,
              color: colors.ink,
            ),
          ),
        ),
        if (badge != null) ...[
          const SizedBox(width: AppDesignTokens.spacingSm),
          badge!,
        ],
      ],
    );
  }
}
