import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sos/ui/secondaryScreens/drawerpage.dart';
import 'package:sos/ui/primaryScreens/requestAccepted.dart';
import 'request.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import '../../components/actionButton.dart';
import 'package:sos/components/dashboardText.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedInUser;
  int counter = 0;
  bool hasBeenPressed = false;
  String request;
  var name;
  var mobileNo;
  var data;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerPage(
        name: name,
        email: loggedInUser.email,
      ),
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
                Icons.notifications,
                color: hasBeenPressed ? Colors.red : Colors.white,
              ),
              page: Request(
                uid: loggedInUser.email,
              ),
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
                    Position position2 = await Geolocator.getCurrentPosition(
                        desiredAccuracy: LocationAccuracy.bestForNavigation);
                    print(position2);
                    final coordinates = new Coordinates(
                        position2.latitude, position2.longitude);
                    var addresses = await Geocoder.local
                        .findAddressesFromCoordinates(coordinates);
                    var first = addresses.first;
                    print("${first.featureName} : ${first.addressLine}");
                    request = "${first.featureName} : ${first.addressLine}";

                    // var batch = _firestore.batch();

                    // batch.set(
                    //     _firestore
                    //         .collection('database')
                    //         .doc()
                    //         .collection('requests')
                    //         .doc(),
                    //     {
                    //       'address': request,
                    //       'sender': loggedInUser.email,
                    //       'name': name,
                    //       'mobile': mobileNo,
                    //       'latitude': position.latitude,
                    //       'longitude': position.longitude,
                    //     });
                    // batch.commit();
                    //
                    // var requests =
                    //     _firestore.collection("database").doc("$data");

                    // requests.update

                    // requests.update({
                    //   request1: firebase.firestore.FieldValue.arrayUnion("greater_virginia")
                    // });

                    // var docData = {
                    //   [
                    //     'address: $request',
                    //     'sender: $loggedInUser.email',
                    //     'name: $name',
                    //     'mobile: $mobileNo',
                    //     'latitude: $position.latitude',
                    //     'longitude: $position.longitude',
                    //   ]
                    // };

                    // var docData = {
                    //   stringExample: "Hello world!",
                    //   booleanExample: true,
                    //   numberExample: 3.14159265,
                    //   dateExample: firebase.firestore.Timestamp
                    //       .fromDate(new Date("December 10, 1815")),
                    //   arrayExample: [5, true, "hello"],
                    //   nullExample: null,
                    //   objectExample: {
                    //     a: 5,
                    //     b: {nested: "foo"}
                    //   }
                    // };

                    // _firestore.collection("database").doc("$data").set(docData);
                    // requests.update({
                    //   request: FieldValue
                    //       .arrayUnion("greater_virginia")
                    // });

                    _firestore.collection('request').add({
                      'address': request,
                      'sender': loggedInUser.email,
                      'name': name,
                      'mobile': mobileNo,
                      'latitude': position2.latitude,
                      'longitude': position2.longitude,
                      "messageTime": DateTime.now(),
                    });

                    // var ref = _firestore.collection('request').;
                    // var now = DateTime.now();
                    // var cutoff = now.millisecond - 2 * 60 * 60 * 1000;
                    // var old = ref.orderByChild('messageTime').endAt(cutoff).limitToLast(1);
                    // var listener = old.on('child_added', function(snapshot) {
                    // snapshot.ref.remove();
                    // });

                    // _firestore.collection(collectionPath).set({
                    //   name: "Frank",
                    //   favorites: { food: "Pizza", color: "Blue", subject: "recess" },
                    //   age: 12
                    // });

                    // Batch wise update also field map
                    // Future<void> batchUpdate() {
                    //   WriteBatch batch = FirebaseFirestore.instance.batch();
                    //   var v1 = uuid.v1();
                    //   return _firestore
                    //       .collection('request')
                    //       .get()
                    //       .then((querySnapshot) {
                    //     querySnapshot.docs.forEach((document) {
                    //       batch.update(document.reference, {
                    //         '$v1': {
                    //           'address': request,
                    //           'sender': loggedInUser.email,
                    //           'name': name,
                    //           'mobile': mobileNo,
                    //           'latitude': position.latitude,
                    //           'longitude': position.longitude,
                    //         }
                    //       });
                    //     });
                    //
                    //     return batch.commit();
                    //   });
                    // }

                    // batchUpdate();
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
                : 'After pressing the SOS button three times, we will contact the nearest person or volunteer !',
            color: hasBeenPressed ? Colors.white : Colors.red,
            // 'After pressing the SOS button, we will contact the nearest person or volunteer !',
          ),
        ],
      ),
    );
  }
}
