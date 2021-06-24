import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sos/components/constants.dart';
import 'package:sos/components/fieldDecoration.dart';
import 'signin.dart';

class ResetPass extends StatefulWidget {
  static const String id = 'ResetPass';
  @override
  _ResetPassState createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  String _email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(30, 80, 30, 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reset',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  'Password,',
                  style: TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  decoration: decoration(
                    text: 'Enter your email',
                    icon: Icons.email,
                  ),
                  onChanged: (value) {
                    _email = value;
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Container(
                    width: 200,
                    height: 50,
                    color: Colors.red,
                    child: MaterialButton(
                      child: Text(
                        'Send Email',
                        style: kButtonTextStyle,
                      ),
                      onPressed: () async {
                        Navigator.pushNamed(context, SignIn.id);
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(email: _email);
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Note: After pressing the button check your email and press the link to reset the password.',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Container(
                    width: 300,
                    height: 50,
                    color: Colors.red,
                    child: MaterialButton(
                        child: Text(
                          'Login',
                          style: kButtonTextStyle,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, SignIn.id);
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
