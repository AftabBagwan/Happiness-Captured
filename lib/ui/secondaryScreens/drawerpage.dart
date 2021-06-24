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
import 'package:sos/ui/primaryScreens/vaccination.dart';
import '../../components/customDrawer.dart';
import 'package:sos/components/constants.dart';

class DrawerPage extends StatefulWidget {
  static const String id = 'drawerPage';
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
            title: Text(
              'Covid Tracker',
              style: kDrawerStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, CovidCases.id);
            },
          ),
          ListTile(
            title: Text(
              'Covid News',
              style: kDrawerStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, NewsFeed.id);
            },
          ),
          ListTile(
            title: Text(
              'Request For Needs',
              style: kDrawerStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, FormPage.id);
            },
          ),
          ListTile(
            title: Text(
              'NGO',
              style: kDrawerStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, NGO.id);
            },
          ),
          ListTile(
            title: Text(
              'Emergency Numbers',
              style: kDrawerStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, HelpLine.id);
            },
          ),
          ListTile(
            title: Text(
              'Update Primary Location',
              style: kDrawerStyle,
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LocationPage(email: widget.email)));
            },
          ),
          ListTile(
            title: Text(
              'Instruction',
              style: kDrawerStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, Instruction.id);
            },
          ),
          ListTile(
            title: Text(
              'About',
              style: kDrawerStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, About.id);
            },
          ),
          ListTile(
            title: Text(
              'Admin Portal',
              style: kDrawerStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, Admin.id);
            },
          ),
          ListTile(
            title: Text(
              'Vaccination',
              style: kDrawerStyle,
            ),
            onTap: () {
              Navigator.pushNamed(context, Vaccination.id);
            },
          ),
          ListTile(
            title: Text(
              'Log Out',
              style: kDrawerStyle,
            ),
            onTap: () {
              void logoutUser() async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs?.clear();
                Navigator.pushNamed(context, SignIn.id);
              }

              logoutUser();
            },
          ),
        ],
      ),
    );
  }
}
