import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos/components/appBar.dart';
import 'package:sos/components/constants.dart';

class AdminPanel extends StatelessWidget {
  static const String id = 'adminPanel';
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: 300,
              height: 50,
              color: Colors.green,
              child: MaterialButton(
                onPressed: () {
                  _firestore.collection('request').get().then((snapshot) {
                    for (DocumentSnapshot ds in snapshot.docs) {
                      ds.reference.delete();
                    }
                  });
                },
                child: Text(
                  'Delete User Request',
                  style: kButtonTextStyle,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'User Request Delete Option For App Optimisation',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: 300,
            height: 50,
            color: Colors.green,
            child: MaterialButton(
              onPressed: () {
                _firestore.collection('formData').get().then((snapshot) {
                  for (DocumentSnapshot ds in snapshot.docs) {
                    ds.reference.delete();
                  }
                });
              },
              child: Text(
                'Delete NGO Request',
                style: kButtonTextStyle,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'NGO Request Delete Option For Form Optimisation',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
