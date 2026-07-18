// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coore/lib.dart' as _i698;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:qeyadah_mobile_app/src/core/config/app_navigation/app_navigation_config.dart'
    as _i820;
import 'package:qeyadah_mobile_app/src/core/dependency_injection/modules/local_database_module.dart'
    as _i990;
import 'package:qeyadah_mobile_app/src/core/offline/data/offline_queue_local_data_source.dart'
    as _i1067;
import 'package:qeyadah_mobile_app/src/core/offline/domain/offline_queue_service.dart'
    as _i208;
import 'package:qeyadah_mobile_app/src/core/offline/presentation/cubit/offline_queue_cubit.dart'
    as _i442;
import 'package:qeyadah_mobile_app/src/features/auth/data/data_sources/auth_local_data_source.dart'
    as _i76;
import 'package:qeyadah_mobile_app/src/features/auth/data/data_sources/auth_remote_data_source.dart'
    as _i1021;
import 'package:qeyadah_mobile_app/src/features/auth/data/repositories/auth_repository_impl.dart'
    as _i516;
import 'package:qeyadah_mobile_app/src/features/auth/domain/repositories/auth_repository.dart'
    as _i16;
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/get_persisted_session_use_case.dart'
    as _i455;
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/login_use_case.dart'
    as _i831;
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/logout_all_use_case.dart'
    as _i280;
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/logout_use_case.dart'
    as _i407;
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/refresh_profile_use_case.dart'
    as _i880;
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/register_student_use_case.dart'
    as _i823;
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/request_password_reset_otp_use_case.dart'
    as _i226;
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/request_registration_otp_use_case.dart'
    as _i852;
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/reset_password_use_case.dart'
    as _i421;
import 'package:qeyadah_mobile_app/src/features/auth/domain/use_cases/verify_password_reset_otp_use_case.dart'
    as _i585;
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart'
    as _i706;
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/password_reset_cubit.dart'
    as _i240;
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/registration_cubit.dart'
    as _i958;
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/dues/cubit/instructor_dues_cubit.dart'
    as _i254;
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/earnings/cubit/instructor_earnings_cubit.dart'
    as _i615;
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/leave/cubit/instructor_leave_cubit.dart'
    as _i686;
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/profile/cubit/instructor_profile_cubit.dart'
    as _i798;
import 'package:qeyadah_mobile_app/src/features/instructor/data/data_sources/instructor_remote_data_source.dart'
    as _i481;
import 'package:qeyadah_mobile_app/src/features/instructor/data/repositories/instructor_repository_impl.dart'
    as _i868;
import 'package:qeyadah_mobile_app/src/features/instructor/domain/repositories/instructor_repository.dart'
    as _i187;
import 'package:qeyadah_mobile_app/src/features/instructor/domain/use_cases/instructor_use_cases.dart'
    as _i44;
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/cubit/instructor_schedule_cubit.dart'
    as _i1020;
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/cubit/instructor_weekly_schedule_cubit.dart'
    as _i160;
import 'package:qeyadah_mobile_app/src/features/sample_items/data/repositories/sample_items_repository_impl.dart'
    as _i272;
import 'package:qeyadah_mobile_app/src/features/sample_items/domain/repositories/sample_items_repository.dart'
    as _i916;
import 'package:qeyadah_mobile_app/src/features/sample_items/domain/use_cases/sample_items_use_cases.dart'
    as _i38;
import 'package:qeyadah_mobile_app/src/features/sample_items/presentation/cubit/sample_items_cubit.dart'
    as _i60;
import 'package:qeyadah_mobile_app/src/features/splash/presentation/cubit/splash_screen_cubit.dart'
    as _i127;
import 'package:qeyadah_mobile_app/src/features/student_home/data/repositories/student_home_repository_impl.dart'
    as _i502;
import 'package:qeyadah_mobile_app/src/features/student_home/domain/repositories/student_home_repository.dart'
    as _i80;
import 'package:qeyadah_mobile_app/src/features/student_home/domain/use_cases/load_student_home_use_case.dart'
    as _i869;
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/cubit/student_home_cubit.dart'
    as _i876;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final localDatabaseModule = _$LocalDatabaseModule();
    gh.lazySingleton<_i127.SplashScreenCubit>(() => _i127.SplashScreenCubit());
    gh.factory<_i698.LocalDatabaseInterface>(
      () => localDatabaseModule.offlineQueueDatabase,
      instanceName: 'offline_queue',
    );
    gh.lazySingleton<_i502.StudentHomeRemoteDataSource>(
      () => _i502.StudentHomeRemoteDataSourceImpl(),
    );
    gh.factory<_i698.LocalDatabaseInterface>(
      () => localDatabaseModule.authDatabase,
      instanceName: 'auth',
    );
    gh.lazySingleton<_i76.AuthLocalDataSource>(
      () => _i76.AuthLocalDataSourceImpl(
        gh<_i698.LocalDatabaseInterface>(instanceName: 'auth'),
      ),
    );
    gh.lazySingleton<_i1067.OfflineQueueLocalDataSource>(
      () => _i1067.OfflineQueueLocalDataSourceImpl(
        gh<_i698.LocalDatabaseInterface>(instanceName: 'offline_queue'),
      ),
    );
    gh.lazySingleton<_i80.StudentHomeRepository>(
      () => _i502.StudentHomeRepositoryImpl(
        gh<_i502.StudentHomeRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i272.SampleItemsRemoteDataSource>(
      () => _i272.SampleItemsRemoteDataSourceImpl(
        gh<_i698.ApiHandlerInterface>(),
      ),
    );
    gh.lazySingleton<_i1021.AuthRemoteDataSource>(
      () => _i1021.AuthRemoteDataSourceImpl(gh<_i698.ApiHandlerInterface>()),
    );
    gh.lazySingleton<_i481.InstructorRemoteDataSource>(
      () =>
          _i481.InstructorRemoteDataSourceImpl(gh<_i698.ApiHandlerInterface>()),
    );
    gh.lazySingleton<_i869.LoadStudentHomeUseCase>(
      () => _i869.LoadStudentHomeUseCase(gh<_i80.StudentHomeRepository>()),
    );
    gh.factory<_i876.StudentHomeCubit>(
      () => _i876.StudentHomeCubit(gh<_i869.LoadStudentHomeUseCase>()),
    );
    gh.lazySingleton<_i16.AuthRepository>(
      () => _i516.AuthRepositoryImpl(
        gh<_i1021.AuthRemoteDataSource>(),
        gh<_i76.AuthLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i187.InstructorRepository>(
      () => _i868.InstructorRepositoryImpl(
        gh<_i481.InstructorRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i916.SampleItemsRepository>(
      () => _i272.SampleItemsRepositoryImpl(
        gh<_i272.SampleItemsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i208.OfflineQueueService>(
      () => _i208.OfflineQueueService(
        gh<_i1067.OfflineQueueLocalDataSource>(),
        gh<_i698.ApiHandlerInterface>(),
        gh<_i698.NetworkStatusInterface>(),
      ),
    );
    gh.lazySingleton<_i442.OfflineQueueCubit>(
      () => _i442.OfflineQueueCubit(
        gh<_i208.OfflineQueueService>(),
        gh<_i698.NetworkStatusInterface>(),
      ),
    );
    gh.lazySingleton<_i455.GetPersistedSessionUseCase>(
      () => _i455.GetPersistedSessionUseCase(gh<_i16.AuthRepository>()),
    );
    gh.lazySingleton<_i831.LoginUseCase>(
      () => _i831.LoginUseCase(gh<_i16.AuthRepository>()),
    );
    gh.lazySingleton<_i280.LogoutAllUseCase>(
      () => _i280.LogoutAllUseCase(gh<_i16.AuthRepository>()),
    );
    gh.lazySingleton<_i407.LogoutUseCase>(
      () => _i407.LogoutUseCase(gh<_i16.AuthRepository>()),
    );
    gh.lazySingleton<_i880.RefreshProfileUseCase>(
      () => _i880.RefreshProfileUseCase(gh<_i16.AuthRepository>()),
    );
    gh.lazySingleton<_i823.RegisterStudentUseCase>(
      () => _i823.RegisterStudentUseCase(gh<_i16.AuthRepository>()),
    );
    gh.lazySingleton<_i226.RequestPasswordResetOtpUseCase>(
      () => _i226.RequestPasswordResetOtpUseCase(gh<_i16.AuthRepository>()),
    );
    gh.lazySingleton<_i852.RequestRegistrationOtpUseCase>(
      () => _i852.RequestRegistrationOtpUseCase(gh<_i16.AuthRepository>()),
    );
    gh.lazySingleton<_i421.ResetPasswordUseCase>(
      () => _i421.ResetPasswordUseCase(gh<_i16.AuthRepository>()),
    );
    gh.lazySingleton<_i585.VerifyPasswordResetOtpUseCase>(
      () => _i585.VerifyPasswordResetOtpUseCase(gh<_i16.AuthRepository>()),
    );
    gh.factory<_i44.LoadInstructorScheduleUseCase>(
      () =>
          _i44.LoadInstructorScheduleUseCase(gh<_i187.InstructorRepository>()),
    );
    gh.factory<_i44.LoadInstructorProfileUseCase>(
      () => _i44.LoadInstructorProfileUseCase(gh<_i187.InstructorRepository>()),
    );
    gh.factory<_i44.LoadInstructorLeavesUseCase>(
      () => _i44.LoadInstructorLeavesUseCase(gh<_i187.InstructorRepository>()),
    );
    gh.factory<_i44.LoadInstructorWeeklyScheduleUseCase>(
      () => _i44.LoadInstructorWeeklyScheduleUseCase(
        gh<_i187.InstructorRepository>(),
      ),
    );
    gh.factory<_i44.LoadInstructorDuesUseCase>(
      () => _i44.LoadInstructorDuesUseCase(gh<_i187.InstructorRepository>()),
    );
    gh.factory<_i44.LoadInstructorEarningsUseCase>(
      () =>
          _i44.LoadInstructorEarningsUseCase(gh<_i187.InstructorRepository>()),
    );
    gh.factory<_i44.LoadInstructorDayBookingsUseCase>(
      () => _i44.LoadInstructorDayBookingsUseCase(
        gh<_i187.InstructorRepository>(),
      ),
    );
    gh.lazySingleton<_i706.AuthSessionCubit>(
      () => _i706.AuthSessionCubit(
        gh<_i831.LoginUseCase>(),
        gh<_i407.LogoutUseCase>(),
        gh<_i280.LogoutAllUseCase>(),
        gh<_i455.GetPersistedSessionUseCase>(),
        gh<_i880.RefreshProfileUseCase>(),
      ),
    );
    gh.factory<_i798.InstructorProfileCubit>(
      () =>
          _i798.InstructorProfileCubit(gh<_i44.LoadInstructorProfileUseCase>()),
    );
    gh.factory<_i615.InstructorEarningsCubit>(
      () => _i615.InstructorEarningsCubit(
        gh<_i44.LoadInstructorEarningsUseCase>(),
      ),
    );
    gh.factory<_i160.InstructorWeeklyScheduleCubit>(
      () => _i160.InstructorWeeklyScheduleCubit(
        gh<_i44.LoadInstructorWeeklyScheduleUseCase>(),
      ),
    );
    gh.factory<_i1020.InstructorScheduleCubit>(
      () => _i1020.InstructorScheduleCubit(
        gh<_i44.LoadInstructorScheduleUseCase>(),
      ),
    );
    gh.lazySingleton<_i38.LoadSampleItemsUseCase>(
      () => _i38.LoadSampleItemsUseCase(gh<_i916.SampleItemsRepository>()),
    );
    gh.lazySingleton<_i38.GetSampleItemUseCase>(
      () => _i38.GetSampleItemUseCase(gh<_i916.SampleItemsRepository>()),
    );
    gh.lazySingleton<_i820.AppNavigationConfig>(
      () => _i820.AppNavigationConfig(
        gh<_i706.AuthSessionCubit>(),
        gh<_i127.SplashScreenCubit>(),
      ),
    );
    gh.factory<_i958.RegistrationCubit>(
      () => _i958.RegistrationCubit(
        gh<_i852.RequestRegistrationOtpUseCase>(),
        gh<_i823.RegisterStudentUseCase>(),
      ),
    );
    gh.factory<_i686.InstructorLeaveCubit>(
      () => _i686.InstructorLeaveCubit(gh<_i44.LoadInstructorLeavesUseCase>()),
    );
    gh.factory<_i254.InstructorDuesCubit>(
      () => _i254.InstructorDuesCubit(gh<_i44.LoadInstructorDuesUseCase>()),
    );
    gh.factory<_i240.PasswordResetCubit>(
      () => _i240.PasswordResetCubit(
        gh<_i226.RequestPasswordResetOtpUseCase>(),
        gh<_i585.VerifyPasswordResetOtpUseCase>(),
        gh<_i421.ResetPasswordUseCase>(),
      ),
    );
    gh.factory<_i60.SampleItemDetailsCubit>(
      () => _i60.SampleItemDetailsCubit(gh<_i38.GetSampleItemUseCase>()),
    );
    gh.factory<_i60.SampleItemsCubit>(
      () => _i60.SampleItemsCubit(gh<_i38.LoadSampleItemsUseCase>()),
    );
    return this;
  }
}

class _$LocalDatabaseModule extends _i990.LocalDatabaseModule {}
