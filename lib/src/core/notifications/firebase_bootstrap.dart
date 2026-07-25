import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:qeyadah_mobile_app/firebase_options.dart';

/// Best-effort Firebase bootstrap for Android/iOS.
///
/// Returns false when options are still placeholders or the platform is
/// unsupported (web/desktop), so auth and the rest of the app keep working.
abstract final class FirebaseBootstrap {
  static bool _ready = false;
  static bool get isReady => _ready;

  static Future<bool> ensureInitialized() async {
    if (_ready) return true;
    if (kIsWeb) return false;
    if (defaultTargetPlatform != TargetPlatform.android &&
        defaultTargetPlatform != TargetPlatform.iOS) {
      return false;
    }

    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
      }
      _ready = true;
      return true;
    } on Object {
      _ready = false;
      return false;
    }
  }
}
