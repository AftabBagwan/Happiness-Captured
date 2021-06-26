import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:geolocator/geolocator.dart';
import '../../components/notificationUI.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sos/components/appBar.dart';

class Request extends StatefulWidget {
  Request({Key key, @required this.uid}) : super(key: key);
  final String uid;
  @override
  _RequestState createState() => _RequestState();
}

class _RequestState extends State<Request> {
  User loggedInUser;
  bool loading = true;
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    loggedInUser = _auth.currentUser;
    userCoordinates();
  }

  var userLat;
  var userLong;
  final _firestore = FirebaseFirestore.instance;

  void userCoordinates() async {
    Position position1 = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    _firestore
        .collection('userCurrentCoordinates')
        .doc(loggedInUser.email)
        .set({
      'latitude': position1.latitude,
      'longitude': position1.longitude,
    });

    userLat = await _firestore
        .collection('userCurrentCoordinates')
        .doc(loggedInUser.email)
        .get()
        .then((doc) => doc.data()['latitude']);
    userLong = await _firestore
        .collection('userCurrentCoordinates')
        .doc(loggedInUser.email)
        .get()
        .then((doc) => doc.data()['longitude']);
    if (mounted) setState(() {});
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  StreamBuilder(
                      stream: _firestore
                          .collection('request')
                          .orderBy('messageTime', descending: true)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Expanded(
                          child: ListView(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            children: snapshot.data.docs.map((request) {
                              return NotificationUI(
                                address: request['address'],
                                name: request['name'],
                                mobileNo: request['mobile'],
                                distance: Geolocator.distanceBetween(
                                        request['latitude'],
                                        request['longitude'],
                                        userLat,
                                        userLong) /
                                    1000,
                                uid: request.id,
                                userEmail: widget.uid,
                                requestLatitude: request['latitude'],
                                requestLongitude: request['longitude'],
                              );
                            }).toList(),
                          ),
                        );
                      }),
                ],
              ),
      ),
    );
  }
}
