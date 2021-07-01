import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpLine extends StatefulWidget {
  static const String id = 'helpline';
  @override
  _HelpLineState createState() => _HelpLineState();
}

class _HelpLineState extends State<HelpLine> {
  var url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Emergency Numbers',
        ),
        backgroundColor: Color(0xfff12d4e),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Helpline')
                .orderBy("state")
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue)),
                );

              return Expanded(
                  child: ListView(
                children: snapshot.data.docs.map((document) {
                  return Column(
                    children: <Widget>[
                      ListTile(
                        onTap: () async {
                          //// this is not working please add look this to launch phonecall after pressing on number
                          await launchCaller(
                              url = document['number'].toString());
                        },
                        title: Row(
                          children: <Widget>[
                            Text(
                              document['state'].toString(),
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.call,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    document['number'].toString(),
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Divider()
                    ],
                  );
                }).toList(),
              ));
            },
          )
        ],
      ),
    );
  }

  launchCaller(String number) async {
    var url = "tel:" + number;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
