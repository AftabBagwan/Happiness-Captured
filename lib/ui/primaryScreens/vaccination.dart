import 'package:flutter/material.dart';
import 'package:sos/components/appBar.dart';

class Vaccination extends StatelessWidget {
  static const String id = 'vaccination';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Under Maintenance',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            'This Feature will be available soon',
            style: TextStyle(
              fontSize: 20,
            ),
          )
        ],
      ),
    );
  }
}
