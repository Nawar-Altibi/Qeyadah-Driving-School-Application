# Qeyadah Mobile AI Coding Rules

Use this file as the first reference for any AI agent working on this Flutter
project.

## Project Identity

- Product name: Qeyadah Mobile.
- Dart package name: `qeyadah_mobile_app`.
- Domain: driving school mobile application.
- Primary language and layout: Arabic-first, RTL-first, with English support.
- Main user groups after authentication:
  - Student app flow.
  - Instructor app flow.

Authentication must route users by backend response roles/permissions. A user
with `STUDENT` goes to the student shell. A user with `INSTRUCTOR` goes to the
instructor shell. Other roles should be blocked from this mobile app unless a
specific staff mobile flow is intentionally added.

## Architecture Rules

- Keep the existing feature-first clean architecture:
  - `data/`: DTOs/models, remote/local data sources, repository implementations.
  - `domain/`: entities, params, repository contracts, use cases.
  - `presentation/`: screens, cubits, effects, widgets, navigation helpers.
- Keep shared UI, design tokens, formatters, and app-level helpers in
  `lib/src/core`.
- Keep cross-feature business types in `lib/src/shared`.
- Do not put API calls, parsing, or business rules inside widgets.
- Do not import presentation classes from domain or data layers.
- Use repositories and use cases between UI state and data sources.
- Use `Either<Failure, T>` for domain-facing async operations, matching the
  existing template style.
- Keep generated files generated. Do not hand-edit `.g.dart`, `.freezed.dart`,
  or injectable config files except for mechanical package rename cleanup.

## State Management

- Use `Cubit` for feature state, following the existing auth and sample feature.
- Use explicit states and one-time effects for navigation/toasts.
- Keep local widget-only state inside widgets only when it is truly local
  and does not affect business flow.
- Avoid pushing navigation decisions deep into widgets. Use navigation helper
  classes per feature.

## Backend Contract Rules

The backend uses `/api/v1` and returns auth responses with:

- `accessToken`
- `refreshToken`
- `user`
- `user.roles`
- `user.permissions`

Login is phone/password based, not email based. Use:

- `phone`
- `password`
- optional `deviceName`

Student auth and password reset use OTP flows. Do not assume OTP is email-based.

Booking concepts that should appear consistently in the app:

- `PENDING_PAYMENT`
- `BOOKED`
- `COMPLETED`
- `NO_SHOW`
- `CANCELLED`
- `EXPIRED`
- deposit/payment states
- ShamCash transaction confirmation
- reusable deposit credit after school/instructor cancellation

## UI System Rules

Always build from reusable widgets and design tokens before making screen-local
styles.

Use these core files first:

- `lib/src/core/theme/app_color_schemes.dart`
- `lib/src/core/theme/tokens/app_design_tokens.dart`
- `lib/src/core/theme/app_text_theme_extension.dart`
- `lib/src/core/ui/app_button.dart`
- `lib/src/core/ui/app_input_field.dart`
- `lib/src/core/ui/app_card.dart`
- `lib/src/core/ui/app_status_badge.dart`
- `lib/src/core/ui/app_segmented_control.dart`
- `lib/src/core/ui/app_section_heading.dart`
- `lib/src/core/ui/app_metric_tile.dart`
- `lib/src/core/ui/app_alert_banner.dart`

When a UI pattern repeats at least twice, move it to `core/ui` if it is generic,
or to `features/<feature>/presentation/widgets` if it is domain-specific.

Do not copy large widget trees between student and instructor screens. Extract
shared primitives, then compose feature widgets.

## Visual Direction

The UI/UX reference uses:

- Deep emerald primary color.
- Soft mint surfaces.
- White cards with restrained borders.
- Rounded mobile controls.
- Strong Arabic hierarchy.
- Compact operational cards.
- Status badges and small icon-led controls.

Use the Qeyadah palette from `AppColors`, not ad-hoc screen colors.

Bundled typography:

- Current registered font family: `IBMPlexSansArabic`.
- Use it for Arabic body copy, labels, form fields, buttons, and headings until
  a design-approved replacement is added.

Recommended future typography:

- Headings: `Noto Kufi Arabic`
- Body/UI text: `Noto Sans Arabic`
- English fallback: `Roboto`

Before registering fonts in `pubspec.yaml`, add the actual font files under
`assets/fonts/`. Do not reference font assets that do not exist.

## Reusable Widget Rules

- Buttons: use `AppButton` variants instead of raw `FilledButton`/`OutlinedButton`
  in feature screens.
- Inputs: use `AppInputField` or a specialized wrapper.
- Cards: use `AppCard` for repeated white/surface cards.
- Status labels: use `AppStatusBadge`.
- Segmented choices: use `AppSegmentedControl`.
- Metric boxes: use `AppMetricTile`.
- Alerts and warnings: use `AppAlertBanner`.
- Section titles: use `AppSectionHeading`.
- Use `IconData` based widgets for reusable components. Keep feature-specific
  icons selected at the feature layer.

## Student Feature Boundaries

Student screens should be organized around:

- Auth and OTP.
- Home.
- Booking preferences.
- Available instructor/slot selection.
- Booking review and ShamCash confirmation.
- My bookings.
- Certificate tracking.
- Notifications.
- Profile/settings.

Student booking must respect the backend temporary hold and expiry behavior.
Do not show a confirmed booking until payment confirmation succeeds.

## Instructor Feature Boundaries

Instructor screens should be organized around:

- Daily schedule.
- Upcoming and completed sessions.
- Leave/unavailable request.
- Profile/settings.
- Notifications.

Instructor leave UI must show affected bookings when the backend supports it.
Until the dedicated endpoint exists, keep leave submission code isolated behind
a repository contract so the screen does not depend on mock data.

## Package Policy

Direct dependencies should be added only when the app imports them directly.
Do not rely on transitive dependencies from `coore`.

Useful packages to keep or add now:

- `pinput`: OTP input fields.
- `table_calendar`: booking and instructor schedule calendar UI.
- `phosphor_flutter`: broad icon set that fits the clean mobile design.
- `dotted_border`: upload placeholders and dashed available-slot cards.
- `image_picker`: certificate/profile document and photo uploads.
- `url_launcher`: phone calls, maps, and external ShamCash/app links.

Useful packages to defer until native/backend decisions are ready:

- `firebase_messaging`: push notifications.
- `flutter_local_notifications`: local reminders.
- `mobile_scanner`: QR or barcode scanning if payment/document flows need it.
- `permission_handler`: centralized runtime permission requests.
- `geolocator`: only if map/location workflows are actually required.

## Testing and Verification

For every meaningful change:

- Run `dart format` on changed Dart files.
- Run `flutter analyze`.
- Run relevant tests.
- For generated model or DI changes, run build runner.
- For localization changes, regenerate localization files.

Do not leave the project in a state that requires generated files but does not
include them, unless the user explicitly asked to skip generation.

## Naming Rules

- Files and folders: `snake_case`.
- Classes/enums/extensions: `PascalCase`.
- Variables/functions: `camelCase`.
- Widgets should start with `App` only when they are generic core widgets.
- Feature widgets should include the feature context in the name.

## Common Mistakes to Avoid

- Do not build new screens with hardcoded colors, fonts, and spacing.
- Do not put API paths directly in widgets or cubits.
- Do not treat student and instructor as one generic home screen if their
  permissions and workflows diverge.
- Do not return mock data from production repositories.
- Do not add Firebase or native packages without documenting required platform
  configuration.
- Do not store refresh tokens in plain shared preferences; use the template's
  token coordinator/storage strategy.
