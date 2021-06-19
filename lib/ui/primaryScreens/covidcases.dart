import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timeago/timeago.dart';

class Covid {
  int confvalue;
  int recvalue;
  int deaths;
  String lastupdate;

  Covid({this.confvalue, this.recvalue, this.deaths, this.lastupdate});

  factory Covid.fromJson(Map<dynamic, dynamic> json) {
    return Covid(
        confvalue: json['confirmed']['value'] as int,
        recvalue: json['recovered']['value'] as int,
        deaths: json['deaths']['value'] as int,
        lastupdate: json['lastUpdate'] as String);
  }
}


Future<Covid> getIndiaCount() async {
  final response = await http.get(Uri.parse('https://corona-virus-world-and-india-data.p.rapidapi.com/api_india'),
  headers: {
    "x-rapidapi-key": "592162e179mshe71f29f3012a2cap16cb1djsnb5789cec38b1",
	  "x-rapidapi-host": "corona-virus-world-and-india-data.p.rapidapi.com",
  }
  );
  return Covid.fromJson(json.decode(response.body));
}

class CovidCases extends StatefulWidget {
  @override
  _CovidCasesState createState() => _CovidCasesState();
}

class _CovidCasesState extends State<CovidCases> {
  Covid covid_res;
  bool countloading;

  @override
  void initState() {
    super.initState();
    loadcount();
  }

  Future<void> loadcount() async {
    setState(() {
      countloading = true;
    });
    covid_res = await getIndiaCount();
    print("covid deaths is" + covid_res.deaths.toString());
    setState(() {
      countloading = false;
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
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.info_outline,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("India Corona Cases",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      )),
                ],
              ),
              Divider(),
              Row(
                children: <Widget>[
                  //Icon(Icons.timer, color: Colors.black),
                  //  SizedBox(width: 2),
                  Flexible(
                      child: ListTile(
                    title: Text(
                      "LastUpdated:",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(covid_res.lastupdate, style: TextStyle()),
                  ))
                ],
              ),
              titleWidget('Confirmed', covid_res.confvalue.toString() ?? '',
                  Colors.blue),
              titleWidget('Recovered', covid_res.recvalue.toString() ?? '',
                  Colors.green),
              titleWidget(
                  'Deaths', covid_res.deaths.toString() ?? '', Colors.red),
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
