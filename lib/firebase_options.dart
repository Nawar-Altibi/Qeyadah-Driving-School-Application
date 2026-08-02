// File generated for Firebase project `qeyadah`.
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA8Vrr_ZsOSHbIPHD1Xei5W7BrYG0q8OJU',
    appId: '1:869422894847:android:923129f544beb2686ac6ca',
    messagingSenderId: '869422894847',
    projectId: 'qeyadah',
    storageBucket: 'qeyadah.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCfunh0n7NIKWzzUYErg0vEWTPqA2hSvLQ',
    appId: '1:869422894847:ios:f8ec6d1529fdae216ac6ca',
    messagingSenderId: '869422894847',
    projectId: 'qeyadah',
    storageBucket: 'qeyadah.firebasestorage.app',
    iosBundleId: 'com.qeyadah.mobile',
  );
}
