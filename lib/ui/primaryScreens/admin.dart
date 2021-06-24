import 'package:flutter/material.dart';
import 'package:sos/components/fieldDecoration.dart';
import 'package:sos/components/text.dart';
import 'package:sos/ui/primaryScreens/adminPanel.dart';

class Admin extends StatelessWidget {
  static const String id = 'admin';
  @override
  Widget build(BuildContext context) {
    var adminId;
    var pass;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(30, 20, 30, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BigText(bigText: 'Welcome,'),
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
                  decoration: formFieldDecoration(
                    icon: Icons.admin_panel_settings_sharp,
                    labelText: 'Admin ID',
                    hintText: 'Enter admin ID',
                  )),
              SizedBox(
                height: 30,
              ),
              TextFormField(
                  obscureText: true,
                  onChanged: (text) {
                    pass = text;
                  },
                  validator: (newValue) {
                    if (newValue == null || newValue.isEmpty) {
                      return 'Please Enter Password';
                    }
                    return null;
                  },
                  decoration: formFieldDecoration(
                    icon: Icons.password,
                    hintText: 'Enter password',
                    labelText: 'Password',
                  )),
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
                      if (adminId == 'adminOfTeam5@official.com' &&
                          pass == 'team5Official') {
                        Navigator.pushNamed(context, AdminPanel.id);
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
