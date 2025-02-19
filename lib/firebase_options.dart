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
    apiKey: 'AIzaSyBNF4ccM3iEEtB7dWjc9xj3Faxh9CZbuyc',
    appId: '1:1026730319347:web:44d3998412e1dcc2f1c686',
    messagingSenderId: '1026730319347',
    projectId: 'jokes-app-b1b09',
    authDomain: 'jokes-app-b1b09.firebaseapp.com',
    storageBucket: 'jokes-app-b1b09.firebasestorage.app',
    measurementId: 'G-W3EXQJE061',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDBEkDTNq2kZyctWKgmlBVzaYhpkQJNeYM',
    appId: '1:1026730319347:android:720226d9fe84d814f1c686',
    messagingSenderId: '1026730319347',
    projectId: 'jokes-app-b1b09',
    storageBucket: 'jokes-app-b1b09.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDP4VIQzAKpBLCPGKL0b3IPOwxm_ABHjuo',
    appId: '1:1026730319347:ios:cf7d1cc796221adcf1c686',
    messagingSenderId: '1026730319347',
    projectId: 'jokes-app-b1b09',
    storageBucket: 'jokes-app-b1b09.firebasestorage.app',
    iosBundleId: 'com.example.mis',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDP4VIQzAKpBLCPGKL0b3IPOwxm_ABHjuo',
    appId: '1:1026730319347:ios:cf7d1cc796221adcf1c686',
    messagingSenderId: '1026730319347',
    projectId: 'jokes-app-b1b09',
    storageBucket: 'jokes-app-b1b09.firebasestorage.app',
    iosBundleId: 'com.example.mis',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBNF4ccM3iEEtB7dWjc9xj3Faxh9CZbuyc',
    appId: '1:1026730319347:web:56faca14e73d7518f1c686',
    messagingSenderId: '1026730319347',
    projectId: 'jokes-app-b1b09',
    authDomain: 'jokes-app-b1b09.firebaseapp.com',
    storageBucket: 'jokes-app-b1b09.firebasestorage.app',
    measurementId: 'G-84EE4HEBM0',
  );
}
