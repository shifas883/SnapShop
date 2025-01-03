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
    apiKey: 'AIzaSyAeLRHCRx9W960BiOyQdI1k5Qf1e9gsVss',
    appId: '1:696696465418:web:f174109ebf05e15e6cd7f3',
    messagingSenderId: '696696465418',
    projectId: 'snapshop-e244e',
    authDomain: 'snapshop-e244e.firebaseapp.com',
    storageBucket: 'snapshop-e244e.firebasestorage.app',
    measurementId: 'G-R0W4DP9YYE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB-kuJ_361JsFYiFBR5okqV0qDOG-1hfyY',
    appId: '1:696696465418:android:671b693c4964d65c6cd7f3',
    messagingSenderId: '696696465418',
    projectId: 'snapshop-e244e',
    storageBucket: 'snapshop-e244e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCPLOOPfc1a7IvoyLp-5dtoen2nT-iR3d4',
    appId: '1:696696465418:ios:721b3d4acab5caea6cd7f3',
    messagingSenderId: '696696465418',
    projectId: 'snapshop-e244e',
    storageBucket: 'snapshop-e244e.firebasestorage.app',
    iosBundleId: 'com.example.snapshop',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCPLOOPfc1a7IvoyLp-5dtoen2nT-iR3d4',
    appId: '1:696696465418:ios:721b3d4acab5caea6cd7f3',
    messagingSenderId: '696696465418',
    projectId: 'snapshop-e244e',
    storageBucket: 'snapshop-e244e.firebasestorage.app',
    iosBundleId: 'com.example.snapshop',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAeLRHCRx9W960BiOyQdI1k5Qf1e9gsVss',
    appId: '1:696696465418:web:24de75fe135b21106cd7f3',
    messagingSenderId: '696696465418',
    projectId: 'snapshop-e244e',
    authDomain: 'snapshop-e244e.firebaseapp.com',
    storageBucket: 'snapshop-e244e.firebasestorage.app',
    measurementId: 'G-8SXJPYD08L',
  );
}
