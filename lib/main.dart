import 'package:flutter/material.dart';
import 'package:sos/dashboard.dart';
import 'package:sos/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sos/startup_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

var status;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  status = prefs.getBool('isLoggedIn') ?? false;
  print(status);
  runApp(MyApp());
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: status == true ? SignIn() : Dashboard(),
    );
  }
}
