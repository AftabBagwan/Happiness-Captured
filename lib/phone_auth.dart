import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sos/phone_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class PhoneAuth extends StatelessWidget {
  const PhoneAuth({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final _scaffoldKey = GlobalKey<ScaffoldState>();

    final TextEditingController _phoneNumberController =
        TextEditingController();
    final TextEditingController _smsController = TextEditingController();
    String _verificationId;

    return Container();
  }
}
