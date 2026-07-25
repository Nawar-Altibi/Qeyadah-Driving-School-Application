# Firebase / FCM setup (mobile)

Backend service-account JSON (`qeyadah-firebase-adminsdk-*.json`) is **server-only**.
Never copy it into this Flutter app or commit it to Git.

## One-time client setup

1. Install FlutterFire CLI and sign in to Firebase.
2. From the app root run:

```bash
dart pub global activate flutterfire_cli
flutterfire configure --project=qeyadah
```

3. This regenerates:
   - `lib/firebase_options.dart`
   - `android/app/google-services.json`
   - `ios/Runner/GoogleService-Info.plist`

4. iOS: enable Push Notifications + Background Modes in Xcode, and upload an APNs key in the Firebase console.

Until real options replace the placeholders, Firebase bootstrap fails soft and the rest of the app keeps working (login, inbox HTTP APIs still function when the backend exposes them).
