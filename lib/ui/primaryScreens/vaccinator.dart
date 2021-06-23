import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String api = "https://cdn-api.co-vin.in/api/v2/auth/public/generateOTP";

class Vaccinator extends StatefulWidget {
  @override
  _VaccinatorState createState() => _VaccinatorState();
}

class _VaccinatorState extends State<Vaccinator> {
  // ignore: unused_field
  Welcome _welcome;
  TextEditingController mobilecontroller = TextEditingController();

  Future<Welcome> getData(mobile) async {
    var response = await http.post(Uri.parse(api), body: {"mobile": mobile});

    // return json.decode(data);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vaccinator"),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: mobilecontroller,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                prefixIcon: new Icon(
                  Icons.account_circle,
                  size: 30,
                ),
                hintText: 'Enter your mobile number',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 25.0, horizontal: 30.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextButton(
              // onPressed: onPressed, child: child
              onPressed: () async {
                String mobile = mobilecontroller.text;
                Welcome data = await getData(mobile);

                setState(() {
                  _welcome = data;
                });
              },
              child: Text(
                'Generate OTP',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.txnId,
  });

  String txnId;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        txnId: json["txnId"],
      );

  Map<String, dynamic> toJson() => {
        "txnId": txnId,
      };
}
