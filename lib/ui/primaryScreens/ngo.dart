import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos/components/constants.dart';
import 'package:sos/components/appBar.dart';

class NGO extends StatelessWidget {
  static const String id = 'ngo';

  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('formData')
                    .orderBy('time', descending: true)
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
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 10),
                          child: Material(
                            borderRadius: BorderRadius.circular(10),
                            elevation: 12.0,
                            color: Color(0xfff85c4d),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Column(
                                children: [
                                  Text("Name : " + data['name'],
                                      style: kNgoStyle),
                                  Text("Age : " + data['age'],
                                      style: kNgoStyle),
                                  Text("Mobile No : " + data['mobileNo'],
                                      style: kNgoStyle),
                                  Text("State :" + data['state'],
                                      style: kNgoStyle),
                                  Text("City : " + data['city'],
                                      style: kNgoStyle),
                                  Text("Description : " + data['description'],
                                      style: kNgoStyle),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
