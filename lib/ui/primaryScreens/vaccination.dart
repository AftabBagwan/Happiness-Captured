import 'package:flutter/material.dart';

class Vaccination extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff12d4e),
        title: Text(
          'Happiness Captured',
        ),
      ),
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
