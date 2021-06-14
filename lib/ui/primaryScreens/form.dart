import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final CollectionReference formData =
      FirebaseFirestore.instance.collection('formData');

  String mobileNo;
  String age;
  String hospitalName;
  String description;
  String stateValue;
  String cityValue;
  String countryValue;
  String name;

  final _formKey = GlobalKey<FormState>();

  List<String> _medicines = [
    'Remedesivir',
    'Plasma',
    'Oxygen Cylinder',
    'Tocilizumab',
    'Oxygen Bed',
    'Others'
  ];

  String _selectedmedicines;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Post Your Queries'),
      ),
      body: Container(
          padding: EdgeInsets.fromLTRB(30, 30, 30, 30),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    onChanged: (text) {
                      name = text;
                    },
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.location_history),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        hintText: 'Enter Your Name',
                        labelText: 'Name',
                        labelStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    onChanged: (text) {
                      mobileNo = text;
                    },
                    validator: (newValue) {
                      if (newValue == null || newValue.isEmpty) {
                        return 'Please Enter Valid data';
                      }
                      return null;
                    },
                    maxLength: 10,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        hintText: 'Enter Your Contact Number',
                        labelText: 'Mobile Number',
                        labelStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  CSCPicker(
                    showStates: true,
                    showCities: true,
                    flagState: CountryFlag.ENABLE,
                    dropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                        border: Border.all(color: Colors.grey, width: 1)),
                    disabledDropdownDecoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey.shade300,
                        border: Border.all(color: Colors.grey, width: 1)),
                    selectedItemStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    dropdownHeadingStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.bold),
                    dropdownItemStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    dropdownDialogRadius: 10.0,
                    searchBarRadius: 10.0,
                    defaultCountry: DefaultCountry.India,
                    onCountryChanged: (text) {
                      setState(() {
                        countryValue = text;
                      });
                    },
                    onStateChanged: (text) {
                      setState(() {
                        stateValue = text;
                      });
                    },
                    onCityChanged: (text) {
                      setState(() {
                        cityValue = text;
                      });
                    },
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      hospitalName = text;
                    },
                    validator: (newValue) {
                      if (newValue == null || newValue.isEmpty) {
                        return 'Please Enter Valid data';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        hintText: 'Name Of the hospital',
                        labelText: 'Hospital Name',
                        labelStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    onChanged: (text) {
                      age = text;
                    },
                    validator: (newValue) {
                      if (newValue == null || newValue.isEmpty) {
                        return 'Please Enter Valid data';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        hintText: 'Age',
                        labelText: 'Enter Your Age',
                        labelStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Colors.black, width: 0.5)),
                    child: DropdownButton(
                      isExpanded: true,
                      hint: Text('Please choose your requirement'),
                      value: _selectedmedicines,
                      onChanged: (value) {
                        setState(() {
                          _selectedmedicines = value;
                        });
                      },
                      items: _medicines.map((location) {
                        return DropdownMenuItem(
                          child: Text(
                            location,
                            style: TextStyle(color: Colors.black),
                          ),
                          value: location,
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  TextField(
                    onChanged: (text) {
                      if (text == null || text.isEmpty) {
                        return 'Enter valid data';
                      }
                      description = text;
                    },
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        hintText: 'If others then please mention here',
                        labelText: 'Description',
                        labelStyle: TextStyle(
                          color: Colors.red,
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                        )),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.red),
                    child: Text(
                      'Post',
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                        formData.add({
                          'name': name,
                          'mobileNo': mobileNo,
                          'state': stateValue,
                          'city': cityValue,
                          'selectedMedicine': _selectedmedicines,
                          'hospitalName': hospitalName,
                          'description': description,
                          'age': age,
                          'time': DateTime.now(),
                        });
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => PostHistory()));
                      }
                    },
                  )
                ],
              ),
            ),
          )),
    );
  }
}
