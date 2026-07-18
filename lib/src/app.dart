import 'package:bot_toast/bot_toast.dart';
import 'package:coore/lib.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/constants/environment_variables.dart';
import 'package:qeyadah_mobile_app/src/core/interceptors/headers_interceptor.dart';
import 'package:qeyadah_mobile_app/src/core/offline/presentation/cubit/offline_queue_cubit.dart';
import 'package:qeyadah_mobile_app/src/core/offline/presentation/widgets/offline_queue_banner.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_text_theme_extension.dart';
import 'package:qeyadah_mobile_app/src/core/theme/tokens/app_design_tokens.dart';
import 'package:qeyadah_mobile_app/src/core/ui/message_viewer.dart';

class App extends StatefulWidget {
  const App({super.key, this.forcedLocale});

  final Locale? forcedLocale;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final botToastBuilder = BotToastInit();
  final coreNavigator = getIt<CoreNavigator>();

  @override
  void initState() {
    super.initState();
    if (!kIsWeb && EnvironmentVariables.enableOfflineQueue) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        getIt<OfflineQueueCubit>().initialize();
      });
    }
  }

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
    final app = ThemeWrapper(
      builder: (context, themeConfig) => Builder(
        builder: (context) => LocalizationWrapper(
          builder: (context, currentLocale) {
            final effectiveLocale = _resolveLocale(currentLocale);
            HeadersInterceptor.setLanguageCode(effectiveLocale.languageCode);

            return RefreshConfiguration(
              child: MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: coreNavigator.router,
                scaffoldMessengerKey: appScaffoldMessengerKey,
                theme: _applyLocaleFont(
                  themeConfig.lightTheme,
                  effectiveLocale,
                ),
                darkTheme: _applyLocaleFont(
                  themeConfig.darkTheme,
                  effectiveLocale,
                ),
                themeMode: themeConfig.themeMode,
                localizationsDelegates: context
                    .read<LocalizationCubit>()
                    .delegates,
                locale: effectiveLocale,
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
                  final appShell = _AppShell(child: child);
                  final previewShell = DevicePreview.appBuilder(
                    context,
                    appShell,
                  );

                  return botToastBuilder(
                    context,
                    kIsWeb
                        ? previewShell
                        : NetworkStatusWrapper(child: previewShell),
                  );
                },
              ),
            );
          },
        ),
      ),
    );

    if (kIsWeb || !EnvironmentVariables.enableOfflineQueue) {
      return app;
    }

    return BlocProvider<OfflineQueueCubit>.value(
      value: getIt<OfflineQueueCubit>(),
      child: app,
    );
  }

  Locale _resolveLocale(Locale currentLocale) {
    if (widget.forcedLocale != null) {
      return widget.forcedLocale!;
    }
    return currentLocale;
  }
}

class _AppShell extends StatelessWidget {
  const _AppShell({required this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
          child:
              child ??
              ColoredBox(
                color: Theme.of(context).scaffoldBackgroundColor,
                child: const Center(child: CircularProgressIndicator()),
              ),
        ),
        if (!kIsWeb)
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: OfflineQueueBanner(),
          ),
      ],
    );
  }
}
