# Coore Reuse Guide

Import: `import 'package:coore/lib.dart';`

Local path: `../coore` (see `pubspec.yaml`).

## Use from coore — do not reimplement

### Bootstrap
- `CoreConfig.initializeCoreDependencies` / `initializeCoreDependenciesAfterProjectSetup`
- `EnvironmentConfig`, `CoreEnvironment`
- `getIt` global container

### Networking
- `ApiHandlerInterface` — all REST calls in **remote data sources only**
- `AuthTokenManager` — single source of truth for Bearer tokens
- `AuthInterceptorType.tokenBased` in `NetworkConfigEntity`
- `CancelRequestAdapter`, `Cancelable` params
- `RemoteResponse<T>`, `ApiHandlerResponse`

### State
- `CoreCubit`, `ApiState`, `ApiStateMixin`, `handleApiCall`
- `CorePaginationCubit` → extended as `AppCorePaginationCubit`

### Navigation
- `CoreNavigator` — `toPath`, `pushPath`, `pop`
- `NavigationConfigEntity`, `FadePage`
- `BaseScreenParams`

### Errors
- Coore `Failure` / `NetworkFailure` hierarchy
- Map to app failures in repositories via `NetworkFailureMapper`

### Storage
- `LocalDatabaseInterface` (Hive) — use `@Named` box instances
- `SecureDatabaseInterface` — tokens via `AuthTokenManager` when `enableSecureStorage: true`
- `ConfigService` — language + theme persistence

### UI / UX
- `ThemeWrapper`, `LocalizationWrapper`, `NetworkStatusWrapper`
- `CoreTextField`, `CoreImage.network`
- `ScreenBreakpoints`, `getValueForScreenType`
- `PaginationResponseModel`, pagination strategies

### Use cases
- `FutureEitherUseCase`, `NoParams`

## App-layer extensions (this template)

- `AppFailure` types: `FormatFailure`, `BusinessFailure`, `AuthFailure`, `OperationCancelledFailure`
- `AppCoreCubit` safe emit wrappers
- `CubitEffectListener`, `RouteResumedRefresh`
- Design system: `AppButton`, `AppInputField`, `AppNetworkImage`

## When to add code to coore vs the app

| Add to coore | Add to app template |
|--------------|---------------------|
| Cross-app infrastructure | Business features |
| Generic interceptors | App-specific headers |
| Reusable widgets for all Razzeen apps | Brand theme + tokens |
| API handler contract changes | Endpoints, entities, routes |

## Typedef alias

```dart
typedef FutureEither<T> = UseCaseFutureResponse<T>;
```

Defined in `lib/src/core/typedefs/app_typedefs.dart`.
