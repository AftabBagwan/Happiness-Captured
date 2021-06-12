import 'package:flutter/material.dart';
import 'package:sos/form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos/signin.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 25.0),
        children: [
          CustomDrawer(),
          ListTile(
            title: Text(
              'Foundation',
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
              //Add the code for navigation
            },
          ),
          ListTile(
            title: Text('About'),
            onTap: () {
              //Add the code for navigation
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              //Add the code for navigation
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

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xfff12d4e),
      child: Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: NetworkImage(
                        'https://images.vexels.com/medi'
                        'a/users/3/147101/isolated/preview/b4a49d4b864c74bb73de63f080ad'
                        '7930-instagram-profile-button-by-vexels.png'),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text('example@gmail.com')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
