import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
            StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('formData')
                    // .orderBy('messageTime', descending: true)
                    .snapshots(),
                builder: (context, snap) {
                  if (snap.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snap.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snap.data.docs[index];
                        return Card(
                          elevation: 5.0,
                          color: Color(0xfff85c4d),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "name : " + data['name'],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  "mobileNo : " + data['mobileNo'],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  "State :" + data['state'],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  "Description : " + data['description'],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  "City : " + data['city'],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  "Age : " + data['age'],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                Text(
                                  "Requirement : " + data['selectedMedicine'],
                                  style: TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },

                      // return NotificationUI(
                      //   address: data['city'],
                      //   name: data['name'],
                      //   mobileNo: data['mobileNo'],
                      //
                      //   // distance: Geolocator.distanceBetween(
                      //   //         request['latitude'],
                      //   //         request['longitude'],
                      //   //         19.920600079349757,
                      //   //         75.01306136879904) /
                      //   //     1000,
                      //   // uid: request.id,
                      //   // userEmail: uid,
                      //   // requestLatitude: request['latitude'],
                      //   // requestLongitude: request['longitude'],
                      //   // name: uid,
                      //   // name: _firestore
                      //   //     .collection('database')
                      //   //     .doc("$uid")
                      //   //     .get()
                      //   //     .then((doc) => doc.data()['name']),
                      // );
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
