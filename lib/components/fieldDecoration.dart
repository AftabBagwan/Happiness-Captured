import 'package:flutter/material.dart';

InputDecoration decoration({IconData icon, String text}) {
  return InputDecoration(
    prefixIcon: new Icon(
      icon,
      size: 30,
    ),
    hintText: text,
    contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
  );
}

InputDecoration formFieldDecoration(
    {IconData icon, String hintText, String labelText}) {
  return InputDecoration(
      prefixIcon: Icon(icon),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
        color: Colors.red,
        fontSize: 15.0,
        fontWeight: FontWeight.w500,
      ));
}

InputDecoration signInFormFieldDecoration(
    String emailText, IconData icon, String text) {
  return InputDecoration(
    errorText: emailText,
    prefixIcon: new Icon(
      icon,
      size: 30,
    ),
    hintText: text,
    contentPadding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(20.0),
      ),
    ),
  );
}
