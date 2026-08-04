import 'dart:async';

import 'package:coore/lib.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/app.dart';
import 'package:qeyadah_mobile_app/src/core/config/app_config.dart';
import 'package:qeyadah_mobile_app/src/core/config/app_navigation/app_navigation_config.dart';
import 'package:qeyadah_mobile_app/src/core/dependency_injection/dependency_injection.dart';
import 'package:qeyadah_mobile_app/src/core/interceptors/headers_interceptor.dart';
import 'package:qeyadah_mobile_app/src/core/notifications/firebase_bootstrap.dart';
import 'package:qeyadah_mobile_app/src/core/notifications/push_messaging_service.dart';
import 'package:qeyadah_mobile_app/src/core/theme/app_color_schemes.dart';
import 'package:qeyadah_mobile_app/src/core/ui/app_branded_splash.dart';

Future<void> mainCommon(
  CoreEnvironment environment, {
  Locale? forcedLocale,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  // DevicePreview stays available for manual desktop QA, but stays off by
  // default on web so browser automation and real viewport testing work.
  const previewEnabled = bool.fromEnvironment('ENABLE_DEVICE_PREVIEW');

  runApp(
    DevicePreview(
      enabled: previewEnabled,
      availableLocales: const [Locale('ar'), Locale('en')],
      builder: (context) => const _StartupLoadingApp(),
    ),
  );

  await FirebaseBootstrap.ensureInitialized();
  if (FirebaseBootstrap.isReady) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  try {
    await _initializeApp(environment);
  } catch (error) {
    runApp(
      DevicePreview(
        enabled: previewEnabled,
        availableLocales: const [Locale('ar'), Locale('en')],
        builder: (context) => _StartupErrorApp(error: error),
      ),
    );
    return;
  }

  runApp(
    DevicePreview(
      enabled: previewEnabled,
      availableLocales: const [Locale('ar'), Locale('en')],
      builder: (context) => App(forcedLocale: forcedLocale),
    ),
  );
}

Future<void> _initializeApp(CoreEnvironment environment) async {
  if (getIt.isRegistered<EnvironmentConfig>()) {
    await getIt.reset();
  }

  getIt.registerLazySingleton(() => EnvironmentConfig());
  await _runStartupStep(
    'environment',
    () => getIt<EnvironmentConfig>().loadEnv(environment),
  );

  final appConfig = AppConfig(environment);
  await _runStartupStep(
    'core dependencies',
    () => CoreConfig.initializeCoreDependencies(appConfig.configEntity),
  );
  await _runStartupStep('project dependencies', setupProjectDependencies);

  HeadersInterceptor.resetForStartup();
  // Hive + header cache preload must not block startup on web hot restart.
  unawaited(HeadersInterceptor.warmUp());

  await _runStartupStep(
    'navigation',
    () => CoreConfig.initializeCoreDependenciesAfterProjectSetup(
      CoreConfigAfterProjectSetupEntity(
        navigationConfigEntity:
            getIt<AppNavigationConfig>().navigationConfigEntity,
        shouldLog: appConfig.configEntity.shouldLog,
      ),
    ),
  );
}

Future<void> _runStartupStep(
  String label,
  Future<void> Function() action,
) async {
  await action().timeout(
    const Duration(seconds: 8),
    onTimeout: () => throw StateError('Startup timed out during $label'),
  );
}

class _StartupLoadingApp extends StatelessWidget {
  const _StartupLoadingApp();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: Locale('ar'),
      builder: DevicePreview.appBuilder,
      home: Scaffold(
        backgroundColor: AppColors.brandPrimary,
        body: AppBrandedSplash(),
      ),
    );
  }
}

class _StartupErrorApp extends StatelessWidget {
  const _StartupErrorApp({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      builder: DevicePreview.appBuilder,
      home: Scaffold(
        backgroundColor: AppColors.brandPrimary,
        body: AppBrandedSplash(
          showLoader: false,
          errorMessage: error.toString(),
        ),
      ),
    );
  }
}
