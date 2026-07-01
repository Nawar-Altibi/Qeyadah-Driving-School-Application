# Migration Guide

## 1. Create a new app from this template

```bash
cp -r qeyadah_mobile_app my_new_app
cd my_new_app
# Update pubspec name, Android/iOS bundle IDs
dart run change_app_package_name:main com.yourcompany.app
```

## 2. Configure environment

Edit `.env.development`, `.env.staging`, `.env.production`:

```
BASE_URL=https://api.yourbackend.com
ENABLE_OFFLINE_QUEUE=true
```

Update `lib/src/core/constants/environment_variables.dart` if you add new keys.

## 3. Wire coore in CI

If `../coore` is not available in CI, use Git:

```yaml
dependencies:
  coore:
    git:
      url: https://gitlab.com/your-org/coore.git
      ref: main
```

## 4. Add a feature

1. Copy `lib/src/features/sample_items/` → `lib/src/features/<your_feature>/`
2. Register routes in `AppNavigationConfig`
3. Add `*_navigation.dart` facade — no `context.go` in widgets
4. Run `dart run build_runner build`
5. Add ARB keys in `assets/l10n/`

## 5. Auth integration

Replace `AuthRemoteDataSourceImpl` demo login with your API:

- Call `AuthTokenCoordinator.persist` after login
- Call `AuthTokenCoordinator.clear` on logout
- Extend `AuthSessionEntity` / `UserEntity` as needed

## 6. Optional modules

| Module | How to add |
|--------|------------|
| Firebase | Add `firebase_core`, call `Firebase.initializeApp` in `main_common.dart` |
| FCM | Uncomment/register notifications module pattern from muntaji |
| Dual-role shells | Copy `StatefulShellRoute` pattern from Parking app `app_pages.dart` |
| Dynamic API host | Add dev-only host picker in splash (Parking `APIConfig` pattern) |
| Maps | Add `flutter_osm_plugin` or `google_maps_flutter` in a map feature |

## 7. Offline queue

Enabled when `ENABLE_OFFLINE_QUEUE=true`. Inject `OfflineQueueService.enqueue` from write operations that must survive offline periods.

## 8. Code generation checklist

After structural changes:

```bash
dart run build_runner build
flutter gen-l10n
```

## 9. Rename checklist

- [ ] `pubspec.yaml` name
- [ ] Android `applicationId`
- [ ] iOS bundle identifier
- [ ] ARB `appName`
- [ ] `.env` package keys
