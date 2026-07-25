// File generated for Firebase project `qeyadah`.
// Replace values by running: dart pub global run flutterfire_cli:flutterfire configure
// NEVER commit firebase-adminsdk service-account JSON into this mobile app.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'Web push is out of scope. Configure Android/iOS only.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  /// Placeholder Android options for project `qeyadah`.
  /// Replace via `flutterfire configure` before shipping push to devices.
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'REPLACE_WITH_ANDROID_API_KEY',
    appId: '1:000000000000:android:REPLACE',
    messagingSenderId: '000000000000',
    projectId: 'qeyadah',
    storageBucket: 'qeyadah.firebasestorage.app',
  );

  /// Placeholder iOS options for project `qeyadah`.
  /// Replace via `flutterfire configure` and upload APNs key in Firebase console.
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'REPLACE_WITH_IOS_API_KEY',
    appId: '1:000000000000:ios:REPLACE',
    messagingSenderId: '000000000000',
    projectId: 'qeyadah',
    storageBucket: 'qeyadah.firebasestorage.app',
    iosBundleId: 'com.qeyadah.mobile',
  );
}
