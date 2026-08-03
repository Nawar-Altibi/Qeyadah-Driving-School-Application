import 'package:coore/lib.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qeyadah_mobile_app/l10n/app_localizations.dart';
import 'package:qeyadah_mobile_app/src/core/constants/environment_variables.dart';
import 'package:qeyadah_mobile_app/src/core/interceptors/headers_interceptor.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_theme_data.dart';
import 'package:typed_form_fields/typed_form_fields.dart';

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
    connectTimeout: const Duration(seconds: 15),
    sendTimeout: const Duration(seconds: 45),
    receiveTimeout: const Duration(seconds: 45),
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
      const LocalizationConfigEntity(
        supportedLocales: supportedLocales,
        localizationsDelegates: [
          AppLocalizations.delegate,
          ValidatorLocalizationsDelegate.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        defaultLocale: Locale('ar'),
      );

  ThemeConfigEntity get themeConfigEntity => ThemeConfigEntity(
    themeMode: ThemeMode.system,
    lightTheme: AppThemeData.lightThemeData,
    darkTheme: AppThemeData.darkThemeData,
    enableAutoSwitch: true,
  );

  CoreConfigEntity get configEntity => _configEntity;
}
