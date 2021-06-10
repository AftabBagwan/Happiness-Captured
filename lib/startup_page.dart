import 'package:flutter/material.dart';
import 'package:sos/google_sign_in_button.dart';
import 'package:sos/signin.dart';
import 'package:sos/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class StartUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(23),
                ),
                child: MaterialButton(
                  child: Text('SignIn',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: Colors.white,
                      )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignIn(),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(23),
                ),
                child: MaterialButton(
                  child: Text('SignUp',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 23,
                        color: Colors.white,
                      )),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignUp(),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'OR',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            GoogleSignInButton(),
            // FutureBuilder(
            //   // future: Authentication.initializeFirebase(context: context),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasError) {
            //       return Text('Error initializing Firebase');
            //     } else if (snapshot.connectionState == ConnectionState.done) {
            //       return GoogleSignInButton();
            //     }
            //     return CircularProgressIndicator(
            //       valueColor: AlwaysStoppedAnimation<Color>(
            //         Colors.orange,
            //       ),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
