import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key key,
    @required this.hasBeenPressed,
    this.icon,
    this.page,
    this.heroTag,
  }) : super(key: key);

  final bool hasBeenPressed;
  final Icon icon;
  final page;
  final String heroTag;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      backgroundColor: hasBeenPressed ? Colors.white : Colors.red,
      // onPressed: onPressed
      child: icon,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => page,
          ),
        );
      },
    );
  }
}
