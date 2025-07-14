import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:waterapp/config/config.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return FirebaseOptions(
        apiKey: ConfigServices.get('FIREBASE_WEB_API_KEY'),
        authDomain: ConfigServices.get('FIREBASE_AUTH_DOMAIN'),
        projectId: ConfigServices.get('FIREBASE_PROJECT_ID'),
        storageBucket: ConfigServices.get('FIREBASE_STORAGE_BUCKET'),
        messagingSenderId: ConfigServices.get('FIREBASE_MESSAGING_SENDER_ID'),
        appId: ConfigServices.get('FIREBASE_APP_ID'),
        measurementId: ConfigServices.get('FIREBASE_MEASUREMENT_ID'),
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return FirebaseOptions(
          apiKey: ConfigServices.get('FIREBASE_API_KEY'),
          appId: ConfigServices.get('FIREBASE_APP_ID'),
          messagingSenderId: ConfigServices.get('FIREBASE_MESSAGING_SENDER_ID'),
          projectId: ConfigServices.get('FIREBASE_PROJECT_ID'),
          storageBucket: ConfigServices.get('FIREBASE_STORAGE_BUCKET'),
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }
}
