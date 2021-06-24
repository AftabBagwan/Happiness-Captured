import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class PopUp extends StatefulWidget {
  static const String id = 'popup';
  final name;
  final address;
  final mobileNo;
  final userEmail;
  final requestLatitude;
  final requestLongitude;
  final uid;

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

launchCaller(mobileNo) async {
  var url = "tel:" + mobileNo;
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class _PopUpState extends State<PopUp> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    String share;
    var lat = widget.requestLatitude;
    var long = widget.requestLongitude;
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
            GestureDetector(
              onTap: () async {
                await launchCaller(widget.mobileNo.toString());
              },
              child: Text(widget.mobileNo,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontStyle: FontStyle.normal,
                  )),
            ),
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
                  onPressed: () {
                    _firestore
                        .collection('request')
                        .doc(widget.uid)
                        .update({'AcceptedBy': widget.userEmail});
                    Navigator.pop(context);
                  },
                  //
                ),
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
                    });
                  },
                ),
                MaterialButton(
                    color: Colors.blue,
                    child: Row(
                      children: [
                        Icon(
                          Icons.share,
                        ),
                        Text("Share"),
                      ],
                    ),
                    onPressed: () {
                      share = 'Name : ' +
                          widget.name +
                          ',' +
                          'Address : ' +
                          widget.address +
                          ', Mobile : ' +
                          widget.mobileNo;

                      final RenderBox box = context.findRenderObject();

                      Share.share(share,
                          subject: widget.name,
                          sharePositionOrigin:
                              box.localToGlobal(Offset.zero) & box.size);
                    }),
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
