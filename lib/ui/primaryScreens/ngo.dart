import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos/components/notificationUI.dart';

class NGO extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff12d4e),
        title: Text(
          'Hppiness Captured',
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder(
                stream: _firestore
                    .collection('formData')
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: snapshot.data.docs.map((formData) {
                        return NotificationUI(
                          address: formData['city'],
                          name: formData['name'],
                          mobileNo: formData['mobileNo'],
                          // distance: Geolocator.distanceBetween(
                          //         request['latitude'],
                          //         request['longitude'],
                          //         19.920600079349757,
                          //         75.01306136879904) /
                          //     1000,
                          // uid: request.id,
                          // userEmail: uid,
                          // requestLatitude: request['latitude'],
                          // requestLongitude: request['longitude'],
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
          ],
        ),
      ),
    );
  }
}
