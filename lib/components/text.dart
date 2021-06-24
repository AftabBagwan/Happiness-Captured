import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  const BigText({
    Key key,
    this.bigText,
  }) : super(key: key);

  final bigText;

  @override
  Widget build(BuildContext context) {
    return Text(
      bigText,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class SmallText extends StatelessWidget {
  const SmallText({
    Key key,
    this.smallText,
  }) : super(key: key);

  final smallText;

  @override
  Widget build(BuildContext context) {
    return Text(
      smallText,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.grey,
      ),
    );
  }
}
