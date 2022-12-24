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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAg4f3MwRx36gdk6lxAkzbfOXkmyMbDObA',
    appId: '1:433770550957:android:91851fa4926af058d25824',
    messagingSenderId: '433770550957',
    projectId: 'connec-project',
    databaseURL: 'https://connec-project-default-rtdb.firebaseio.com',
    storageBucket: 'connec-project.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC-QhGJSYYQ3OxNgvcZIb87vGDwwD4_DSQ',
    appId: '1:433770550957:ios:8b5cb468346e0799d25824',
    messagingSenderId: '433770550957',
    projectId: 'connec-project',
    databaseURL: 'https://connec-project-default-rtdb.firebaseio.com',
    storageBucket: 'connec-project.appspot.com',
    iosClientId: '433770550957-kcl7rhmo6df9b6c1ctoerti155kqusug.apps.googleusercontent.com',
    iosBundleId: 'com.example.connec',
  );
}
