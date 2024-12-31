import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:social/app.dart';
import 'package:social/config/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}