// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
    apiKey: 'AIzaSyBtlomOQ-gz7R_KMpKlCRkyhsP_Tf4fuvs',
    appId: '1:475767358760:web:c93fecf56bd87028a03c1d',
    messagingSenderId: '475767358760',
    projectId: 'gymcalendar-20206',
    authDomain: 'gymcalendar-20206.firebaseapp.com',
    storageBucket: 'gymcalendar-20206.appspot.com',
    measurementId: 'G-DGSJ17YDV0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJF7seWDvFXzLD3JwVwW-b8ZltCoCffWo',
    appId: '1:475767358760:android:cb232be799657db8a03c1d',
    messagingSenderId: '475767358760',
    projectId: 'gymcalendar-20206',
    storageBucket: 'gymcalendar-20206.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6VFyJh6aU9Ba5GTfwvjqORwmmeH6h96c',
    appId: '1:475767358760:ios:d583bfd6b5791b93a03c1d',
    messagingSenderId: '475767358760',
    projectId: 'gymcalendar-20206',
    storageBucket: 'gymcalendar-20206.appspot.com',
    androidClientId: '475767358760-klqcon97ktbminvu2nkbpffr6llt2ihi.apps.googleusercontent.com',
    iosClientId: '475767358760-noaak21ldbftdlti1mj0s1dtgmb9t4om.apps.googleusercontent.com',
    iosBundleId: 'com.guardian.gymCalendar',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC6VFyJh6aU9Ba5GTfwvjqORwmmeH6h96c',
    appId: '1:475767358760:ios:b1ae15535bd8c9a1a03c1d',
    messagingSenderId: '475767358760',
    projectId: 'gymcalendar-20206',
    storageBucket: 'gymcalendar-20206.appspot.com',
    androidClientId: '475767358760-klqcon97ktbminvu2nkbpffr6llt2ihi.apps.googleusercontent.com',
    iosClientId: '475767358760-7k3opmr7vrtc17td1ed3qv3ejsdih4tn.apps.googleusercontent.com',
    iosBundleId: 'com.example.gymCalendar.RunnerTests',
  );
}
