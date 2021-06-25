import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:sos/ui/primaryScreens/ngo.dart';
import 'package:sos/components/fieldDecoration.dart';
import 'package:sos/components/appBar.dart';

class FormPage extends StatefulWidget {
  static const String id = 'form';

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final CollectionReference formData =
      FirebaseFirestore.instance.collection('formData');

  _FormPageState(
      {this.mobileNo,
      this.age,
      this.hospitalName,
      this.description,
      this.stateValue,
      this.cityValue,
      this.name,
      this.countryValue,
      this.selectedMedicines});
  String mobileNo;
  String age;
  String hospitalName;
  String description;
  String stateValue = '';
  String cityValue = '';
  String countryValue;
  String name;
  String selectedMedicines;
  final _formKey = GlobalKey<FormState>();

  List<String> _medicines = [
    'Plasma',
    'Oxygen Cylinder',
    'Tocilizumab',
    'Oxygen Bed',
    'Others'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
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
                    validator: (newValue) {
                      if (newValue == null || newValue.isEmpty) {
                        return 'Please Enter Valid data';
                      }
                      return null;
                    },
                    decoration: formFieldDecoration(
                        icon: Icons.account_circle,
                        hintText: 'Enter your name',
                        labelText: 'Name'),
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
                    decoration: formFieldDecoration(
                      icon: Icons.phone,
                      labelText: 'Mobile Number',
                      hintText: 'Enter your contact number',
                    ),
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
                      decoration: formFieldDecoration(
                        icon: Icons.local_hospital,
                        hintText: 'Name of the hospital',
                        labelText: 'Hospital Name',
                      )),
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
                      decoration: formFieldDecoration(
                          icon: Icons.calendar_today_sharp,
                          labelText: 'Age',
                          hintText: 'Enter your age')),
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(color: Colors.black, width: 0.5)),
                    child: DropdownButtonFormField(
                      validator: (value) =>
                          value == null ? 'Field required' : null,
                      isExpanded: true,
                      hint: Text('Please choose your requirement'),
                      value: selectedMedicines,
                      onChanged: (value) {
                        setState(() {
                          selectedMedicines = value;
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
                  TextFormField(
                      onChanged: (text) {
                        description = text;
                      },
                      validator: (newValue) {
                        if (newValue == null || newValue.isEmpty) {
                          return 'Please Enter Valid data';
                        }
                        return null;
                      },
                      decoration: formFieldDecoration(
                        icon: Icons.details,
                        hintText: 'Describe the requirement here',
                        labelText: 'Description',
                      )),
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
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Processing Data'),
                          duration: Duration(seconds: 1),
                        ));
                        formData.add({
                          'name': name,
                          'mobileNo': mobileNo,
                          'state': stateValue,
                          'city': cityValue,
                          'selectedMedicine': selectedMedicines,
                          'hospitalName': hospitalName,
                          'description': description,
                          'age': age,
                          'time': DateTime.now(),
                        });
                        Navigator.pushNamed(context, NGO.id);
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
