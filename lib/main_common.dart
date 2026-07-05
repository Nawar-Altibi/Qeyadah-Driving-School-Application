import 'dart:async';

import 'package:coore/lib.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/config/app_config.dart';
import 'package:qeyadah_mobile_app/src/core/config/app_navigation/app_navigation_config.dart';
import 'package:qeyadah_mobile_app/src/core/dependency_injection/dependency_injection.dart';
import 'package:qeyadah_mobile_app/src/core/interceptors/headers_interceptor.dart';
import 'package:qeyadah_mobile_app/src/app.dart';

Future<void> mainCommon(
  CoreEnvironment environment, {
  Locale? forcedLocale,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      availableLocales: const [Locale('ar'), Locale('en')],
      builder: (context) => const _StartupLoadingApp(),
    ),
  );

  try {
    await _initializeApp(environment);
  } catch (error) {
    runApp(
      DevicePreview(
        enabled: !kReleaseMode,
        availableLocales: const [Locale('ar'), Locale('en')],
        builder: (context) => _StartupErrorApp(error: error),
      ),
    );
    return;
  }

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      builder: DevicePreview.appBuilder,
      home: const Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: _BootstrapLoading(),
          ),
        ),
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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: _BootstrapError(error: error),
          ),
        ),
      ),
    );
  }
}

class _BootstrapLoading extends StatelessWidget {
  const _BootstrapLoading();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Qeyadah Mobile',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: 24),
        CircularProgressIndicator(),
      ],
    );
  }
}

class _BootstrapError extends StatelessWidget {
  const _BootstrapError({required this.error});

  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.error_outline, color: Colors.red, size: 40),
        const SizedBox(height: 16),
        const Text(
          'Qeyadah could not start',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        Text(
          error?.toString() ?? 'Unknown startup error',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
