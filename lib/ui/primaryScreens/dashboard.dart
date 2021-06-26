import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sos/components/appBar.dart';
import 'package:sos/ui/secondaryScreens/drawerpage.dart';
import 'package:sos/ui/primaryScreens/requestAccepted.dart';
import 'request.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import '../../components/actionButton.dart';
import 'package:sos/components/dashboardText.dart';

class Dashboard extends StatefulWidget {
  static const String id = 'dashboard';
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
  var data;
  var key;

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
      data = loggedInUser.email;
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
    if(mounted)
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    String userEmail = loggedInUser.email;
    return Scaffold(
      drawer: DrawerPage(
        name: name,
        email: loggedInUser.email,
      ),
      backgroundColor: hasBeenPressed ? Color(0xfff85c4d) : Colors.white,
      appBar: appBar(),
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
                _firestore..collection('request').doc('$key').delete();
              },
            ),
            FloatingActionButton(
              heroTag: 'requestPage',
              backgroundColor: hasBeenPressed ? Colors.white : Colors.red,
              child: Icon(
                Icons.notifications,
                color: hasBeenPressed ? Colors.red : Colors.white,
              ),
              onPressed: () async {
                // Position position1 = await Geolocator.getCurrentPosition(
                //     desiredAccuracy: LocationAccuracy.bestForNavigation);
                // _firestore
                //     .collection('userCurrentCoordinates')
                //     .doc(userEmail)
                //     .set({
                //   'latitude': position1.latitude,
                //   'longitude': position1.longitude,
                // });

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Request(
                        uid: loggedInUser.email,
                      ),
                    ));
              },
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
                  // bool isLocationServiceEnabled =
                  //     await Geolocator.isLocationServiceEnabled();
                  // if (isLocationServiceEnabled) {
                  hasBeenPressed = true;
                  Position position2 = await Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.bestForNavigation);
                  final coordinates =
                      new Coordinates(position2.latitude, position2.longitude);
                  var addresses = await Geocoder.local
                      .findAddressesFromCoordinates(coordinates);
                  var first = addresses.first;
                  request = "${first.featureName} : ${first.addressLine}";
                  key = UniqueKey();
                  _firestore.collection('request').doc("$key").set({
                    'address': request,
                    'sender': loggedInUser.email,
                    'name': name,
                    'mobile': mobileNo,
                    'latitude': position2.latitude,
                    'longitude': position2.longitude,
                    "messageTime": DateTime.now(),
                    'AcceptedBy': '',
                  });
                  // } else {
                  //   await Geolocator.requestPermission();
                  // }
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
                : 'After pressing the SOS button three times, we will contact the nearest person or volunteer !',
            color: hasBeenPressed ? Colors.white : Colors.red,
          ),
        ],
      ),
    );
  }
}
