import 'package:flutter/material.dart';
import 'package:sos/ui/primaryScreens/dashboard.dart';
import 'package:sos/ui/primaryScreens/adminPanel.dart';

class Admin extends StatelessWidget {
  var adminId;
  var pass;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'Happiness Captured',
      //   ),
      //   backgroundColor: Color(0xfff12d4e),
      // ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(30, 20, 30, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome,',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Admin Login',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                height: 100,
              ),
              TextFormField(
                onChanged: (text) {
                  adminId = text;
                },
                validator: (newValue) {
                  if (newValue == null || newValue.isEmpty) {
                    return 'Please Enter Valid Id';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    hintText: 'Enter Admin ID',
                    labelText: 'Admin ID',
                    labelStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                onChanged: (text) {
                  pass = text;
                },
                validator: (newValue) {
                  if (newValue == null || newValue.isEmpty) {
                    return 'Please Enter Password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    hintText: 'Enter Password',
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.red,
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              SizedBox(
                height: 80,
              ),
              Center(
                child: Container(
                  width: 300,
                  height: 50,
                  color: Colors.red,
                  child: MaterialButton(
                    onPressed: () async {
                      try {
                        if (adminId == 'adminOfTeam5@official.com' &&
                            pass == 'team5Official') {
                          print('ok');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminPanel()));
                        } else {
                          print('wrong-password');
                        }
                      } catch (e) {
                        // print(e.code);
                        // if (e.code == 'wrong-password') {
                        //   setState(() {
                        //     passwordText = 'Please check your password';
                        //   });
                        // } else {
                        //   setState(() {
                        //     emailText = 'User not found';
                        //   });
                        // }
                      }
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
