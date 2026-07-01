# Qeyadah Mobile Package Recommendations

This file records package choices for the Qeyadah Flutter app after reviewing
the template, `coore`, `muntaji - Copy`, the UI/UX reference, and the project
report.

## Added Now

- `pinput: ^5.0.1`
  - Used for student OTP and password reset verification.
  - Kept on v5 because `coore` already depends on `pinput: ^5.0.1`.
- `table_calendar: ^3.2.0`
  - Used for instructor schedules, student booking calendars, leave dates, and
    lesson history.
- `phosphor_flutter: ^2.1.0`
  - Used for the app's icon system. It matches the clean, thin-line style in
    the UI/UX reference better than dense Material icons.
- `dotted_border: ^3.1.0`
  - Used for empty states, upload zones, unavailable schedule slots, and dashed
    leave/booking placeholders.
- `image_picker: ^1.2.3`
  - Used for student/instructor profile images and future document attachment
    flows.
- `url_launcher: ^6.3.2`
  - Used for phone calls, WhatsApp/support links, map links, and policy links.

## Already Available Through Coore

Do not duplicate these unless direct app imports are needed:

- `dio`
- `flutter_secure_storage`
- `cached_network_image`
- `flutter_svg`
- `hive_ce`
- `internet_connection_checker_plus`
- `logger`
- `shimmer`
- `pinput`

## Defer Until Needed

- `firebase_messaging`
  - Add only when Firebase is configured and the backend has notification token
    registration endpoints.
- `flutter_local_notifications`
  - Add with `firebase_messaging` if the app needs foreground/local lesson
    reminders.
- `mobile_scanner`
  - Add only if QR check-in, payment confirmation, or attendance scanning is
    added.
- `permission_handler`
  - Add only when camera/location/notification permission orchestration becomes
    more complex than plugin defaults.
- `geolocator`
  - Add only if the product requires live location, nearby branches, or
    instructor arrival tracking.

## Package Policy

- Prefer packages already present in `coore` before adding app-level
  dependencies.
- Add direct dependencies only when the app imports the package directly.
- Avoid Firebase packages until the Firebase project files and backend device
  token endpoints exist.
- Re-run dependency resolution and static analysis after every package change.
