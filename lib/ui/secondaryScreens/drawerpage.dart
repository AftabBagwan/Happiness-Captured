import 'package:flutter/material.dart';
import 'package:sos/ui/primaryScreens/about.dart';
import 'package:sos/ui/primaryScreens/admin.dart';
import 'package:sos/ui/primaryScreens/covidcases.dart';
import 'package:sos/ui/primaryScreens/covidnews.dart';

import 'package:sos/ui/primaryScreens/form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/ui/primaryScreens/helpline.dart';
import 'package:sos/ui/primaryScreens/instruction.dart';
import 'package:sos/ui/primaryScreens/locationPage.dart';
import 'package:sos/ui/primaryScreens/ngo.dart';
import 'package:sos/ui/primaryScreens/signin.dart';
import 'package:sos/ui/primaryScreens/vaccinator.dart';

import '../../components/customDrawer.dart';

class DrawerPage extends StatefulWidget {
  DrawerPage({Key key, @required this.name, this.email}) : super(key: key);
  final name;
  final email;

  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 25.0),
        children: [
          CustomDrawer(
            name: widget.name,
          ),
          ListTile(
            title: Text('Vaccination'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Vaccinator()));
            },
          ),
          ListTile(
            title: Text(
              'NGO',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => NGO()));
            },
          ),
          ListTile(
            title: Text(
              'Covid News',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => NewsFeed()));
            },
          ),
          ListTile(
            title: Text(
              'Covid Tracker',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CovidCases()));
            },
          ),
          ListTile(
            title: Text(
              'Request For Needs',
              style: TextStyle(
                fontSize: 15.0,
              ),
            ),
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => FormPage()));
            },
          ),
          ListTile(
            title: Text('Emergency Numbers'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HelpLine()));
            },
          ),
          ListTile(
            title: Text('About'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => About(),
                ),
              );
              //Add the code for navigation
            },
          ),
          ListTile(
            title: Text('Admin Portal'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Admin(),
                ),
              );
              //Add the code for navigation
            },
          ),
          ListTile(
            title: Text('Update Primary Location'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LocationPage(email: widget.email)));
            },
          ),
           ListTile(
            title: Text('Instruction'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Instruction()));
            },
          ),
          ListTile(
            title: Text('Log Out'),
            onTap: () {
              void logoutUser() async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs?.clear();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignIn(),
                    ));
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     ModalRoute.withName("/SplashScreen"),
                //     ModalRoute.withName("/Home"));
              }

              logoutUser();
              //Add the code for navigation
            },
          ),
        ],
      ),
    );
  }
}
