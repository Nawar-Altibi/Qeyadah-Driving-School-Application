import 'package:bot_toast/bot_toast.dart';
import 'package:coore/lib.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/offline/presentation/cubit/offline_queue_cubit.dart';
import 'package:qeyadah_mobile_app/src/core/offline/presentation/widgets/offline_queue_banner.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_text_theme_extension.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/message_viewer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class App extends StatefulWidget {
  const App({super.key, this.forcedLocale});

  final Locale? forcedLocale;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final botToastBuilder = BotToastInit();
  final coreNavigator = getIt<CoreNavigator>();

  ThemeData _applyLocaleFont(ThemeData theme, Locale locale) {
    final bodyFontFamily = locale.languageCode == 'ar'
        ? AppFonts.arabicBody
        : AppFonts.englishBody;
    final headingFontFamily = locale.languageCode == 'ar'
        ? AppFonts.arabicHeading
        : AppFonts.englishBody;
    final extension = theme.extension<AppTextStylesExtension>();
    final updatedExtension = extension?.withLocaleFonts(
      bodyFontFamily: bodyFontFamily,
      headingFontFamily: headingFontFamily,
    );
    return theme.copyWith(
      textTheme: theme.textTheme.apply(fontFamily: bodyFontFamily),
      primaryTextTheme: theme.primaryTextTheme.apply(
        fontFamily: headingFontFamily,
      ),
      extensions: updatedExtension == null ? null : [updatedExtension],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OfflineQueueCubit>.value(
      value: getIt<OfflineQueueCubit>(),
      child: ThemeWrapper(
        builder: (context, themeConfig) => LocalizationWrapper(
          builder: (context, currentLocale) => RefreshConfiguration(
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: coreNavigator.router,
              scaffoldMessengerKey: appScaffoldMessengerKey,
              theme: _applyLocaleFont(
                themeConfig.lightTheme,
                widget.forcedLocale ?? currentLocale,
              ),
              darkTheme: _applyLocaleFont(
                themeConfig.darkTheme,
                widget.forcedLocale ?? currentLocale,
              ),
              themeMode: themeConfig.themeMode,
              localizationsDelegates: context
                  .read<LocalizationCubit>()
                  .delegates,
              locale: widget.forcedLocale ?? currentLocale,
              supportedLocales: context
                  .read<LocalizationCubit>()
                  .supportedLocales,
              onGenerateTitle: (context) =>
                  AppLocalizations.of(context).appName,
              scrollBehavior: const MaterialScrollBehavior().copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                },
              ),
              builder: (context, child) {
                return botToastBuilder(
                  context,
                  NetworkStatusWrapper(
                    child: Column(
                      children: [
                        const OfflineQueueBanner(),
                        Expanded(child: child ?? const SizedBox.shrink()),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
