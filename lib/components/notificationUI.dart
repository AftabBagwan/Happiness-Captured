import 'package:flutter/material.dart';
import '../ui/secondaryScreens/popup.dart';

class NotificationUI extends StatelessWidget {
  NotificationUI({
    this.sender,
    this.address,
    this.name,
    this.mobileNo,
    this.distance,
    this.uid,
    this.userEmail,
    this.requestLatitude,
    this.requestLongitude,
    this.requestAddress,
  });
  final sender;
  final address;
  final name;
  final mobileNo;
  final distance;
  final uid;
  final userEmail;
  final requestLatitude;
  final requestLongitude;
  final requestAddress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet<void>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              context: context,
              builder: (BuildContext context) {
                return PopUp(
                  name: name,
                  address: address,
                  mobileNo: mobileNo,
                  uid: uid,
                  userEmail: userEmail,
                  requestLatitude: requestLatitude,
                  requestLongitude: requestLongitude,
                );
              });
        },
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(10),
          color: Color(0xfff85c4d),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Text(
                  '$name',
                ),
                Text(
                  "Address: " + address,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                Text(
                  '$mobileNo',
                ),
                Text(
                  '$distance',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
