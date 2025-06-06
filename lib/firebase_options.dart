// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAcmS-1BGMqgMVtpypSBKWecEY3e36_E5c',
    appId: '1:708640333634:web:5f114c497d7dbbec6472db',
    messagingSenderId: '708640333634',
    projectId: 'babymetal-e3fcd',
    authDomain: 'babymetal-e3fcd.firebaseapp.com',
    storageBucket: 'babymetal-e3fcd.firebasestorage.app',
    measurementId: 'G-LQRT7GMKBE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAxKzOrebkieo4R7gNYMzsWfuwuFfPCFes',
    appId: '1:708640333634:android:7b183e5c88743f7a6472db',
    messagingSenderId: '708640333634',
    projectId: 'babymetal-e3fcd',
    storageBucket: 'babymetal-e3fcd.firebasestorage.app',
  );
}
