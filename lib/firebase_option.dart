import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


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
    apiKey: 'AIzaSyDkwNd4sHjPqKjX6mokrV_TSfBXZCdvONE',
    appId: '1:57344370943:web:ec41f3a6f111557cc684ca',
    messagingSenderId: '57344370943',
    projectId: 'fir-flutter-codelab-31756',
    authDomain: 'fir-flutter-codelab-31756.firebaseapp.com',
    storageBucket: 'fir-flutter-codelab-31756.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBD2-1cqhsq1R5gMBT1K_4LZoXkIehHTIQ',
    appId: '1:57344370943:android:ec72809500dfc883c684ca',
    messagingSenderId: '57344370943',
    projectId: 'fir-flutter-codelab-31756',
    storageBucket: 'fir-flutter-codelab-31756.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAWX5_9RTqb9h1kQiHY4em6UNuIHbWY7G8',
    appId: '1:57344370943:ios:21234585177fb31cc684ca',
    messagingSenderId: '57344370943',
    projectId: 'fir-flutter-codelab-31756',
    storageBucket: 'fir-flutter-codelab-31756.firebasestorage.app',
    iosBundleId: 'com.example.gtkFlutter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAWX5_9RTqb9h1kQiHY4em6UNuIHbWY7G8',
    appId: '1:57344370943:ios:21234585177fb31cc684ca',
    messagingSenderId: '57344370943',
    projectId: 'fir-flutter-codelab-31756',
    storageBucket: 'fir-flutter-codelab-31756.firebasestorage.app',
    iosBundleId: 'com.example.gtkFlutter',
  );
}
