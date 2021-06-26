import 'package:flutter/material.dart';
import 'package:sos/components/constants.dart';
import 'package:sos/components/text.dart';
import 'package:sos/ui/primaryScreens/dashboard.dart';
import 'package:sos/ui/primaryScreens/resetPass.dart';
import 'signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/components/fieldDecoration.dart';

class SignIn extends StatefulWidget {
  static const String id = 'signIn';
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String email;
  String password;
  var emailText;
  var passwordText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(30, 80, 30, 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(
                  bigText: 'Welcome,',
                ),
                SmallText(
                  smallText: 'Sign in to continue!',
                ),
                SizedBox(
                  height: 80,
                ),
                TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  decoration: signInFormFieldDecoration(
                      emailText, Icons.email, 'Enter your email'),
                ),
                SizedBox(
                  height: 40,
                ),
                TextField(
                    onChanged: (value) {
                      password = value;
                    },
                    obscureText: true,
                    textAlign: TextAlign.center,
                    decoration: signInFormFieldDecoration(
                        passwordText, Icons.lock, 'Enter your password')),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, ResetPass.id);
                      },
                      child: Text(
                        'Forget Password?',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    width: 300,
                    height: 50,
                    color: Colors.red,
                    child: MaterialButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs?.setBool("isLoggedIn", true);
                        // ignore: deprecated_member_use
                        _scaffoldKey.currentState.showSnackBar(new SnackBar(
                          duration: new Duration(seconds: 1),
                          content: new Row(
                            children: <Widget>[
                              new CircularProgressIndicator(),
                              new Text("  Signing-In...")
                            ],
                          ),
                        ));
                        try {
                          await _auth.signInWithEmailAndPassword(
                              email: email, password: password);
                          Navigator.pushNamed(context, Dashboard.id);
                        } catch (e) {
                          if (e.code == 'wrong-password') {
                            setState(() {
                              passwordText = 'Please check your password';
                            });
                          } else {
                            setState(() {
                              emailText = 'User not found';
                            });
                          }
                        }
                      },
                      child: Text('Login', style: kButtonTextStyle),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('I`am a new user,', style: kDescriptionStyle),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignUp.id);
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                //Text('Note: This Application is for testing purpose only'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
