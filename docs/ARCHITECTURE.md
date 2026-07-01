# Architecture Report

## Workspace analysis (4 projects)

| Project | Verdict |
|---------|---------|
| **muntaji (منتجي)** | Primary skeleton — clean architecture, Coore integration, checkout-style presentation, env entrypoints |
| **coore** | Mandatory foundation — networking, state, navigation, storage, failures |
| **Parking app** | Reference only — dual-role shells, dynamic API host, OSM (documented in MIGRATION, not shipped) |
| **lib2** | Offline queue pattern donor — adapted to Coore `ApiHandler` + `Either` |

## Template stack

- **Architecture:** Feature-first clean architecture
- **State:** `AppCoreCoreCubit` + `ApiState` + coordinators/effects
- **DI:** get_it + injectable on top of `CoreConfig.initializeCoreDependencies`
- **Networking:** Coore `ApiHandlerInterface` (never raw Dio in features)
- **Routing:** Central `AppNavigationConfig` + `CoreNavigator` facades
- **Errors:** `Either<Failure, T>` end-to-end; Coore `NetworkFailure` mapped in repositories
- **i18n:** ARB files + `LocalizationWrapper`
- **Offline:** Optional `OfflineQueueService` (lib2-inspired)

## What lives in coore vs this template

| coore (do not duplicate) | Template (app layer) |
|--------------------------|----------------------|
| Dio, interceptors, token refresh | `HeadersInterceptor`, `AuthTokenCoordinator` |
| `AuthTokenManager` | Session persistence + login flow |
| `CoreNavigator`, `FadePage` | `AppNavigationConfig`, feature `*Navigation` |
| `ApiState`, `handleApiCall` | `AppCoreCubit`, generation guards, coordinators |
| Hive / secure storage interfaces | Feature local data sources |
| Theme/locale cubits | `AppThemeData`, design tokens, `AppButton` |

## Weaknesses addressed

| Source weakness | Template fix |
|-----------------|--------------|
| Parking/lib2 exception-based Dio | Strict `Either` contract |
| Parking manual get_it | injectable codegen |
| lib2 no DI | Injectable modules |
| No CI in any project | GitHub Actions `ci.yml` + `release.yml` |
| Muntaji size (900+ feature files) | Minimal skeleton + one sample feature |

## Bootstrap flow

```
main_development.dart
  → main_common.dart
    → EnvironmentConfig.loadEnv
    → CoreConfig.initializeCoreDependencies
    → setupProjectDependencies() // injectable
    → CoreConfig.initializeCoreDependenciesAfterProjectSetup
    → OfflineQueueCubit.initialize() // optional
    → runApp(App())
```

## Feature template (`sample_items`)

Demonstrates list + detail screens, repository/use case stack, navigation facade, and coordinator with `RouteResumedRefresh`.

## Optional modules not shipped

- Firebase / FCM (documented in MIGRATION)
- Dual-role shells (Parking app pattern)
- Dynamic API host switcher
- Maps / OSM
