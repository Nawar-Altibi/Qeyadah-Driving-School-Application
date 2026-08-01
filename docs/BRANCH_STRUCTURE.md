# Qeyadah Mobile Branch Structure

This repository should use a small trunk-based structure with short-lived
feature branches. Keep `main` releasable, integrate through pull requests, and
split student and instructor work by product flow instead of by screen only.

## Permanent Branches

- `main`
  - Stable branch.
  - Only merged, reviewed, buildable work should land here.
- `develop`
  - Integration branch for mobile work before release hardening.
  - Keep this branch close to `main`; avoid long-running divergence.

## Branch Naming

Use this format:

```text
feature/<area>/<flow>
fix/<area>/<issue>
chore/<area>/<task>
release/<version>
hotfix/<issue>
```

Examples:

```text
feature/auth/phone-login
feature/student/booking-flow
feature/instructor/schedule
fix/student/payment-expiry-state
chore/core/theme-tokens
release/1.0.0
```

## Core Foundation Branches

Build these before deep student/instructor screens:

- `feature/core/api-client`
  - Base URL configuration, token storage, refresh-token handling, backend
    response mapping, and failure mapping.
- `feature/core/navigation-shells`
  - Role-based post-login routing and separate student/instructor shells.
- `feature/core/design-system`
  - Finalize shared Qeyadah theme, typography, buttons, cards, badges, calendar
    primitives, and reusable RTL widgets.
- `feature/core/localization`
  - Arabic-first copy, English fallback, enum display labels, and date/time
    formatting.
- `feature/core/notifications`
  - In-app notifications list and read state. Push notifications should wait
    until Firebase/backend token registration is ready.

## Auth Branches

- `feature/auth/phone-login`
  - Phone/password login, backend auth response mapping, persisted session, and
    access/refresh token lifecycle.
- `feature/auth/role-routing`
  - Route `STUDENT` users to the student shell and `INSTRUCTOR` users to the
    instructor shell. Block unsupported staff roles in the mobile app.
- `feature/auth/student-registration-otp`
  - Student OTP request, verification, registration, and automatic login.
- `feature/auth/password-reset-otp`
  - Forgot password, OTP verification, and reset password flow.

## Student Feature Branches

- `feature/student/home-dashboard`
  - Student overview, active booking summary, notifications preview, and quick
    actions.
- `feature/student/booking-availability`
  - Available slot filters: training type, vehicle source, instructor gender,
    date, duration, and grouped slots by instructor.
- `feature/student/booking-flow`
  - Create booking, handle pending payment holds, reusable deposit credit, and
    booking success/error states.
- `feature/student/payment-shamcash`
  - Deposit confirmation screen, ShamCash transaction id/sender fields, gateway
    status, duplicate transaction errors, and hold expiry handling.
- `feature/student/bookings-history`
  - Upcoming lessons, completed lessons, cancelled/expired bookings, and
    cancellation/rebooking states.
- `feature/student/certificates`
  - Certificate request status, service fee state, training sessions, exam
    results, and transport-related progress.
- `feature/student/profile-settings`
  - Student profile, language, password/account actions, and logout.
- `feature/student/notifications`
  - Booking, payment, certificate, and general notifications.

## Instructor Feature Branches

- `feature/instructor/home-schedule`
  - Today overview, upcoming sessions, confirmed/cancelled states, and lesson
    counts.
- `feature/instructor/schedule-calendar`
  - Calendar view, daily timeline, booking details, student/contact summary,
    and session status display.
- `feature/instructor/leave-request`
  - Leave request form, hourly/daily leave modes, affected-bookings preview
    contract, conflict warnings, and submission state.
- `feature/instructor/profile`
  - Instructor profile, rating/statistics, availability/preferences display,
    language, notifications, and logout.
- `feature/instructor/notifications`
  - Schedule, cancellation, leave, and general notifications.

## Backend Dependency Order

Recommended order based on the project report:

1. Auth and role routing.
2. Core API/token handling.
3. Student booking availability.
4. Student booking creation and ShamCash confirmation.
5. Instructor schedule.
6. Notifications.
7. Student certificates.
8. Instructor leave request.

Instructor leave should stay behind a repository contract until the backend adds
dedicated leave preview/create endpoints. The report says unavailable periods
exist, but a formal leave approval workflow is not fully implemented yet.

## Pull Request Rules

- One PR should map to one branch and one product flow.
- Do not mix student and instructor features in the same PR unless the change is
  a shared core primitive.
- Keep generated files in the same PR as the source change that generated them.
- Each feature PR should update route registration, localization strings, and
  relevant tests.
- Every PR should run the same gates as the CI `quality` job:
  - `dart format --output=none --set-exit-if-changed .`
  - `dart run build_runner build --delete-conflicting-outputs` when generated
    models/DI changed
  - `flutter gen-l10n`
  - `flutter analyze --fatal-infos`
  - relevant unit/widget tests (`flutter test`)
- See [CI.md](CI.md) for workflow layout and the Flutter SDK pin.

## Repository Setup Notes

- The local repository remote is expected to be:
  `https://github.com/Nawar-Altibi/Qeyadah-Driving-School-Application.git`
- The app depends on `coore` through `path: packages/coore`, which keeps the
  reusable package inside this repository for GitHub Actions and fresh clones.
