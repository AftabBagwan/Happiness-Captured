import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'signin.dart';

class LocationPage extends StatefulWidget {
  static const String id = 'locationPage';
  LocationPage({Key key, @required this.email}) : super(key: key);
  final String email;
  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Position position;
  var finalAddress = '';
  final _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    String userEmail = widget.email;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(30, 20, 30, 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Update Your',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Primary Location,',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    height: 150,
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        finalAddress,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Container(
                    width: 200,
                    height: 50,
                    color: Colors.red,
                    child: MaterialButton(
                      child: Text(
                        'Fetch Location',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () async {
                        position = await Geolocator.getCurrentPosition(
                            desiredAccuracy: LocationAccuracy.high);
                        final coordinates = new Coordinates(
                            position.latitude, position.longitude);
                        var addresses = await Geocoder.local
                            .findAddressesFromCoordinates(coordinates);
                        var first = addresses.first;
                        setState(() {
                          finalAddress =
                              "${first.featureName} : ${first.addressLine}";
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Click here to fetch your current and primary location',
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Container(
                    width: 300,
                    height: 50,
                    color: Colors.red,
                    child: MaterialButton(
                      child: Text(
                        'Update',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, SignIn.id);
                        _firestore
                            .collection('database')
                            .doc('$userEmail')
                            .update({
                          'PrimaryAddress': finalAddress,
                          'PrimaryLatitude': position.latitude,
                          'PrimaryLongitude': position.longitude,
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    'Click here to update your current location as an primary location in database')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
