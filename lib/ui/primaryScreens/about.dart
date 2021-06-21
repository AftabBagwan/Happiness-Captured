import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Happiness Captured',
        ),
        backgroundColor: Color(0xfff12d4e),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'XYZ',
              style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
            ),
            Divider(),
            Text(
              'Copyright 2021',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 3.0),
              child: Text(
                  'This application is basically to provide help to people who stucked in emergency situation.'),
            )
          ],
        ),
      ),
    );
  }
}
