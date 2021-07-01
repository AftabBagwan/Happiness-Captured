import 'package:flutter/material.dart';
import 'package:sos/ui/primaryScreens/about.dart';
import 'package:sos/ui/primaryScreens/admin.dart';
import 'package:sos/ui/primaryScreens/adminPanel.dart';
import 'package:sos/ui/primaryScreens/covidcases.dart';
import 'package:sos/ui/primaryScreens/covidnews.dart';
import 'package:sos/ui/primaryScreens/dashboard.dart';
import 'package:sos/ui/primaryScreens/form.dart';
import 'package:sos/ui/primaryScreens/helpline.dart';
import 'package:sos/ui/primaryScreens/instruction.dart';
import 'package:sos/ui/primaryScreens/ngo.dart';
import 'package:sos/ui/primaryScreens/requestAccepted.dart';
import 'package:sos/ui/primaryScreens/resetPass.dart';
import 'package:sos/ui/primaryScreens/signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/ui/primaryScreens/signup.dart';

var status;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  status = prefs.getBool('isLoggedIn') ?? false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SignIn.id: (context) => SignIn(),
        SignUp.id: (context) => SignUp(),
        About.id: (context) => About(),
        Admin.id: (context) => Admin(),
        AdminPanel.id: (context) => AdminPanel(),
        CovidCases.id: (context) => CovidCases(),
        NewsFeed.id: (context) => NewsFeed(),
        Dashboard.id: (context) => Dashboard(),
        FormPage.id: (context) => FormPage(),
        HelpLine.id: (context) => HelpLine(),
        Instruction.id: (context) => Instruction(),
        NGO.id: (context) => NGO(),
        RequestAccepted.id: (context) => RequestAccepted(),
        ResetPass.id: (context) => ResetPass(),
      },
      debugShowCheckedModeBanner: false,
      home: status == false ? SignIn() : Dashboard(),
    );
  }
}
