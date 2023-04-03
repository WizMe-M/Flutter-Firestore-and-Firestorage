import 'package:firebase_core/firebase_core.dart';
import 'package:firestore_learning/firebase_options.dart';
import 'package:firestore_learning/widget/app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

  runApp(App());
}
