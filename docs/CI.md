# CI / CD

GitHub Actions workflows for Qeyadah Mobile.

## Flutter pin

CI and Release use **Flutter 3.41.6** (`stable`), matching the team SDK used for
local development. Update `FLUTTER_VERSION` in both workflow files together when
upgrading.

## Workflows

### `ci.yml` (push to `main`/`develop`, all PRs)

| Job | Purpose |
|---|---|
| `quality` | `pub get` → codegen → l10n → format check → `flutter analyze --fatal-infos` → `flutter test` |
| `build-android` | Debug APK via `lib/main_development.dart` (after quality) |
| `build-web` | Web build via `lib/main_development.dart` (after quality) |

Concurrency cancels in-progress runs on the same ref so rapid PR pushes do not
waste minutes.

### `release.yml` (tags `v*`)

Runs the same quality gates, then builds production APK + web with
`lib/main_production.dart`, uploads artifacts, and creates a GitHub Release with
the APK attached.

Release APKs are **unsigned** until Play signing secrets (`KEYSTORE_BASE64`,
keystore passwords / `key.properties`) are added. Do not block releases on
missing store upload automation.

## Reproduce CI locally

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
dart format --output=none --set-exit-if-changed lib test packages
flutter analyze --fatal-infos
flutter test
```

Optional build checks:

```bash
flutter build apk --debug -t lib/main_development.dart
flutter build web -t lib/main_development.dart
```
