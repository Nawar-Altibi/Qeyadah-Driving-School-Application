import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/constants/environment_variables.dart';
import 'package:qeyadah_mobile_app/src/core/interceptors/headers_interceptor.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_theme_data.dart';

class AppConfig {
  static const List<Locale> supportedLocales = [Locale('en'), Locale('ar')];

  AppConfig(CoreEnvironment environment) {
    _configEntity = CoreConfigEntity(
      currentEnvironment: environment,
      networkConfigEntity: networkConfigEntity,
      localizationConfigEntity: localizationConfigEntity,
      themeConfigEntity: themeConfigEntity,
      shouldLog: environment == CoreEnvironment.development,
      enableSecureStorage: true,
    );
  }

  late final CoreConfigEntity _configEntity;

  NetworkConfigEntity get networkConfigEntity => NetworkConfigEntity(
    baseUrl: EnvironmentVariables.apiBaseUrl,
    enableCache: true,
    authInterceptorType: AuthInterceptorType.tokenBased,
    interceptors: [HeadersInterceptor()],
  );

  LocalizationConfigEntity get localizationConfigEntity =>
      LocalizationConfigEntity(
        supportedLocales: supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        defaultLocale: const Locale('en'),
      );

  ThemeConfigEntity get themeConfigEntity => ThemeConfigEntity(
    themeMode: ThemeMode.system,
    lightTheme: AppThemeData.lightThemeData,
    darkTheme: AppThemeData.darkThemeData,
    enableAutoSwitch: true,
  );

  CoreConfigEntity get configEntity => _configEntity;
}
