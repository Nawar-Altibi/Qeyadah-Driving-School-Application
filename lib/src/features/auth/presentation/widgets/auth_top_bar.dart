import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';

class AuthTopBar extends StatelessWidget {
  const AuthTopBar({
    super.key,
    required this.title,
    this.onBack,
  });

  final String title;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 8),
      child: Row(
        children: [
          if (onBack != null)
            IconButton(
              onPressed: onBack,
              style: IconButton.styleFrom(
                backgroundColor: AppColors.white,
                shape: const CircleBorder(),
                side: const BorderSide(color: AppColors.line),
              ),
              icon: const Icon(
                PhosphorIconsBold.arrowRight,
                color: AppColors.ink,
                size: 20,
              ),
            )
          else
            const SizedBox(width: 48),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}

class AuthHeroIcon extends StatelessWidget {
  const AuthHeroIcon({
    super.key,
    required this.icon,
    this.size = 46,
  });

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.brandMintSoft,
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusControl),
      ),
      child: Icon(icon, color: AppColors.brandPrimary, size: size * 0.48),
    );
  }
}
