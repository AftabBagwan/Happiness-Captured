import 'package:flutter/material.dart';
import 'package:sos/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sos/startup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartUp(),
    );
  }
}
