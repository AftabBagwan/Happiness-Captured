import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sos/drawerpage.dart';
import 'package:sos/requestAccepted.dart';
import 'request.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  int counter = 0;
  bool hasBeenPressed = false;
  String request;
  var name;
  var mobileNo;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
      }
      var data = loggedInUser.email;
      name = await _firestore
          .collection('database')
          .doc('$data')
          .get()
          .then((doc) => doc.data()['name']);
      mobileNo = await _firestore
          .collection('database')
          .doc('$data')
          .get()
          .then((doc) => doc.data()['mobile']);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPage(),
      backgroundColor: hasBeenPressed ? Color(0xfff85c4d) : Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xfff12d4e),
        title: Text(
          'Happiness Captured',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ActionButton(
              heroTag: 'RequestAcceptedPage',
              hasBeenPressed: hasBeenPressed,
              page: RequestAccepted(),
              icon: Icon(
                Icons.check,
                color: hasBeenPressed ? Colors.red : Colors.white,
              ),
            ),
            FloatingActionButton(
              heroTag: 'end',
              backgroundColor: hasBeenPressed ? Colors.white : Colors.red,
              child: Icon(
                Icons.close,
                color: hasBeenPressed ? Colors.red : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  hasBeenPressed = false;
                  counter = 0;
                });
              },
            ),
            ActionButton(
              heroTag: 'requestPage',
              hasBeenPressed: hasBeenPressed,
              icon: Icon(
                Icons.chat,
                color: hasBeenPressed ? Colors.red : Colors.white,
              ),
              page: Request(),
            )
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: TextButton(
              onPressed: () async {
                setState(() {
                  counter++;
                });
                if (counter == 3) {
                  bool isLocationServiceEnabled =
                      await Geolocator.isLocationServiceEnabled();
                  if (isLocationServiceEnabled) {
                    hasBeenPressed = true;
                    Position position = await Geolocator.getLastKnownPosition();
                    Position position2 = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.high);
                    print(position);
                    print(position2);
                    final coordinates =
                        new Coordinates(position.latitude, position.longitude);
                    var addresses = await Geocoder.local
                        .findAddressesFromCoordinates(coordinates);
                    var first = addresses.first;
                    print("${first.featureName} : ${first.addressLine}");
                    request = "${first.featureName} : ${first.addressLine}";
                    _firestore.collection('request').add({
                      'address': request,
                      'sender': loggedInUser.email,
                      'name': name,
                      'mobile': mobileNo,
                      'latitude': position.latitude,
                      'longitude': position.longitude,
                    });
                  } else {
                    // ignore: unused_local_variable
                    LocationPermission permission =
                        await Geolocator.requestPermission();
                  }
                }
              },
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  'SOS',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: hasBeenPressed ? Colors.red : Colors.white,
                  ),
                ),
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: hasBeenPressed
                            ? Color.fromARGB(100, 255, 255, 255)
                            : Color.fromARGB(100, 255, 0, 61),
                        blurRadius: 20,
                        spreadRadius: 20)
                  ],
                  shape: BoxShape.circle,
                  color: hasBeenPressed ? Colors.white : Color(0xfff12d4e),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          DashboardText(
            text: hasBeenPressed
                ? 'Please standby, we are currently requesting for help.'
                : 'After pressing the SOS button, we will contact the nearest person or volunteer !',
            color: hasBeenPressed ? Colors.white : Colors.red,
            // 'After pressing the SOS button, we will contact the nearest person or volunteer !',
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key key,
    @required this.hasBeenPressed,
    this.icon,
    this.page,
    this.heroTag,
  }) : super(key: key);

  final bool hasBeenPressed;
  final Icon icon;
  final page;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      backgroundColor: hasBeenPressed ? Colors.white : Colors.red,
      // onPressed: onPressed
      child: icon,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
    );
  }
}

class DashboardText extends StatelessWidget {
  DashboardText({this.text, this.color});
  final text;
  final color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
