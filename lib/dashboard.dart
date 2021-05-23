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
      final user =  _auth.currentUser;
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

  // Future getUserData() async {
  //   QuerySnapshot qn = await _firestore.collection("database").get();
  //   // .doc("$uid")
  //   // .get()
  //   // .then((doc) => doc.data()['name']);
  //   return qn.docs;
  // }

  // void getName() async {
  //   var uid = loggedInUser.email;
  //   final name = await _firestore
  //       .collection('database')
  //       .doc("$uid")
  //       .get()
  //       .then((doc) => doc.data()['name']);
  // }

  // void getUsername() async {
  //   var data = await loggedInUser.uid;
  //   name = await _firestore
  //       .collection('database')
  //       .doc('$data')
  //       .get()
  //       .then((doc) => doc.data()['name']);
  // }

  @override
  Widget build(BuildContext context) {
    // var uid = loggedInUser.email;
    // var uid = loggedInUser.email;
    // Future name = _firestore
    //     .collection('database')
    //     .doc("$uid")
    //     .get()
    //     .then((doc) => doc.data()['name']);

    // var name = ()async {
    //    var uid = loggedInUser.email;
    //     await _firestore
    //        .collection('database')
    //        .doc("$uid")
    //        .get()
    //        .then((doc) => doc.data()['name']);
    //  }

    // setState(() async {
    //   name = await _firestore
    //       .collection('database')
    //       .doc(loggedInUser.email)
    //       .get()
    //       .then((doc) => doc.data()['name']);
    // });

    return Scaffold(drawer: DrawerPage(),
       
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       Container(
      //         height: MediaQuery.of(context).size.width,
      //         color: Colors.red,
      //         child: Column(
      //           children: [ListTile()],
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      // drawer: Drawer(
      //   child: ListView(
      //     children: [
      //       Container(
      //         child: DrawerHeader(
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //           ),
      //
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text(
      //           'Welcome,',
      //           style: TextStyle(
      //             fontStyle: FontStyle.italic,
      //             fontWeight: FontWeight.bold,
      //             fontSize: 25,
      //           ),
      //         ),
      //         Text(
      //           '$uid',
      //           style: TextStyle(
      //             fontSize: 20,
      //             fontWeight: FontWeight.bold,
      //             fontStyle: FontStyle.italic,
      //             color: Color(0xfff12d4e),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      // Container(
      //   height: MediaQuery.of(context).size.width,
      //   color: Color(0xfff12d4e),
      // )
      // ],
      // ),
      // ),
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
            FloatingActionButton(
              heroTag: 'requestAccepted',
              backgroundColor: hasBeenPressed ? Colors.white : Colors.red,
              // onPressed: onPressed
              child: Icon(
                Icons.check,
                color: hasBeenPressed ? Colors.red : Colors.white,
              ),
              onPressed: () {
                // print(await getName());
                // print(name);
                // print(await name.get().then((doc) => doc.data()['name']));
                // Request().requestStream();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RequestAccepted(),
                  ),
                );
              },
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
            FloatingActionButton(
              heroTag: 'request',
              backgroundColor: hasBeenPressed ? Colors.white : Colors.red,
              // onPressed: onPressed
              child: Icon(
                Icons.chat,
                color: hasBeenPressed ? Colors.red : Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Request(),
                  ),
                );
              },
            ),
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
