import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPanel extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Happiness Captured',
        ),
        backgroundColor: Color(0xfff12d4e),
      ),
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
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
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
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
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
