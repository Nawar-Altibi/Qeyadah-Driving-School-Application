import 'package:bot_toast/bot_toast.dart';
import 'package:coore/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:qeyadah_mobile_app/src/core/config/app_navigation/stream_to_listenable.dart';
import 'package:qeyadah_mobile_app/src/core/offline/presentation/cubit/offline_queue_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/password_reset_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/cubit/registration_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/navigation/auth_screen_params.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/screens/login_screen.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/screens/new_password_screen.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/screens/register_otp_screen.dart';
import 'package:qeyadah_mobile_app/src/features/auth/presentation/screens/register_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/dues/cubit/instructor_dues_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/dues/screens/instructor_dues_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/earnings/cubit/instructor_earnings_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/earnings/screens/instructor_earnings_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/invoices/cubit/instructor_invoices_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/invoices/screens/instructor_invoices_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/leave/cubit/instructor_leave_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/leave/screens/instructor_leave_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/profile/cubit/instructor_profile_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/profile/screens/instructor_profile_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/cubit/instructor_schedule_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/cubit/instructor_weekly_schedule_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/screens/instructor_schedule_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/screens/instructor_weekly_schedule_screen.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/cubit/notifications_inbox_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/cubit/notifications_unread_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/notifications/presentation/screens/notifications_inbox_screen.dart';
import 'package:qeyadah_mobile_app/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/presentation/cubit/sample_items_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/presentation/screens/sample_item_details_screen.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/presentation/screens/sample_items_screen.dart';
import 'package:qeyadah_mobile_app/src/features/splash/presentation/cubit/splash_screen_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/splash/presentation/screens/splash_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/cubit/student_booking_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/navigation/student_booking_screen_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/screens/student_booking_credit_success_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/screens/student_booking_preferences_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/screens/student_booking_review_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_booking/presentation/screens/student_booking_slots_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/cubit/student_booking_detail_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/cubit/student_bookings_list_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/navigation/student_bookings_screen_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/screens/student_booking_detail_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_bookings/presentation/screens/student_bookings_list_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificate_detail_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificate_write_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificates_hub_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/cubit/student_certificates_list_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/screens/student_certificate_detail_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/screens/student_certificate_new_request_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/screens/student_certificate_reexam_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/screens/student_certificates_hub_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_certificates/presentation/screens/student_certificates_list_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/cubit/student_home_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/screens/student_home_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/cubit/student_payment_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/navigation/student_payment_screen_params.dart';
import 'package:qeyadah_mobile_app/src/features/student_payments/presentation/screens/student_payment_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/presentation/cubit/student_theory_quiz_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_theory/presentation/screens/student_theory_intro_screen.dart';
import 'package:qeyadah_mobile_app/src/shared/enums/user_role.dart';

@lazySingleton
class AppNavigationConfig {
  AppNavigationConfig(this._authSessionCubit, this._splashScreenCubit) {
    _authSessionCubit.restoreSession();
    _routerRefreshListenable = StreamToListenable([
      _authSessionCubit.stream,
      _splashScreenCubit.stream,
    ]);
    navigationConfigEntity = _buildNavigationConfigEntity();
  }

  final AuthSessionCubit _authSessionCubit;
  final SplashScreenCubit _splashScreenCubit;
  late final StreamToListenable _routerRefreshListenable;
  late final NavigationConfigEntity navigationConfigEntity;

  static const _guestAuthPaths = <String>{
    LoginScreen.routePath,
    RegisterScreen.routePath,
    RegisterOtpScreen.routePath,
    ForgotPasswordScreen.routePath,
    NewPasswordScreen.routePath,
  };

  NavigationConfigEntity _buildNavigationConfigEntity() {
    return NavigationConfigEntity(
      initialRoute: SplashScreen.routePath,
      redirect: _redirect,
      refreshListenable: _routerRefreshListenable,
      navigationObservers: <NavigatorObserver>[BotToastNavigatorObserver()],
      routes: [
        GoRoute(
          path: SplashScreen.routePath,
          name: SplashScreen.routeName,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: _withSession(const SplashScreen()),
          ),
        ),
        GoRoute(
          path: LoginScreen.routePath,
          name: LoginScreen.routeName,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: _withSession(const LoginScreen()),
          ),
        ),
        GoRoute(
          path: RegisterScreen.routePath,
          name: RegisterScreen.routeName,
          pageBuilder: (context, state) => FadePage(
            key: state.pageKey,
            child: _withSession(const RegisterScreen()),
          ),
        ),
        GoRoute(
          path: RegisterOtpScreen.routePath,
          name: RegisterOtpScreen.routeName,
          pageBuilder: (context, state) {
            final cubit = registrationCubitFromExtra(state.extra);
            final child = cubit != null
                ? BlocProvider<RegistrationCubit>.value(
                    value: cubit,
                    child: const RegisterOtpScreen(),
                  )
                : const RegisterOtpScreen();
            return FadePage(key: state.pageKey, child: _withSession(child));
          },
        ),
        GoRoute(
          path: ForgotPasswordScreen.routePath,
          name: ForgotPasswordScreen.routeName,
          pageBuilder: (context, state) => FadePage(
            key: state.pageKey,
            child: _withSession(const ForgotPasswordScreen()),
          ),
        ),
        GoRoute(
          path: NewPasswordScreen.routePath,
          name: NewPasswordScreen.routeName,
          pageBuilder: (context, state) {
            final cubit = passwordResetCubitFromExtra(state.extra);
            final phone = state.uri.queryParameters['phone'] ?? '';
            final child = cubit != null
                ? BlocProvider<PasswordResetCubit>.value(
                    value: cubit,
                    child: NewPasswordScreen(phone: phone),
                  )
                : NewPasswordScreen(phone: phone);
            return FadePage(key: state.pageKey, child: _withSession(child));
          },
        ),
        GoRoute(
          path: NewPasswordScreen.forcedRoutePath,
          name: NewPasswordScreen.forcedRouteName,
          pageBuilder: (context, state) {
            final phone = _authSessionCubit.currentSession?.user.phone ?? '';
            return FadePage(
              key: state.pageKey,
              child: _withSession(
                BlocProvider(
                  create: (_) =>
                      getIt<PasswordResetCubit>()
                        ..startForcedPasswordChange(phone),
                  child: NewPasswordScreen(phone: phone, isForced: true),
                ),
              ),
            );
          },
        ),
        GoRoute(
          path: StudentHomeScreen.routePath,
          name: StudentHomeScreen.routeName,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: _withSession(
              BlocProvider(
                create: (_) => getIt<StudentHomeCubit>(),
                child: const StudentHomeScreen(),
              ),
            ),
          ),
        ),
        GoRoute(
          path: StudentBookingPreferencesScreen.routePath,
          name: StudentBookingPreferencesScreen.routeName,
          pageBuilder: (context, state) => FadePage(
            key: state.pageKey,
            child: _withSession(
              BlocProvider(
                create: (_) => getIt<StudentBookingCubit>(),
                child: const StudentBookingPreferencesScreen(),
              ),
            ),
          ),
        ),
        GoRoute(
          path: StudentBookingSlotsScreen.routePath,
          name: StudentBookingSlotsScreen.routeName,
          pageBuilder: (context, state) {
            final cubit =
                studentBookingCubitFromExtra(state.extra) ??
                getIt<StudentBookingCubit>();
            return FadePage(
              key: state.pageKey,
              child: _withSession(
                BlocProvider<StudentBookingCubit>.value(
                  value: cubit,
                  child: const StudentBookingSlotsScreen(),
                ),
              ),
            );
          },
        ),
        GoRoute(
          path: StudentBookingReviewScreen.routePath,
          name: StudentBookingReviewScreen.routeName,
          pageBuilder: (context, state) {
            final cubit =
                studentBookingCubitFromExtra(state.extra) ??
                getIt<StudentBookingCubit>();
            return FadePage(
              key: state.pageKey,
              child: _withSession(
                BlocProvider<StudentBookingCubit>.value(
                  value: cubit,
                  child: const StudentBookingReviewScreen(),
                ),
              ),
            );
          },
        ),
        GoRoute(
          path: StudentBookingCreditSuccessScreen.routePath,
          name: StudentBookingCreditSuccessScreen.routeName,
          pageBuilder: (context, state) {
            final bookingId =
                studentBookingCreditSuccessIdFromExtra(state.extra) ?? 0;
            return FadePage(
              key: state.pageKey,
              child: _withSession(
                StudentBookingCreditSuccessScreen(bookingId: bookingId),
              ),
            );
          },
        ),
        GoRoute(
          path: StudentPaymentScreen.routePath,
          name: StudentPaymentScreen.routeName,
          pageBuilder: (context, state) {
            final args = studentPaymentHoldArgsFromExtra(state.extra);
            final child = args != null
                ? BlocProvider(
                    create: (_) => getIt<StudentPaymentCubit>(),
                    child: StudentPaymentScreen(args: args),
                  )
                : BlocProvider(
                    create: (_) => getIt<StudentHomeCubit>(),
                    child: const StudentHomeScreen(),
                  );
            return FadePage(key: state.pageKey, child: _withSession(child));
          },
        ),
        GoRoute(
          path: StudentBookingsListScreen.routePath,
          name: StudentBookingsListScreen.routeName,
          pageBuilder: (context, state) => FadePage(
            key: state.pageKey,
            child: _withSession(
              BlocProvider(
                create: (_) => getIt<StudentBookingsListCubit>(),
                child: const StudentBookingsListScreen(),
              ),
            ),
          ),
        ),
        GoRoute(
          path: StudentBookingDetailScreen.routePath,
          name: StudentBookingDetailScreen.routeName,
          pageBuilder: (context, state) {
            final bookingId = studentBookingDetailIdFromExtra(state.extra) ?? 0;
            return FadePage(
              key: state.pageKey,
              child: _withSession(
                BlocProvider(
                  create: (_) => getIt<StudentBookingDetailCubit>(),
                  child: StudentBookingDetailScreen(bookingId: bookingId),
                ),
              ),
            );
          },
        ),
        GoRoute(
          path: StudentCertificatesHubScreen.routePath,
          name: StudentCertificatesHubScreen.routeName,
          pageBuilder: (context, state) => FadePage(
            key: state.pageKey,
            child: _withSession(
              BlocProvider(
                create: (_) => getIt<StudentCertificatesHubCubit>(),
                child: const StudentCertificatesHubScreen(),
              ),
            ),
          ),
        ),
        GoRoute(
          path: StudentCertificatesListScreen.routePath,
          name: StudentCertificatesListScreen.routeName,
          pageBuilder: (context, state) => FadePage(
            key: state.pageKey,
            child: _withSession(
              BlocProvider(
                create: (_) => getIt<StudentCertificatesListCubit>(),
                child: const StudentCertificatesListScreen(),
              ),
            ),
          ),
        ),
        GoRoute(
          path: StudentCertificateNewRequestScreen.routePath,
          name: StudentCertificateNewRequestScreen.routeName,
          pageBuilder: (context, state) => FadePage(
            key: state.pageKey,
            child: _withSession(
              BlocProvider(
                create: (_) => getIt<StudentCertificateWriteCubit>(),
                child: const StudentCertificateNewRequestScreen(),
              ),
            ),
          ),
        ),
        GoRoute(
          path: StudentCertificateReexamScreen.routePath,
          name: StudentCertificateReexamScreen.routeName,
          pageBuilder: (context, state) {
            final id = state.pathParameters['id'] ?? '';
            return FadePage(
              key: state.pageKey,
              child: _withSession(
                BlocProvider(
                  create: (_) => getIt<StudentCertificateWriteCubit>(),
                  child: StudentCertificateReexamScreen(certificateId: id),
                ),
              ),
            );
          },
        ),
        GoRoute(
          path: StudentCertificateDetailScreen.routePath,
          name: StudentCertificateDetailScreen.routeName,
          pageBuilder: (context, state) {
            final id = state.pathParameters['id'] ?? '';
            return FadePage(
              key: state.pageKey,
              child: _withSession(
                BlocProvider(
                  create: (_) => getIt<StudentCertificateDetailCubit>(),
                  child: StudentCertificateDetailScreen(certificateId: id),
                ),
              ),
            );
          },
        ),
        GoRoute(
          path: StudentTheoryIntroScreen.routePath,
          name: StudentTheoryIntroScreen.routeName,
          pageBuilder: (context, state) => FadePage(
            key: state.pageKey,
            child: _withSession(
              BlocProvider(
                create: (_) => getIt<StudentTheoryQuizCubit>(),
                child: const StudentTheoryIntroScreen(),
              ),
            ),
          ),
        ),
        GoRoute(
          path: InstructorScheduleScreen.routePath,
          name: InstructorScheduleScreen.routeName,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: _withSession(
              BlocProvider(
                create: (_) => getIt<InstructorScheduleCubit>(),
                child: const InstructorScheduleScreen(),
              ),
            ),
          ),
        ),
        GoRoute(
          path: InstructorProfileScreen.routePath,
          name: InstructorProfileScreen.routeName,
          pageBuilder: (context, state) => NoTransitionPage(
            key: state.pageKey,
            child: _withSession(
              BlocProvider(
                create: (_) => getIt<InstructorProfileCubit>(),
                child: const InstructorProfileScreen(),
              ),
            ),
          ),
        ),
        GoRoute(
          path: InstructorLeaveScreen.routePath,
          name: InstructorLeaveScreen.routeName,
          pageBuilder: (context, state) => FadePage(
            key: state.pageKey,
            child: _withSession(
              BlocProvider(
                create: (_) => getIt<InstructorLeaveCubit>(),
                child: const InstructorLeaveScreen(),
              ),
            ),
          ),
        ),
        GoRoute(
          path: InstructorWeeklyScheduleScreen.routePath,
          name: InstructorWeeklyScheduleScreen.routeName,
          pageBuilder: (context, state) => FadePage(
            key: state.pageKey,
            child: _withSession(
              BlocProvider(
                create: (_) => getIt<InstructorWeeklyScheduleCubit>(),
                child: const InstructorWeeklyScheduleScreen(),
              ),
            ),
          ),
        ),
        GoRoute(
          path: InstructorDuesScreen.routePath,
          name: InstructorDuesScreen.routeName,
          pageBuilder: (context, state) => FadePage(
            key: state.pageKey,
            child: _withSession(
              BlocProvider(
                create: (_) => getIt<InstructorDuesCubit>(),
                child: const InstructorDuesScreen(),
              ),
            ),
          ),
        ),
        GoRoute(
          path: InstructorEarningsScreen.routePath,
          name: InstructorEarningsScreen.routeName,
          pageBuilder: (context, state) => FadePage(
            key: state.pageKey,
            child: _withSession(
              BlocProvider(
                create: (_) => getIt<InstructorEarningsCubit>(),
                child: const InstructorEarningsScreen(),
              ),
            ),
          ),
        ),
        GoRoute(
          path: InstructorInvoicesScreen.routePath,
          name: InstructorInvoicesScreen.routeName,
          pageBuilder: (context, state) => FadePage(
            key: state.pageKey,
            child: _withSession(
              BlocProvider(
                create: (_) => getIt<InstructorInvoicesCubit>(),
                child: const InstructorInvoicesScreen(),
              ),
            ),
          ),
        ),
        GoRoute(
          path: NotificationsInboxScreen.routePath,
          name: NotificationsInboxScreen.routeName,
          pageBuilder: (context, state) => FadePage(
            key: state.pageKey,
            child: _withSession(
              BlocProvider(
                create: (_) => getIt<NotificationsInboxCubit>(),
                child: const NotificationsInboxScreen(),
              ),
            ),
          ),
        ),
        GoRoute(
          path: '/instructor/notifications',
          name: 'instructor-notifications',
          redirect: (context, state) => NotificationsInboxScreen.routePath,
        ),
        GoRoute(
          path: ProfileScreen.routePath,
          name: ProfileScreen.routeName,
          pageBuilder: (context, state) => FadePage(
            key: state.pageKey,
            child: _withSession(const ProfileScreen()),
          ),
        ),
        GoRoute(
          path: SampleItemsScreen.routePath,
          name: SampleItemsScreen.routeName,
          pageBuilder: (context, state) => FadePage(
            key: state.pageKey,
            child: _withSession(
              BlocProvider(
                create: (_) => getIt<SampleItemsCubit>(),
                child: const SampleItemsScreen(),
              ),
            ),
          ),
        ),
        GoRoute(
          path: '/sample-items/${SampleItemDetailsScreen.routePathSegment}',
          name: SampleItemDetailsScreen.routeName,
          pageBuilder: (context, state) {
            final id = state.pathParameters['itemId'] ?? '';
            return FadePage(
              key: state.pageKey,
              child: _withSession(
                BlocProvider(
                  create: (_) => getIt<SampleItemDetailsCubit>(),
                  child: SampleItemDetailsScreen(itemId: id),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  String? _redirect(BuildContext context, GoRouterState state) {
    final location = state.uri.path;
    final splashFinished = _splashScreenCubit.state.animationFinished;
    final authState = _authSessionCubit.getApiState(_authSessionCubit.state);
    final authRestoreComplete = _authSessionCubit.hasCompletedInitialRestore;
    final isAuthenticated = _authSessionCubit.isAuthenticated;
    final session = _authSessionCubit.currentSession;

    if (!splashFinished) {
      return location == SplashScreen.routePath ? null : SplashScreen.routePath;
    }

    if (!authRestoreComplete || authState.isLoading) {
      return location == SplashScreen.routePath ? null : SplashScreen.routePath;
    }

    final isGuestAuthRoute = _guestAuthPaths.contains(location);
    final isForcedPasswordRoute = location == NewPasswordScreen.forcedRoutePath;
    final homePath = _homePathFor(session?.user.primaryRole);

    if (!isAuthenticated) {
      return isGuestAuthRoute ? null : LoginScreen.routePath;
    }

    if (session?.user.mustChangePassword ?? false) {
      return isForcedPasswordRoute ? null : NewPasswordScreen.forcedRoutePath;
    }

    if (isForcedPasswordRoute) {
      return homePath;
    }

    if (isGuestAuthRoute || location == SplashScreen.routePath) {
      return homePath;
    }

    return null;
  }

  String _homePathFor(UserRole? role) {
    return switch (role) {
      UserRole.instructor => InstructorScheduleScreen.routePath,
      _ => StudentHomeScreen.routePath,
    };
  }

  Widget _withSession(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthSessionCubit>.value(value: _authSessionCubit),
        BlocProvider<SplashScreenCubit>.value(value: _splashScreenCubit),
        if (getIt.isRegistered<NotificationsUnreadCubit>())
          BlocProvider<NotificationsUnreadCubit>.value(
            value: getIt<NotificationsUnreadCubit>(),
          ),
        if (getIt.isRegistered<OfflineQueueCubit>())
          BlocProvider<OfflineQueueCubit>.value(
            value: getIt<OfflineQueueCubit>(),
          ),
      ],
      child: child,
    );
  }
}
