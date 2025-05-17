import 'package:capstone/web_app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCvRXx4sfJftfjwyKZDLMWI1M0fph2pp1Q",
      authDomain: "capstone-f5537.firebaseapp.com",
      projectId: "capstone-f5537",
      storageBucket: "capstone-f5537.firebasestorage.app",
      messagingSenderId: "1029547945305",
      appId: "1:1029547945305:web:7a9789eaec8f5ffd9f7048",
      measurementId: "G-RGEQLXXPR4",
    ),
  );
  runApp(PinesvilleLoginApp() as Widget);
}
