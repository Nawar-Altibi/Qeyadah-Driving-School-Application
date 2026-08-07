import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_semantic_colors.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_card.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_segmented_control.dart';

/// Profile appearance control: system / light / dark.
class AppAppearanceSection extends StatelessWidget {
  const AppAppearanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colors = AppSemanticColors.of(context);

    return BlocBuilder<ThemeCubit, ThemeConfigEntity>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, themeState) {
        return AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.appearanceTitle,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: colors.ink,
                ),
              ),
              const SizedBox(height: AppDesignTokens.spacingSm),
              Text(
                l10n.appearanceSubtitle,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: colors.muted),
              ),
              const SizedBox(height: AppDesignTokens.spacing),
              AppSegmentedControl<ThemeMode>(
                value: themeState.themeMode,
                onChanged: (mode) =>
                    context.read<ThemeCubit>().setThemeMode(mode),
                items: [
                  AppSegmentedItem(
                    value: ThemeMode.system,
                    label: l10n.appearanceSystem,
                  ),
                  AppSegmentedItem(
                    value: ThemeMode.light,
                    label: l10n.appearanceLight,
                  ),
                  AppSegmentedItem(
                    value: ThemeMode.dark,
                    label: l10n.appearanceDark,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
