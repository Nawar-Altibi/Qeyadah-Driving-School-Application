import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_text_theme_extension.dart';

class AppSectionHeading extends StatelessWidget {
  const AppSectionHeading({
    super.key,
    required this.title,
    this.trailing,
    this.subtitle,
  });

  final String title;
  final Widget? trailing;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final colors = AppSemanticColors.of(context);
    final textTheme = Theme.of(context).extension<AppTextStylesExtension>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    (textTheme?.bold18 ??
                            Theme.of(context).textTheme.titleMedium)
                        ?.copyWith(color: colors.ink),
              ),
              if (subtitle != null)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    subtitle!,
                    style:
                        (textTheme?.regular12 ??
                                Theme.of(context).textTheme.bodySmall)
                            ?.copyWith(color: colors.muted),
                  ),
                ),
            ],
          ),
        ),
        ?trailing,
      ],
    );
  }
}
