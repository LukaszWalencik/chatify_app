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
    apiKey: 'AIzaSyDXnQTnMDU7h-UhiiSC1wSulY6-GrqeOGQ',
    appId: '1:896927256140:web:5a3098fe996c064559aee9',
    messagingSenderId: '896927256140',
    projectId: 'chatify-18bea',
    authDomain: 'chatify-18bea.firebaseapp.com',
    storageBucket: 'chatify-18bea.appspot.com',
    measurementId: 'G-5JLN811QNN',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDp5ESFwf7Y---dQY_X8l0TuqCQeV8vxRk',
    appId: '1:896927256140:android:426e9f999ae88cd559aee9',
    messagingSenderId: '896927256140',
    projectId: 'chatify-18bea',
    storageBucket: 'chatify-18bea.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA7AjMTz-sW_62Dx0uK74Knj2ELOXNMZa8',
    appId: '1:896927256140:ios:4e8f1d0f333f680559aee9',
    messagingSenderId: '896927256140',
    projectId: 'chatify-18bea',
    storageBucket: 'chatify-18bea.appspot.com',
    iosBundleId: 'com.example.chatifyApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA7AjMTz-sW_62Dx0uK74Knj2ELOXNMZa8',
    appId: '1:896927256140:ios:e59460da7ba85a8659aee9',
    messagingSenderId: '896927256140',
    projectId: 'chatify-18bea',
    storageBucket: 'chatify-18bea.appspot.com',
    iosBundleId: 'com.example.chatifyApp.RunnerTests',
  );
}
