// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:coore/lib.dart' as _i698;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:qeyadah_mobile_app/src/core/config/app_navigation/app_navigation_config.dart'
    as _i820;
import 'package:qeyadah_mobile_app/src/core/dependency_injection/modules/local_database_module.dart'
    as _i990;
import 'package:qeyadah_mobile_app/src/core/notifications/push_messaging_service.dart'
    as _i941;
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
import 'package:qeyadah_mobile_app/src/features/instructor/data/data_sources/instructor_local_data_source.dart'
    as _i393;
import 'package:qeyadah_mobile_app/src/features/instructor/data/data_sources/instructor_remote_data_source.dart'
    as _i348;
import 'package:qeyadah_mobile_app/src/features/instructor/data/repositories/instructor_repository_impl.dart'
    as _i461;
import 'package:qeyadah_mobile_app/src/features/instructor/domain/repositories/instructor_repository.dart'
    as _i90;
import 'package:qeyadah_mobile_app/src/features/instructor/domain/use_cases/instructor_use_cases.dart'
    as _i648;
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/dues/cubit/instructor_dues_cubit.dart'
    as _i434;
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/earnings/cubit/instructor_earnings_cubit.dart'
    as _i905;
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/invoices/cubit/instructor_invoices_cubit.dart'
    as _i161;
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/leave/cubit/instructor_leave_cubit.dart'
    as _i330;
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/profile/cubit/instructor_profile_cubit.dart'
    as _i139;
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/cubit/instructor_schedule_cubit.dart'
    as _i1027;
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/cubit/instructor_weekly_schedule_cubit.dart'
    as _i143;
import 'package:qeyadah_mobile_app/src/features/notifications/data/data_sources/notifications_remote_data_source.dart'
    as _i809;
import 'package:qeyadah_mobile_app/src/features/notifications/data/repositories/notifications_repository_impl.dart'
    as _i37;
import 'package:qeyadah_mobile_app/src/features/notifications/domain/repositories/notifications_repository.dart'
    as _i1034;
import 'package:qeyadah_mobile_app/src/features/notifications/domain/use_cases/notifications_use_cases.dart'
    as _i612;
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/coordinators/push_notifications_coordinator.dart'
    as _i1029;
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/cubit/notifications_inbox_cubit.dart'
    as _i404;
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/cubit/notifications_unread_cubit.dart'
    as _i188;
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/navigation/notification_deep_link_router.dart'
    as _i836;
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
import 'package:qeyadah_mobile_app/src/features/student_booking/data/data_sources/student_booking_local_data_source.dart'
    as _i509;
import 'package:qeyadah_mobile_app/src/features/student_booking/data/data_sources/student_booking_remote_data_source.dart'
    as _i795;
import 'package:qeyadah_mobile_app/src/features/student_booking/data/repositories/student_booking_repository_impl.dart'
    as _i253;
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/repositories/student_booking_repository.dart'
    as _i151;
import 'package:qeyadah_mobile_app/src/features/student_booking/domain/use_cases/student_booking_use_cases.dart'
    as _i843;
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/cubit/student_booking_cubit.dart'
    as _i1016;
import 'package:qeyadah_mobile_app/src/features/student_bookings/data/data_sources/student_bookings_remote_data_source.dart'
    as _i14;
import 'package:qeyadah_mobile_app/src/features/student_bookings/data/repositories/student_bookings_repository_impl.dart'
    as _i568;
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/repositories/student_bookings_repository.dart'
    as _i770;
import 'package:qeyadah_mobile_app/src/features/student_bookings/domain/use_cases/student_bookings_use_cases.dart'
    as _i981;
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/cubit/student_booking_detail_cubit.dart'
    as _i207;
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/cubit/student_bookings_list_cubit.dart'
    as _i611;
import 'package:qeyadah_mobile_app/src/features/student_certificates/data/data_sources/student_certificates_local_data_source.dart'
    as _i512;
import 'package:qeyadah_mobile_app/src/features/student_certificates/data/data_sources/student_certificates_remote_data_source.dart'
    as _i320;
import 'package:qeyadah_mobile_app/src/features/student_certificates/data/repositories/student_certificates_repository_impl.dart'
    as _i1058;
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/repositories/student_certificates_repository.dart'
    as _i892;
import 'package:qeyadah_mobile_app/src/features/student_certificates/domain/use_cases/student_certificates_use_cases.dart'
    as _i390;
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificate_detail_cubit.dart'
    as _i582;
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificate_write_cubit.dart'
    as _i89;
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificates_hub_cubit.dart'
    as _i489;
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificates_list_cubit.dart'
    as _i323;
import 'package:qeyadah_mobile_app/src/features/student_home/data/repositories/student_home_repository_impl.dart'
    as _i502;
import 'package:qeyadah_mobile_app/src/features/student_home/domain/repositories/student_home_repository.dart'
    as _i80;
import 'package:qeyadah_mobile_app/src/features/student_home/domain/use_cases/load_student_home_use_case.dart'
    as _i869;
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/cubit/student_home_cubit.dart'
    as _i876;
import 'package:qeyadah_mobile_app/src/features/student_payments/data/data_sources/student_payment_remote_data_source.dart'
    as _i371;
import 'package:qeyadah_mobile_app/src/features/student_payments/data/repositories/student_payment_repository_impl.dart'
    as _i293;
import 'package:qeyadah_mobile_app/src/features/student_payments/domain/repositories/student_payment_repository.dart'
    as _i955;
import 'package:qeyadah_mobile_app/src/features/student_payments/domain/use_cases/student_payment_use_cases.dart'
    as _i660;
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/cubit/student_payment_cubit.dart'
    as _i696;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final localDatabaseModule = _$LocalDatabaseModule();
    gh.lazySingleton<_i941.LocalNotificationPresenter>(
      () => _i941.LocalNotificationPresenter(),
    );
    gh.lazySingleton<_i836.NotificationDeepLinkRouter>(
      () => const _i836.NotificationDeepLinkRouter(),
    );
    gh.lazySingleton<_i127.SplashScreenCubit>(() => _i127.SplashScreenCubit());
    gh.factory<_i698.LocalDatabaseInterface>(
      () => localDatabaseModule.offlineQueueDatabase,
      instanceName: 'offline_queue',
    );
    gh.lazySingleton<_i941.PushMessagingService>(
      () => _i941.PushMessagingService(gh<_i941.LocalNotificationPresenter>()),
    );
    gh.lazySingleton<_i809.NotificationsRemoteDataSource>(
      () => _i809.NotificationsRemoteDataSourceImpl(
        gh<_i698.ApiHandlerInterface>(),
        gh<_i361.Dio>(),
        gh<_i698.NetworkExceptionMapper>(),
      ),
    );
    gh.factory<_i698.LocalDatabaseInterface>(
      () => localDatabaseModule.authDatabase,
      instanceName: 'auth',
    );
    gh.lazySingleton<_i393.InstructorLocalDataSource>(
      () => _i393.InstructorLocalDataSourceImpl(
        gh<_i698.LocalDatabaseInterface>(instanceName: 'auth'),
      ),
    );
    gh.lazySingleton<_i76.AuthLocalDataSource>(
      () => _i76.AuthLocalDataSourceImpl(
        gh<_i698.LocalDatabaseInterface>(instanceName: 'auth'),
      ),
    );
    gh.lazySingleton<_i371.StudentPaymentRemoteDataSource>(
      () => _i371.StudentPaymentRemoteDataSourceImpl(
        gh<_i698.ApiHandlerInterface>(),
      ),
    );
    gh.lazySingleton<_i795.StudentBookingRemoteDataSource>(
      () => _i795.StudentBookingRemoteDataSourceImpl(
        gh<_i698.ApiHandlerInterface>(),
      ),
    );
    gh.lazySingleton<_i1067.OfflineQueueLocalDataSource>(
      () => _i1067.OfflineQueueLocalDataSourceImpl(
        gh<_i698.LocalDatabaseInterface>(instanceName: 'offline_queue'),
      ),
    );
    gh.lazySingleton<_i348.InstructorRemoteDataSource>(
      () =>
          _i348.InstructorRemoteDataSourceImpl(gh<_i698.ApiHandlerInterface>()),
    );
    gh.lazySingleton<_i272.SampleItemsRemoteDataSource>(
      () => _i272.SampleItemsRemoteDataSourceImpl(
        gh<_i698.ApiHandlerInterface>(),
      ),
    );
    gh.lazySingleton<_i1021.AuthRemoteDataSource>(
      () => _i1021.AuthRemoteDataSourceImpl(gh<_i698.ApiHandlerInterface>()),
    );
    gh.lazySingleton<_i14.StudentBookingsRemoteDataSource>(
      () => _i14.StudentBookingsRemoteDataSourceImpl(
        gh<_i698.ApiHandlerInterface>(),
      ),
    );
    gh.lazySingleton<_i320.StudentCertificatesRemoteDataSource>(
      () => _i320.StudentCertificatesRemoteDataSourceImpl(
        gh<_i698.ApiHandlerInterface>(),
      ),
    );
    gh.lazySingleton<_i16.AuthRepository>(
      () => _i516.AuthRepositoryImpl(
        gh<_i1021.AuthRemoteDataSource>(),
        gh<_i76.AuthLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i1034.NotificationsRepository>(
      () => _i37.NotificationsRepositoryImpl(
        gh<_i809.NotificationsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i512.StudentCertificatesLocalDataSource>(
      () => _i512.StudentCertificatesLocalDataSourceImpl(
        gh<_i698.LocalDatabaseInterface>(instanceName: 'auth'),
      ),
    );
    gh.lazySingleton<_i90.InstructorRepository>(
      () => _i461.InstructorRepositoryImpl(
        gh<_i348.InstructorRemoteDataSource>(),
        gh<_i393.InstructorLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i509.StudentBookingLocalDataSource>(
      () => _i509.StudentBookingLocalDataSourceImpl(
        gh<_i698.LocalDatabaseInterface>(instanceName: 'auth'),
      ),
    );
    gh.lazySingleton<_i916.SampleItemsRepository>(
      () => _i272.SampleItemsRepositoryImpl(
        gh<_i272.SampleItemsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i770.StudentBookingsRepository>(
      () => _i568.StudentBookingsRepositoryImpl(
        gh<_i14.StudentBookingsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i208.OfflineQueueService>(
      () => _i208.OfflineQueueService(
        gh<_i1067.OfflineQueueLocalDataSource>(),
        gh<_i698.ApiHandlerInterface>(),
        gh<_i698.NetworkStatusInterface>(),
      ),
    );
    gh.factory<_i648.LoadInstructorScheduleUseCase>(
      () =>
          _i648.LoadInstructorScheduleUseCase(gh<_i90.InstructorRepository>()),
    );
    gh.factory<_i648.LoadInstructorProfileUseCase>(
      () => _i648.LoadInstructorProfileUseCase(gh<_i90.InstructorRepository>()),
    );
    gh.factory<_i648.LoadInstructorLeavesUseCase>(
      () => _i648.LoadInstructorLeavesUseCase(gh<_i90.InstructorRepository>()),
    );
    gh.factory<_i648.LoadInstructorWeeklyScheduleUseCase>(
      () => _i648.LoadInstructorWeeklyScheduleUseCase(
        gh<_i90.InstructorRepository>(),
      ),
    );
    gh.factory<_i648.InvalidateInstructorWeeklyScheduleCacheUseCase>(
      () => _i648.InvalidateInstructorWeeklyScheduleCacheUseCase(
        gh<_i90.InstructorRepository>(),
      ),
    );
    gh.factory<_i648.LoadInstructorDuesUseCase>(
      () => _i648.LoadInstructorDuesUseCase(gh<_i90.InstructorRepository>()),
    );
    gh.factory<_i648.LoadInstructorEarningsUseCase>(
      () =>
          _i648.LoadInstructorEarningsUseCase(gh<_i90.InstructorRepository>()),
    );
    gh.factory<_i648.LoadInstructorDayBookingsUseCase>(
      () => _i648.LoadInstructorDayBookingsUseCase(
        gh<_i90.InstructorRepository>(),
      ),
    );
    gh.factory<_i648.LoadInstructorInvoicesUseCase>(
      () =>
          _i648.LoadInstructorInvoicesUseCase(gh<_i90.InstructorRepository>()),
    );
    gh.factory<_i161.InstructorInvoicesCubit>(
      () => _i161.InstructorInvoicesCubit(
        gh<_i648.LoadInstructorInvoicesUseCase>(),
      ),
    );
    gh.lazySingleton<_i892.StudentCertificatesRepository>(
      () => _i1058.StudentCertificatesRepositoryImpl(
        gh<_i320.StudentCertificatesRemoteDataSource>(),
      ),
    );
    gh.factory<_i1027.InstructorScheduleCubit>(
      () => _i1027.InstructorScheduleCubit(
        gh<_i648.LoadInstructorScheduleUseCase>(),
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
    gh.factory<_i143.InstructorWeeklyScheduleCubit>(
      () => _i143.InstructorWeeklyScheduleCubit(
        gh<_i648.LoadInstructorWeeklyScheduleUseCase>(),
      ),
    );
    gh.factory<_i612.LoadNotificationsUseCase>(
      () =>
          _i612.LoadNotificationsUseCase(gh<_i1034.NotificationsRepository>()),
    );
    gh.factory<_i612.LoadUnreadNotificationsCountUseCase>(
      () => _i612.LoadUnreadNotificationsCountUseCase(
        gh<_i1034.NotificationsRepository>(),
      ),
    );
    gh.factory<_i612.MarkNotificationReadUseCase>(
      () => _i612.MarkNotificationReadUseCase(
        gh<_i1034.NotificationsRepository>(),
      ),
    );
    gh.factory<_i612.MarkAllNotificationsReadUseCase>(
      () => _i612.MarkAllNotificationsReadUseCase(
        gh<_i1034.NotificationsRepository>(),
      ),
    );
    gh.factory<_i612.RegisterDeviceTokenUseCase>(
      () => _i612.RegisterDeviceTokenUseCase(
        gh<_i1034.NotificationsRepository>(),
      ),
    );
    gh.factory<_i612.UnregisterDeviceTokenUseCase>(
      () => _i612.UnregisterDeviceTokenUseCase(
        gh<_i1034.NotificationsRepository>(),
      ),
    );
    gh.factory<_i139.InstructorProfileCubit>(
      () => _i139.InstructorProfileCubit(
        gh<_i648.LoadInstructorProfileUseCase>(),
      ),
    );
    gh.lazySingleton<_i188.NotificationsUnreadCubit>(
      () => _i188.NotificationsUnreadCubit(
        gh<_i612.LoadUnreadNotificationsCountUseCase>(),
      ),
    );
    gh.lazySingleton<_i151.StudentBookingRepository>(
      () => _i253.StudentBookingRepositoryImpl(
        gh<_i795.StudentBookingRemoteDataSource>(),
        gh<_i509.StudentBookingLocalDataSource>(),
      ),
    );
    gh.factory<_i905.InstructorEarningsCubit>(
      () => _i905.InstructorEarningsCubit(
        gh<_i648.LoadInstructorEarningsUseCase>(),
      ),
    );
    gh.factory<_i981.LoadStudentBookingsUseCase>(
      () => _i981.LoadStudentBookingsUseCase(
        gh<_i770.StudentBookingsRepository>(),
      ),
    );
    gh.factory<_i981.LoadStudentBookingDetailUseCase>(
      () => _i981.LoadStudentBookingDetailUseCase(
        gh<_i770.StudentBookingsRepository>(),
      ),
    );
    gh.factory<_i981.CancelStudentBookingUseCase>(
      () => _i981.CancelStudentBookingUseCase(
        gh<_i770.StudentBookingsRepository>(),
      ),
    );
    gh.factory<_i611.StudentBookingsListCubit>(
      () => _i611.StudentBookingsListCubit(
        gh<_i981.LoadStudentBookingsUseCase>(),
      ),
    );
    gh.factory<_i843.LoadStudentAvailableSlotsUseCase>(
      () => _i843.LoadStudentAvailableSlotsUseCase(
        gh<_i151.StudentBookingRepository>(),
      ),
    );
    gh.factory<_i843.CreateStudentBookingUseCase>(
      () => _i843.CreateStudentBookingUseCase(
        gh<_i151.StudentBookingRepository>(),
      ),
    );
    gh.factory<_i843.GetPendingStudentBookingHoldUseCase>(
      () => _i843.GetPendingStudentBookingHoldUseCase(
        gh<_i151.StudentBookingRepository>(),
      ),
    );
    gh.factory<_i958.RegistrationCubit>(
      () => _i958.RegistrationCubit(
        gh<_i852.RequestRegistrationOtpUseCase>(),
        gh<_i823.RegisterStudentUseCase>(),
        gh<_i941.PushMessagingService>(),
      ),
    );
    gh.factory<_i207.StudentBookingDetailCubit>(
      () => _i207.StudentBookingDetailCubit(
        gh<_i981.LoadStudentBookingDetailUseCase>(),
        gh<_i981.CancelStudentBookingUseCase>(),
        gh<_i151.StudentBookingRepository>(),
      ),
    );
    gh.factory<_i390.LoadCertificateEligibilityUseCase>(
      () => _i390.LoadCertificateEligibilityUseCase(
        gh<_i892.StudentCertificatesRepository>(),
      ),
    );
    gh.factory<_i390.LoadStudentCertificatesUseCase>(
      () => _i390.LoadStudentCertificatesUseCase(
        gh<_i892.StudentCertificatesRepository>(),
      ),
    );
    gh.factory<_i390.LoadStudentCertificateDetailUseCase>(
      () => _i390.LoadStudentCertificateDetailUseCase(
        gh<_i892.StudentCertificatesRepository>(),
      ),
    );
    gh.factory<_i390.SubmitStudentCertificateUseCase>(
      () => _i390.SubmitStudentCertificateUseCase(
        gh<_i892.StudentCertificatesRepository>(),
      ),
    );
    gh.factory<_i390.SubmitStudentCertificateReexamUseCase>(
      () => _i390.SubmitStudentCertificateReexamUseCase(
        gh<_i892.StudentCertificatesRepository>(),
      ),
    );
    gh.factory<_i89.StudentCertificateWriteCubit>(
      () => _i89.StudentCertificateWriteCubit(
        gh<_i390.LoadCertificateEligibilityUseCase>(),
        gh<_i390.SubmitStudentCertificateUseCase>(),
        gh<_i390.SubmitStudentCertificateReexamUseCase>(),
        gh<_i512.StudentCertificatesLocalDataSource>(),
      ),
    );
    gh.factory<_i330.InstructorLeaveCubit>(
      () => _i330.InstructorLeaveCubit(gh<_i648.LoadInstructorLeavesUseCase>()),
    );
    gh.lazySingleton<_i1029.PushNotificationsCoordinator>(
      () => _i1029.PushNotificationsCoordinator(
        gh<_i941.PushMessagingService>(),
        gh<_i612.RegisterDeviceTokenUseCase>(),
        gh<_i612.UnregisterDeviceTokenUseCase>(),
        gh<_i188.NotificationsUnreadCubit>(),
        gh<_i836.NotificationDeepLinkRouter>(),
        gh<_i648.InvalidateInstructorWeeklyScheduleCacheUseCase>(),
      ),
    );
    gh.factory<_i434.InstructorDuesCubit>(
      () => _i434.InstructorDuesCubit(gh<_i648.LoadInstructorDuesUseCase>()),
    );
    gh.lazySingleton<_i38.LoadSampleItemsUseCase>(
      () => _i38.LoadSampleItemsUseCase(gh<_i916.SampleItemsRepository>()),
    );
    gh.lazySingleton<_i38.GetSampleItemUseCase>(
      () => _i38.GetSampleItemUseCase(gh<_i916.SampleItemsRepository>()),
    );
    gh.lazySingleton<_i80.StudentHomeRepository>(
      () => _i502.StudentHomeRepositoryImpl(
        gh<_i981.LoadStudentBookingsUseCase>(),
        gh<_i981.LoadStudentBookingDetailUseCase>(),
        gh<_i843.GetPendingStudentBookingHoldUseCase>(),
        gh<_i612.LoadUnreadNotificationsCountUseCase>(),
      ),
    );
    gh.factory<_i582.StudentCertificateDetailCubit>(
      () => _i582.StudentCertificateDetailCubit(
        gh<_i390.LoadStudentCertificateDetailUseCase>(),
      ),
    );
    gh.factory<_i489.StudentCertificatesHubCubit>(
      () => _i489.StudentCertificatesHubCubit(
        gh<_i390.LoadCertificateEligibilityUseCase>(),
      ),
    );
    gh.factory<_i1016.StudentBookingCubit>(
      () => _i1016.StudentBookingCubit(
        gh<_i843.LoadStudentAvailableSlotsUseCase>(),
        gh<_i843.CreateStudentBookingUseCase>(),
      ),
    );
    gh.factory<_i240.PasswordResetCubit>(
      () => _i240.PasswordResetCubit(
        gh<_i226.RequestPasswordResetOtpUseCase>(),
        gh<_i585.VerifyPasswordResetOtpUseCase>(),
        gh<_i421.ResetPasswordUseCase>(),
      ),
    );
    gh.lazySingleton<_i869.LoadStudentHomeUseCase>(
      () => _i869.LoadStudentHomeUseCase(gh<_i80.StudentHomeRepository>()),
    );
    gh.factory<_i60.SampleItemDetailsCubit>(
      () => _i60.SampleItemDetailsCubit(gh<_i38.GetSampleItemUseCase>()),
    );
    gh.lazySingleton<_i955.StudentPaymentRepository>(
      () => _i293.StudentPaymentRepositoryImpl(
        gh<_i371.StudentPaymentRemoteDataSource>(),
        gh<_i151.StudentBookingRepository>(),
      ),
    );
    gh.factory<_i404.NotificationsInboxCubit>(
      () => _i404.NotificationsInboxCubit(
        gh<_i612.LoadNotificationsUseCase>(),
        gh<_i612.MarkNotificationReadUseCase>(),
        gh<_i612.MarkAllNotificationsReadUseCase>(),
        gh<_i188.NotificationsUnreadCubit>(),
        gh<_i836.NotificationDeepLinkRouter>(),
      ),
    );
    gh.factory<_i876.StudentHomeCubit>(
      () => _i876.StudentHomeCubit(gh<_i869.LoadStudentHomeUseCase>()),
    );
    gh.lazySingleton<_i706.AuthSessionCubit>(
      () => _i706.AuthSessionCubit(
        gh<_i831.LoginUseCase>(),
        gh<_i407.LogoutUseCase>(),
        gh<_i280.LogoutAllUseCase>(),
        gh<_i455.GetPersistedSessionUseCase>(),
        gh<_i880.RefreshProfileUseCase>(),
        gh<_i1029.PushNotificationsCoordinator>(),
        gh<_i941.PushMessagingService>(),
      ),
    );
    gh.factory<_i323.StudentCertificatesListCubit>(
      () => _i323.StudentCertificatesListCubit(
        gh<_i390.LoadStudentCertificatesUseCase>(),
      ),
    );
    gh.factory<_i660.ConfirmStudentPaymentUseCase>(
      () => _i660.ConfirmStudentPaymentUseCase(
        gh<_i955.StudentPaymentRepository>(),
      ),
    );
    gh.factory<_i60.SampleItemsCubit>(
      () => _i60.SampleItemsCubit(gh<_i38.LoadSampleItemsUseCase>()),
    );
    gh.lazySingleton<_i820.AppNavigationConfig>(
      () => _i820.AppNavigationConfig(
        gh<_i706.AuthSessionCubit>(),
        gh<_i127.SplashScreenCubit>(),
      ),
    );
    gh.factory<_i696.StudentPaymentCubit>(
      () => _i696.StudentPaymentCubit(gh<_i660.ConfirmStudentPaymentUseCase>()),
    );
    return this;
  }
}

class _$LocalDatabaseModule extends _i990.LocalDatabaseModule {}
