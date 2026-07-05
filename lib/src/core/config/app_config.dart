import 'package:coore/lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:typed_form_fields/typed_form_fields.dart';
import 'package:qeyadah_mobile_app/src/core/constants/environment_variables.dart';
import 'package:qeyadah_mobile_app/src/core/interceptors/headers_interceptor.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_theme_data.dart';

class AppConfig {
  static const List<Locale> supportedLocales = [Locale('ar'), Locale('en')];

  AppConfig(CoreEnvironment environment) {
    _configEntity = CoreConfigEntity(
      currentEnvironment: environment,
      networkConfigEntity: networkConfigEntity,
      localizationConfigEntity: localizationConfigEntity,
      themeConfigEntity: themeConfigEntity,
      shouldLog: environment == CoreEnvironment.development,
      enableSecureStorage: !kIsWeb,
    );
  }

  late final CoreConfigEntity _configEntity;

  NetworkConfigEntity get networkConfigEntity => NetworkConfigEntity(
    baseUrl: EnvironmentVariables.apiBaseUrl,
    enableCache: false,
    connectTimeout: const Duration(seconds: 15),
    sendTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    staticHeaders: const {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Accept-Language': 'ar',
      'X-Requested-With': 'XMLHttpRequest',
    },
    authInterceptorType: AuthInterceptorType.tokenBased,
    interceptors: [HeadersInterceptor()],
  );

  LocalizationConfigEntity get localizationConfigEntity =>
      LocalizationConfigEntity(
        supportedLocales: supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          ValidatorLocalizationsDelegate.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        defaultLocale: const Locale('ar'),
      );

  ThemeConfigEntity get themeConfigEntity => ThemeConfigEntity(
    themeMode: ThemeMode.system,
    lightTheme: AppThemeData.lightThemeData,
    darkTheme: AppThemeData.darkThemeData,
    enableAutoSwitch: true,
  );

  CoreConfigEntity get configEntity => _configEntity;
}
