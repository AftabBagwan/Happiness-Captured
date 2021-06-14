import 'package:flutter/material.dart';

class DashboardText extends StatelessWidget {
  DashboardText({this.text, this.color});
  final text;
  final color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
