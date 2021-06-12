import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'request.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';

class PopUp extends StatefulWidget {
  String name;
  String address;
  String mobileNo;
  String userEmail;
  var requestLatitude;
  var requestLongitude;
  var uid;
  PopUp({
    Key key,
    @required this.name,
    this.address,
    this.mobileNo,
    this.uid,
    this.userEmail,
    this.requestLatitude,
    this.requestLongitude,
  }) : super(key: key);

  @override
  _PopUpState createState() => _PopUpState();
}

class _PopUpState extends State<PopUp> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    var lat = widget.requestLatitude;
    var long = widget.requestLongitude;
    // String address = ,
    return SingleChildScrollView(
      child: Container(
        height: 400,
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              widget.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(widget.address,
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.normal,
                )),
            SizedBox(
              height: 10,
            ),
            Text(widget.mobileNo,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontStyle: FontStyle.normal,
                )),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  child: Row(
                    children: [
                      Icon(
                        Icons.check,
                      ),
                      Text(
                        'Accept',
                      ),
                    ],
                  ),
                  color: Colors.green,
                  onPressed: () {},
                ),
                // SizedBox(
                //   width: spacee,
                // ),
                MaterialButton(
                  child: Row(
                    children: [
                      Icon(
                        Icons.close,
                      ),
                      Text(
                        'Reject',
                      ),
                    ],
                  ),
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                      _firestore
                          .collection('deleted')
                          .doc(widget.userEmail)
                          .update({'${widget.uid}': ''});
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Navigate',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Icon(Icons.location_history)
                ],
              ),
              color: Colors.orange,
              onPressed: () {
                MapsLauncher.launchCoordinates(lat, long);
              },
            ),
          ],
        ),
      ),
    );
  }
}
