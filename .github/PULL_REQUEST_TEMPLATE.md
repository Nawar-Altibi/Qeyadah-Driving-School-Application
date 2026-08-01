## Area

- [ ] Core/foundation
- [ ] Auth
- [ ] Student
- [ ] Instructor
- [ ] Shared UI/design system

## Branch

Expected format:

```text
feature/<area>/<flow>
fix/<area>/<issue>
chore/<area>/<task>
```

## Summary

-

## Report/Backend Contract

Relevant backend/report dependency:

-

## Verification

Must match the CI `quality` job:

- [ ] `dart format --output=none --set-exit-if-changed lib test packages`
- [ ] `dart run build_runner build --delete-conflicting-outputs` (if generated files changed)
- [ ] `flutter gen-l10n`
- [ ] `flutter analyze --fatal-infos`
- [ ] `flutter test` (relevant / full suite)

## Screens/Flows

Affected mobile flows:

-
