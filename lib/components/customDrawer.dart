import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({Key key, @required this.name}) : super(key: key);
  final name;

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    String userName = widget.name;
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
                  Text(
                    '$userName',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
