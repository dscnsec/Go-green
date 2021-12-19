// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBybVbQlJgav8OGkzm5NaIlpiIF0ZqKao4',
    appId: '1:681949451726:web:d9f89a45cb76ab96b9479f',
    messagingSenderId: '681949451726',
    projectId: 'go-green-8868a',
    authDomain: 'go-green-8868a.firebaseapp.com',
    storageBucket: 'go-green-8868a.appspot.com',
    measurementId: 'G-XNBVJVYCK4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCeb29Fc0Q5e8Q0kOeucC1ObnvtFcmVejA',
    appId: '1:681949451726:android:22fea5fd1259303bb9479f',
    messagingSenderId: '681949451726',
    projectId: 'go-green-8868a',
    storageBucket: 'go-green-8868a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_WOxlhtyU0SgpDVPvdX_gE7n2fOKmoJM',
    appId: '1:681949451726:ios:bb72302e0c6853cdb9479f',
    messagingSenderId: '681949451726',
    projectId: 'go-green-8868a',
    storageBucket: 'go-green-8868a.appspot.com',
    androidClientId: '681949451726-ecnohsr3uj19a7q1j347o97d3trfark8.apps.googleusercontent.com',
    iosClientId: '681949451726-p78rk7e3ifgrumk5gqjqer8d9du9jmsv.apps.googleusercontent.com',
    iosBundleId: 'com.example.goGreen',
  );
}