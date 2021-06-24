import 'package:flutter/material.dart';
import 'package:sos/components/constants.dart';
import 'locationPage.dart';
import 'signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos/components/text.dart';
import 'package:sos/components/fieldDecoration.dart';

class SignUp extends StatelessWidget {
  static const String id = 'signup';
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    String email;
    String password;
    String name;
    String mobileNumber;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(30, 20, 30, 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BigText(
                  bigText: 'Create Account,',
                ),
                SmallText(
                  smallText: 'Sign up to get started!',
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  onChanged: (value) {
                    name = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: decoration(
                      icon: Icons.account_circle, text: 'Enter your name'),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  onChanged: (value) {
                    mobileNumber = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: decoration(
                      icon: Icons.phone, text: 'Enter your mobile number'),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                    onChanged: (value) {
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    decoration: decoration(
                        text: "Enter your Email", icon: Icons.person)),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  textAlign: TextAlign.center,
                  decoration:
                      decoration(text: "Enter Your Password", icon: Icons.lock),
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
                        try {
                          final newUser = _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                          if (newUser != null) {
                            _firestore
                                .collection('database')
                                .doc('$email')
                                .set({
                              'email': email,
                              'mobile': mobileNumber,
                              'name': name,
                              'time': DateTime.now(),
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationPage(
                                        email: email,
                                      )),
                            );
                          }
                        } catch (e) {}
                      },
                      child: Text(
                        'SignUp',
                        style: kButtonTextStyle,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'I`m already a member,',
                      style: kDescriptionStyle,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, SignIn.id);
                      },
                      child: Text(
                        'Sign In',
                        style: kTextButtonStyle,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
