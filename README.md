# Qeyadah Mobile

Production-ready Flutter app built on the bundled **[coore](packages/coore)** package with feature-first clean architecture, Coore `CoreCubit` + `ApiState`, injectable DI, GoRouter via `CoreNavigator`, AR/EN localization, and an optional offline request queue.

## Quick start

```bash
flutter pub get
dart run build_runner build
flutter gen-l10n
flutter run -t lib/main_development.dart
```

**Demo login:** `0999400001` / `Test@12345`

## Environments

| Entrypoint | Env file |
|------------|----------|
| `lib/main_development.dart` | `.env.development` |
| `lib/main_staging.dart` | `.env.staging` |
| `lib/main_production.dart` | `.env.production` |

## Project layout

```
lib/
├── main_*.dart          # Environment entrypoints
├── src/
│   ├── core/            # App infrastructure (theme, DI, navigation, offline)
│   ├── features/        # Feature modules (auth, splash, sample_items)
│   └── shared/        # Cross-feature types
```

## Sample feature

Clone `lib/src/features/sample_items/` when adding a new feature. It demonstrates:

- `data/` → `domain/` → `presentation/` (checkout-style coordinator)
- `ApiHandlerInterface` in remote data sources only
- `Either<Failure, T>` through repositories and use cases
- Sealed effects + `CubitEffectListener` (auth login)
- `RouteResumedRefresh` for child-route resume

## Documentation

- [Architecture report](docs/ARCHITECTURE.md)
- [Coore reuse guide](docs/COORE_REUSE.md)
- [Migration guide](docs/MIGRATION.md)
- [Best practices](docs/BEST_PRACTICES.md)
- [Package recommendations](docs/PACKAGE_RECOMMENDATIONS.md)
- [Branch structure](docs/BRANCH_STRUCTURE.md)
- [Feature branch map](docs/FEATURE_BRANCH_MAP.md)
- [AI coding rules](AI_CODING_RULES.md)

## Dependency on coore

```yaml
dependencies:
  coore:
    path: packages/coore
```

`coore` is vendored under `packages/coore` so CI/CD and fresh clones can resolve dependencies without a sibling workspace folder.
