# Feature Branch Map

Use this map when opening branches and PRs. It connects the project report's
student/instructor workflows to concrete Flutter feature modules.

## Recommended Feature Module Shape

Each product feature should keep the existing clean layout:

```text
lib/src/features/<feature_name>/
  data/
    data_sources/
    mappers/
    models/
    repositories/
  domain/
    entities/
    params/
    repositories/
    use_cases/
  presentation/
    cubit/
    navigation/
    screens/
    widgets/
```

For shared student/instructor primitives, use `lib/src/core` or
`lib/src/shared`; do not duplicate the same widget or enum in both user areas.

## Foundation Branches

| Branch | Main module/path | Purpose |
|---|---|---|
| `feature/core/api-client` | `lib/src/core` | Backend base client, auth headers, refresh handling, response/failure mapping. |
| `feature/core/navigation-shells` | `lib/src/core/config/app_navigation` | Role-based app shell routing after login. |
| `feature/core/design-system` | `lib/src/core/theme`, `lib/src/core/ui` | Shared Qeyadah tokens, cards, badges, calendar primitives, RTL UI helpers. |
| `feature/core/localization` | `assets/l10n`, `lib/l10n` | Arabic-first copy, enum labels, date/time formatting. |
| `feature/core/notifications` | `lib/src/features/notifications` | Shared in-app notifications data and presentation. |

## Auth Branches

| Branch | Main module/path | Purpose |
|---|---|---|
| `feature/auth/phone-login` | `lib/src/features/auth` | Phone/password login and token persistence. |
| `feature/auth/role-routing` | `lib/src/features/auth`, navigation config | Route `STUDENT` to student shell and `INSTRUCTOR` to instructor shell. |
| `feature/auth/student-registration-otp` | `lib/src/features/auth` | Student OTP registration flow. |
| `feature/auth/password-reset-otp` | `lib/src/features/auth` | Forgot/reset password OTP flow. |

## Student Branches

| Branch | Suggested module | Backend/report dependency |
|---|---|---|
| `feature/student/home-dashboard` | `lib/src/features/student_home` | User profile, active booking, notification summary. |
| `feature/student/booking-availability` | `lib/src/features/student_booking` | Available slot generation, instructor filters, vehicle source, local time. |
| `feature/student/booking-flow` | `lib/src/features/student_booking` | `POST /student/bookings`, reusable deposit credit, pending-payment hold. |
| `feature/student/payment-shamcash` | `lib/src/features/student_payments` | `POST /student/bookings/:id/confirm-payment`, ShamCash transaction fields. |
| `feature/student/bookings-history` | `lib/src/features/student_bookings` | Booking statuses: pending, booked, completed, no-show, cancelled, expired. |
| `feature/student/certificates` | `lib/src/features/student_certificates` | Certificate request, service fee, training sessions, exam results, transport progress. |
| `feature/student/profile-settings` | `lib/src/features/student_profile` | Profile, language, account settings, logout. |
| `feature/student/notifications` | `lib/src/features/notifications` | Booking/payment/certificate/general notifications for student role. |

## Instructor Branches

| Branch | Suggested module | Backend/report dependency |
|---|---|---|
| `feature/instructor/home-schedule` | `lib/src/features/instructor_home` | Today overview, lesson count, upcoming sessions. |
| `feature/instructor/schedule-calendar` | `lib/src/features/instructor_schedule` | Schedule calendar, daily timeline, booking details, student contact summary. |
| `feature/instructor/leave-request` | `lib/src/features/instructor_leave` | Unavailable periods, affected-booking preview contract, leave submission. |
| `feature/instructor/profile` | `lib/src/features/instructor_profile` | Instructor profile, rating/statistics, preferences, logout. |
| `feature/instructor/notifications` | `lib/src/features/notifications` | Schedule/cancellation/leave/general notifications for instructor role. |

## Best Implementation Order

1. `feature/core/api-client`
2. `feature/auth/phone-login`
3. `feature/auth/role-routing`
4. `feature/core/navigation-shells`
5. `feature/student/booking-availability`
6. `feature/student/booking-flow`
7. `feature/student/payment-shamcash`
8. `feature/instructor/schedule-calendar`
9. `feature/core/notifications`
10. `feature/student/certificates`
11. `feature/instructor/leave-request`

This order follows the report: booking/scheduling is the core operational
workflow, payment confirmation completes student booking, and instructor leave
depends on schedule/unavailability behavior plus backend leave endpoints.
