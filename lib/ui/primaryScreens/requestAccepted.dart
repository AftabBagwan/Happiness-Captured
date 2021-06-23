import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:geolocator/geolocator.dart';
import '../../components/notificationUI.dart';

class RequestAccepted extends StatelessWidget {
  @override
  final _firestore = FirebaseFirestore.instance;
  void getMessage() {
    _firestore.collection('request').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print(doc.data());
      });
    });
  }

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
                      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      children: snapshot.data.docs.map((request) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(13),
                            elevation: 5.0,
                            color: Colors.green,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Name:' + request['name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  'Mobile No:' + request['mobile'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  'Accepted By:' + request['AcceptedBy'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
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
