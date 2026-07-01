import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:qeyadah_mobile_app/src/core/config/app_config.dart';
import 'package:qeyadah_mobile_app/src/core/config/app_navigation/app_navigation_config.dart';
import 'package:qeyadah_mobile_app/src/core/constants/environment_variables.dart';
import 'package:qeyadah_mobile_app/src/core/dependency_injection/dependency_injection.dart';
import 'package:qeyadah_mobile_app/src/core/offline/presentation/cubit/offline_queue_cubit.dart';
import 'package:qeyadah_mobile_app/src/app.dart';

Future<void> mainCommon(
  CoreEnvironment environment, {
  Locale? forcedLocale,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerLazySingleton(() => EnvironmentConfig());
  await getIt<EnvironmentConfig>().loadEnv(environment);

  final appConfig = AppConfig(environment);
  await CoreConfig.initializeCoreDependencies(appConfig.configEntity);
  await setupProjectDependencies();

  await CoreConfig.initializeCoreDependenciesAfterProjectSetup(
    CoreConfigAfterProjectSetupEntity(
      navigationConfigEntity:
          getIt<AppNavigationConfig>().navigationConfigEntity,
      shouldLog: appConfig.configEntity.shouldLog,
    ),
  );

  if (EnvironmentVariables.enableOfflineQueue) {
    await getIt<OfflineQueueCubit>().initialize();
  }

  runApp(App(forcedLocale: forcedLocale));
}
