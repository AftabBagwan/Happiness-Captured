import 'package:flutter/material.dart';

import 'package:sos/ui/primaryScreens/form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/ui/primaryScreens/helpline.dart';
import 'package:sos/ui/primaryScreens/locationPage.dart';
import 'package:sos/ui/primaryScreens/ngo.dart';
import 'package:sos/ui/primaryScreens/signin.dart';
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
              
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpLine()));
            },
          ),
          ListTile(
            title: Text('About'),
            onTap: () {
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
