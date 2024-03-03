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
    apiKey: 'AIzaSyARrvMjUDOZ_9kd5A4j7Q4uwEkA9Jo-iUI',
    appId: '1:882490828937:web:7c3fdfc7bdd69b4c7abe58',
    messagingSenderId: '882490828937',
    projectId: 'ai-digital-fashion',
    authDomain: 'ai-digital-fashion.firebaseapp.com',
    storageBucket: 'ai-digital-fashion.appspot.com',
    measurementId: 'G-J7H1KZ28DZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyANf7z7KfqV-NWGlr6P0VVe9VSrT5W3vF8',
    appId: '1:882490828937:android:a73e621ab04604457abe58',
    messagingSenderId: '882490828937',
    projectId: 'ai-digital-fashion',
    storageBucket: 'ai-digital-fashion.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB8T14uOzKsbsBnUWiQEitetPWXVUdnwro',
    appId: '1:882490828937:ios:735b29ec657605ca7abe58',
    messagingSenderId: '882490828937',
    projectId: 'ai-digital-fashion',
    storageBucket: 'ai-digital-fashion.appspot.com',
    iosClientId:
        '882490828937-4ktu5g788rncc2rktfroa6731v13g14b.apps.googleusercontent.com',
    iosBundleId: 'com.arhamsoft.skincanvas.skincanvas',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB8T14uOzKsbsBnUWiQEitetPWXVUdnwro',
    appId: '1:882490828937:ios:3a7ca89068f675507abe58',
    messagingSenderId: '882490828937',
    projectId: 'ai-digital-fashion',
    storageBucket: 'ai-digital-fashion.appspot.com',
    iosClientId:
        '882490828937-tp6kma52r7n33ru7fus5idngnnqmt6ch.apps.googleusercontent.com',
    iosBundleId: 'com.arhamsoft.skincanvas.skincanvas.RunnerTests',
  );
}
