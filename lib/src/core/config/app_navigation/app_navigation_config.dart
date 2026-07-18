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
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/leave/cubit/instructor_leave_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/leave/screens/instructor_leave_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/profile/cubit/instructor_profile_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/profile/screens/instructor_profile_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/cubit/instructor_schedule_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/cubit/instructor_weekly_schedule_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/screens/instructor_schedule_screen.dart';
import 'package:qeyadah_mobile_app/src/features/instructor/presentation/schedule/screens/instructor_weekly_schedule_screen.dart';
import 'package:qeyadah_mobile_app/src/features/profile/presentation/screens/profile_screen.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/presentation/cubit/sample_items_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/presentation/screens/sample_item_details_screen.dart';
import 'package:qeyadah_mobile_app/src/features/sample_items/presentation/screens/sample_items_screen.dart';
import 'package:qeyadah_mobile_app/src/features/splash/presentation/cubit/splash_screen_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/splash/presentation/screens/splash_screen.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/cubit/student_home_cubit.dart';
import 'package:qeyadah_mobile_app/src/features/student_home/presentation/screens/student_home_screen.dart';
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
        if (getIt.isRegistered<OfflineQueueCubit>())
          BlocProvider<OfflineQueueCubit>.value(
            value: getIt<OfflineQueueCubit>(),
          ),
      ],
      child: child,
    );
  }
}
