import 'package:flutter/material.dart';
import 'signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String name;
  String mobileNumber;

  static const String id = 'signup';
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
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
                Text(
                  'Create Account,',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Sign up to get started!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  onChanged: (value) {
                    name = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    prefixIcon: new Icon(
                      Icons.account_circle,
                      size: 30,
                    ),
                    hintText: 'Enter your name',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  onChanged: (value) {
                    mobileNumber = value;
                  },
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    prefixIcon: new Icon(
                      Icons.account_circle,
                      size: 30,
                    ),
                    hintText: 'Enter your mobile number',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
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
                  decoration: InputDecoration(
                    prefixIcon: new Icon(
                      Icons.email,
                      size: 30,
                    ),
                    hintText: 'Enter your email',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    prefixIcon: new Icon(
                      Icons.lock,
                      size: 30,
                    ),
                    hintText: 'Enter your password',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
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
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignIn()),
                            );

                            // _firestore
                            //     .collection('database')
                            //     .doc('$email')
                            //     .set({
                            //   'email': email,
                            //   'mobile': mobileNumber,
                            //   'name': name,
                            // });
                          }
                        } catch (e) {
                          print(e);
                        }
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => Dashboard(),
                        //   ),
                        // );
                      },
                      child: Text(
                        'SignUp',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'I`m already a member,',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      // onPressed: onPressed, child: child
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignIn(),
                          ),
                        );
                      },
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                // TextButton(
                //   // onPressed: onPressed, child: child
                //   onPressed: () => Navigator.pushNamed(context, "/"),
                //   child: Text(
                //     'Sign In',
                //     style: TextStyle(
                //       color: Color(0xffffa086),
                //       fontSize: 15,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
