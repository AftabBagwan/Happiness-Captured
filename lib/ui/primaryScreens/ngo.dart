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
            StreamBuilder(
                stream: _firestore
                    .collection('formdata')
                    // .orderBy('messageTime', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data.docs[index];
                        return Card(
                          
                          elevation: 5.0,
                          color: Color(0xfff85c4d),
                          child: Column(
                            children: [
                              Text(
                                data['name'],
                              ),
                              // Text(
                              //   data['mobileNo'],
                              // ),
                              // Text(
                              //   data['state'],
                              // ),
                              // Text(
                              //   data['description'],
                              // ),
                              // Text(
                              //   data['city'],
                              // ),
                              // Text(
                              //   data['age'],
                              // ),
                              
                            ],
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
