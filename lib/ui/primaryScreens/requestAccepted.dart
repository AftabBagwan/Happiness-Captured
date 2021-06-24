import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/painting.dart';
import 'package:sos/components/appBar.dart';
import 'package:sos/components/constants.dart';

class RequestAccepted extends StatelessWidget {
  static const String id = 'requestAccepted';

  final _firestore = FirebaseFirestore.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
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
                                Text('Name:' + request['name'],
                                    style: kRequestAcceptStyle),
                                Text('Mobile No:' + request['mobile'],
                                    style: kRequestAcceptStyle),
                                Text('Accepted By:',
                                    style: kRequestAcceptStyle),
                                Text(request['AcceptedBy'],
                                    style: kRequestAcceptStyle),
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
