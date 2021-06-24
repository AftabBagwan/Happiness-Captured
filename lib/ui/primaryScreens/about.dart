import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class About extends StatefulWidget {
  static const String id = 'about';
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  String data = '';
  fetchFileData() async {
    String responseText;
    responseText = await rootBundle.loadString('textFiles/about.txt');
    setState(() {
      data = responseText;
    });
  }

  @override
  void initState() {
    fetchFileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Happiness Captured',
        ),
        backgroundColor: Color(0xfff12d4e),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Text(
                  data,
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
                ),
              ),
              Divider(),
              Text(
                'Copyright 2021',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
