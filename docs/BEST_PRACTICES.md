# Best Practices

## Naming

| Layer | Pattern |
|-------|---------|
| Screen | `*_screen.dart` |
| Cubit | `*_cubit.dart`, `*_state.dart`, `*_effect.dart` |
| Use case | `*_use_case.dart` |
| Repository | `*_repository.dart` / `*_repository_impl.dart` |
| Data source | `*_remote_data_source.dart` |
| Navigation | `*_navigation.dart` |

## Either contract

| Layer | Return type |
|-------|-------------|
| Remote data source | `RemoteResponse<Model>` |
| Repository / use case | `FutureEither<Entity>` |
| Cubit outward | `ApiState<Entity>` or sealed `*Effect` |

Never throw exceptions through app flow. Never return null for errors.

## State management

- **Default:** checkout-style — coordinator + `RouteResumedRefresh` + sealed `*Effect`
- **Simple read-only load:** `handleApiCall` or manual load with generation counter
- Use `AppCoreCoreCubit` (safe emit after close)
- One terminal `emit` per async completion

## API rules

- Remote data sources inject `ApiHandlerInterface` only
- Protected endpoints: `isAuthorized: true`
- Parsing in data sources → `FormatFailure` / map `NetworkFailure`
- Repositories map `NetworkFailure` → domain `Failure`

## UI rules

- `AppButton`, `AppInputField`, `AppNetworkImage` for API images
- `TypedFormProvider` + `CoreTextField` for forms
- `EdgeInsetsDirectional`, `AlignmentDirectional` for RTL
- No hardcoded strings — use `AppLocalizations`

## Navigation

- Register all routes in `AppNavigationConfig`
- Feature facades call `CoreNavigator` only
- Redirects/guards in `AppNavigationConfig._redirect` driven by cubits

## Testing

- Unit test use cases with mock repositories (`mocktail`)
- `bloc_test` for cubits with `registerFallbackValue` for params
- Register `CoreLogger` / fakes if cubits touch `getIt` in tests

## DI

- `@injectable`, `@lazySingleton`, `@LazySingleton(as: Interface)`
- `@module` for named Hive boxes
- Run `build_runner` after new injectable classes

## New feature checklist

- [ ] `data/`, `domain/`, `presentation/` folders
- [ ] Coordinator + effect (if actions/snackbars/navigation)
- [ ] `*_navigation.dart`
- [ ] `*_failure_message_mapper.dart`
- [ ] Routes in `AppNavigationConfig`
- [ ] ARB keys (en + ar)
