import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:geolocator/geolocator.dart';

class Request extends StatelessWidget {
  // Request({Key key, @required this.uid}) : super(key: key);
  //
  // final String uid;

  @override
  final _firestore = FirebaseFirestore.instance;
  // void getMessage() {
  //   _firestore.collection('request').get().then((QuerySnapshot querySnapshot) {
  //     querySnapshot.docs.forEach((doc) {
  //       print(doc.data());
  //     });
  //   });
  // }

  void requestStream() async {
    await for (var snapshot in _firestore.collection('request').snapshots()) {
      for (var request in snapshot.docs) {
        print(request.data());
      }
    }
  }

  // final _firestore = FirebaseFirestore.instance;
  // void getMessage() async {
  //   final request = await _firestore.collection('request').get();
  //   for (var request in request.) {
  //     print(request.data);
  //   }
  // }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff12d4e),
        title: Text(
          'Happiness Captured',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder(
                stream: _firestore.collection('request').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Expanded(
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
                                    19.920600079349757,
                                    75.01306136879904) /
                                1000
                            // name: uid,
                            // name: _firestore
                            //     .collection('database')
                            //     .doc("$uid")
                            //     .get()
                            //     .then((doc) => doc.data()['name']),
                            );
                      }).toList(),
                    ),
                  );
                }),

            //   builder: (BuildContext context, snapshot) {
            //     List<dynamic> requestWidgets = [];
            //     if (snapshot.hasData) {
            //       final request = snapshot.data;
            //       for (var request in request) {
            //         final address = request.data['Address'];
            //         final sender = request.data['Sender'];
            //
            //         final requestWidget = Text('$address from $sender');
            //         requestWidgets.add(requestWidget);
            //       }
            //     }
            //     return Column(
            //       children: requestWidgets,
            //     );
            //   },
          ],
        ),
      ),
    );
  }
}

class NotificationUI extends StatelessWidget {
  NotificationUI(
      {this.sender, this.address, this.name, this.mobileNo, this.distance});
  final sender;
  final address;
  final name;
  final mobileNo;
  final distance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(10),
        color: Color(0xfff85c4d),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Text(
                '$name',
              ),
              Text(
                "Address: " + address,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
              Text(
                '$mobileNo',
              ),
              Text(
                '$distance',
              )
            ],
          ),
        ),
      ),
    );
  }
}
