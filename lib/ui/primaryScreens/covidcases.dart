import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Covid {
  int confirmvalue;
  int recovervalue;
  int deaths;
  String lastupdated;

  Covid({this.confirmvalue, this.recovervalue, this.deaths, this.lastupdated});

  factory Covid.fromJson(Map<dynamic, dynamic> json) {
    return Covid(
        confirmvalue: json['confirmed']['value'] as int,
        recovervalue: json['recovered']['value'] as int,
        deaths: json['deaths']['value'] as int,
        lastupdated: json['lastupdated'] as String);
  }
}

Future<Covid> getIndiaCount() async {
  final response = await http.get(Uri.parse('https://covid19.mathdro.id/api'));
  return Covid.fromJson(json.decode(response.body));
}

class CovidCases extends StatefulWidget {
  @override
  _CovidCasesState createState() => _CovidCasesState();
}

class _CovidCasesState extends State<CovidCases> {
  Covid covidres;
  bool countingload;

  @override
  void initState() {
    super.initState();
    loadcount();
  }

  Future<void> loadcount() async {
    setState(() {
      countingload = true;
    });
    covidres = await getIndiaCount();
    print("covid deaths is" + covidres.deaths.toString());
    setState(() {
      countingload = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Covid Tracker"),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("India Live Corona Cases",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
              Divider(),
              Row(
                children: [
                  //Icon(Icons.timer, color: Colors.black),
                  //  SizedBox(width: 2),
                  Flexible(
                      child: ListTile(
                    title: Text(
                      "lastupdated:",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(covidres.lastupdated.toString(),style: TextStyle(),),
                  ))
                ],
              ),
              titleWidget('Confirmed', covidres.confirmvalue.toString() ?? '',
                  Colors.blue),
              titleWidget('Recovered', covidres.recovervalue.toString() ?? '',
                  Colors.green),
              titleWidget(
                  'Deaths', covidres.deaths.toString() ?? '', Colors.red),
            ],
          ),
        ),
      ),
    );
  }
}

Widget titleWidget(title, subtitle, color) {
  return ListTile(
    title: Text(title,
        style:
            TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.w500)),
    trailing: Text(subtitle, style: TextStyle(color: color, fontSize: 18)),
  );
}
