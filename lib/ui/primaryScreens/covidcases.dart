import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sos/components/extraWidget.dart';

class Covid {
  int confvalue;
  int recvalue;
  int deaths;
  String lastupdate;

  Covid({
    this.confvalue,
    this.recvalue,
    this.deaths,
    this.lastupdate,
  });

  factory Covid.fromJson(Map<dynamic, dynamic> json) {
    return Covid(
        confvalue: json['confirmed']['value'] as int,
        recvalue: json['recovered']['value'] as int,
        deaths: json['deaths']['value'] as int,
        lastupdate: json['lastUpdate'] as String);
  }
}

Future<Covid> getIndiaCount() async {
  final response = await http
      .get(Uri.parse('https://covid19.mathdro.id/api/countries/india'));
  return Covid.fromJson(json.decode(response.body));
}

class CovidCases extends StatefulWidget {
  @override
  _CovidCasesState createState() => _CovidCasesState();
}

class _CovidCasesState extends State<CovidCases> {
  Covid covidres;
  bool countingload = true;

  @override
  void initState() {
    super.initState();
    refreshList();
    loadcount();
  }

  var reloadkey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    if (this.mounted) {
      setState(() {
        countingload = false;
      });
    }
    reloadkey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    covidres = await getIndiaCount();
    if (this.mounted) {
      setState(() {
        countingload = false;
      });
    }

    return null;
  }

  Future<void> loadcount() async {
    setState(() {
      countingload = true;
    });
    covidres = await getIndiaCount();
    setState(() {
      countingload = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Covid Tracker"),
      ),
      body: countingload
          ? Center(child: CircularProgressIndicator())
          : Container(
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
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("India Live Corona Cases",
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: ListTile(
                          title: Text(
                            "LastUpdated:",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            covidres.lastupdate,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ))
                      ],
                    ),
                    titleWidget('Confirmed',
                        covidres.confvalue.toString() ?? '', Colors.blue),
                    titleWidget('Recovered', covidres.recvalue.toString() ?? '',
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
