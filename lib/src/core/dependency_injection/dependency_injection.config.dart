// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coore/lib.dart' as _i698;
import 'package:qeyadah_mobile_app/src/core/config/app_navigation/app_navigation_config.dart'
    as _i400;
import 'package:qeyadah_mobile_app/src/core/dependency_injection/modules/local_database_module.dart'
    as _i1050;
import 'package:qeyadah_mobile_app/src/core/offline/data/offline_queue_local_data_source.dart'
    as _i764;
import 'package:qeyadah_mobile_app/src/core/offline/domain/offline_queue_service.dart'
    as _i1042;
import 'package:qeyadah_mobile_app/src/core/offline/presentation/cubit/offline_queue_cubit.dart'
    as _i591;
import 'package:qeyadah_mobile_app/src/features/auth/data/data_sources/auth_local_data_source.dart'
    as _i236;
import 'package:qeyadah_mobile_app/src/features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i633;
import 'package:qeyadah_mobile_app/src/features/auth/data/repositories/auth_repository_impl.dart'
    as _i692;
import 'package:qeyadah_mobile_app/src/features/auth/domain/repositories/auth_repository.dart'
    as _i840;
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/get_persisted_session_use_case.dart'
    as _i254;
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/login_use_case.dart'
    as _i907;
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/logout_use_case.dart'
    as _i384;
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart'
    as _i736;
import 'package:qeyadah_mobile_app/src/features/sample_items/data/repositories/sample_items_repository_impl.dart'
    as _i193;
import 'package:qeyadah_mobile_app/src/features/sample_items/domain/repositories/sample_items_repository.dart'
    as _i9;
import 'package:qeyadah_mobile_app/src/features/sample_items/domain/use_cases/sample_items_use_cases.dart'
    as _i280;
import 'package:qeyadah_mobile_app/src/features/sample_items/presentation/cubit/sample_items_cubit.dart'
    as _i556;
import 'package:qeyadah_mobile_app/src/features/splash/presentation/cubit/splash_screen_cubit.dart'
    as _i995;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final localDatabaseModule = _$LocalDatabaseModule();
    gh.lazySingleton<_i995.SplashScreenCubit>(() => _i995.SplashScreenCubit());
    gh.factory<_i698.LocalDatabaseInterface>(
      () => localDatabaseModule.offlineQueueDatabase,
      instanceName: 'offline_queue',
    );
    gh.lazySingleton<_i633.AuthRemoteDataSource>(
      () => _i633.AuthRemoteDataSourceImpl(),
    );
    gh.factory<_i698.LocalDatabaseInterface>(
      () => localDatabaseModule.authDatabase,
      instanceName: 'auth',
    );
    gh.lazySingleton<_i764.OfflineQueueLocalDataSource>(
      () => _i764.OfflineQueueLocalDataSourceImpl(
        gh<_i698.LocalDatabaseInterface>(instanceName: 'offline_queue'),
      ),
    );
    gh.lazySingleton<_i236.AuthLocalDataSource>(
      () => _i236.AuthLocalDataSourceImpl(gh<_i698.LocalDatabaseInterface>()),
    );
    gh.lazySingleton<_i193.SampleItemsRemoteDataSource>(
      () => _i193.SampleItemsRemoteDataSourceImpl(
        gh<_i698.ApiHandlerInterface>(),
      ),
    );
    gh.lazySingleton<_i840.AuthRepository>(
      () => _i692.AuthRepositoryImpl(
        gh<_i633.AuthRemoteDataSource>(),
        gh<_i236.AuthLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i254.GetPersistedSessionUseCase>(
      () => _i254.GetPersistedSessionUseCase(gh<_i840.AuthRepository>()),
    );
    gh.lazySingleton<_i907.LoginUseCase>(
      () => _i907.LoginUseCase(gh<_i840.AuthRepository>()),
    );
    gh.lazySingleton<_i384.LogoutUseCase>(
      () => _i384.LogoutUseCase(gh<_i840.AuthRepository>()),
    );
    gh.lazySingleton<_i1042.OfflineQueueService>(
      () => _i1042.OfflineQueueService(
        gh<_i764.OfflineQueueLocalDataSource>(),
        gh<_i698.ApiHandlerInterface>(),
        gh<_i698.NetworkStatusInterface>(),
      ),
    );
    gh.lazySingleton<_i591.OfflineQueueCubit>(
      () => _i591.OfflineQueueCubit(
        gh<_i1042.OfflineQueueService>(),
        gh<_i698.NetworkStatusInterface>(),
      ),
    );
    gh.lazySingleton<_i9.SampleItemsRepository>(
      () => _i193.SampleItemsRepositoryImpl(
        gh<_i193.SampleItemsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i736.AuthSessionCubit>(
      () => _i736.AuthSessionCubit(
        gh<_i907.LoginUseCase>(),
        gh<_i384.LogoutUseCase>(),
        gh<_i254.GetPersistedSessionUseCase>(),
      ),
    );
    gh.lazySingleton<_i280.LoadSampleItemsUseCase>(
      () => _i280.LoadSampleItemsUseCase(gh<_i9.SampleItemsRepository>()),
    );
    gh.lazySingleton<_i280.GetSampleItemUseCase>(
      () => _i280.GetSampleItemUseCase(gh<_i9.SampleItemsRepository>()),
    );
    gh.lazySingleton<_i400.AppNavigationConfig>(
      () => _i400.AppNavigationConfig(
        gh<_i736.AuthSessionCubit>(),
        gh<_i995.SplashScreenCubit>(),
      ),
    );
    gh.factory<_i556.SampleItemsCubit>(
      () => _i556.SampleItemsCubit(gh<_i280.LoadSampleItemsUseCase>()),
    );
    gh.factory<_i556.SampleItemDetailsCubit>(
      () => _i556.SampleItemDetailsCubit(gh<_i280.GetSampleItemUseCase>()),
    );
    return this;
  }
}

class _$LocalDatabaseModule extends _i1050.LocalDatabaseModule {}
