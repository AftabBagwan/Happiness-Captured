import 'package:flutter/material.dart';
class PostHistory extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Post History'
        )
      ),

      body: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          )
        ],

      ),
    );
  }
}
