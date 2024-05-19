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
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBvP5MrJXWWgBXtom_rCwGjpuVyLItTvRI',
    appId: '1:676229746658:web:2729565a1237f0b6ee73bb',
    messagingSenderId: '676229746658',
    projectId: 'login2-ff981',
    authDomain: 'login2-ff981.firebaseapp.com',
    storageBucket: 'login2-ff981.appspot.com',
    measurementId: 'G-FH9Y1LLQ16',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCIBJPJ3S2pRTwaO-GkOWOpyM8SBX4vZ1s',
    appId: '1:676229746658:android:ec0ce203cd04634fee73bb',
    messagingSenderId: '676229746658',
    projectId: 'login2-ff981',
    storageBucket: 'login2-ff981.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDBwMubKr5Cssq-oC8VHajt7K8Eev5wmD0',
    appId: '1:676229746658:ios:83f88abfece2ee1eee73bb',
    messagingSenderId: '676229746658',
    projectId: 'login2-ff981',
    storageBucket: 'login2-ff981.appspot.com',
    iosBundleId: 'com.example.authenticationapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDBwMubKr5Cssq-oC8VHajt7K8Eev5wmD0',
    appId: '1:676229746658:ios:83f88abfece2ee1eee73bb',
    messagingSenderId: '676229746658',
    projectId: 'login2-ff981',
    storageBucket: 'login2-ff981.appspot.com',
    iosBundleId: 'com.example.authenticationapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBvP5MrJXWWgBXtom_rCwGjpuVyLItTvRI',
    appId: '1:676229746658:web:50539d2beb2ce1a8ee73bb',
    messagingSenderId: '676229746658',
    projectId: 'login2-ff981',
    authDomain: 'login2-ff981.firebaseapp.com',
    storageBucket: 'login2-ff981.appspot.com',
    measurementId: 'G-HMVJ86JNGX',
  );
}
