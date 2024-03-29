import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:sos/components/appBar.dart';

class Instruction extends StatefulWidget {
  static const String id = 'instruction';
  @override
  _InstructionState createState() => _InstructionState();
}

class _InstructionState extends State<Instruction> {
  String data = '';
  fetchFileData() async {
    String responseText;
    responseText = await rootBundle.loadString('textFiles/instruction.txt');
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
        appBar: appBar(),
        body: Container(
          padding: EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  " To use this application with ease follow the below steps :",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                ),
                Divider(),
                Text(data,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500))
              ],
            ),
          ),
        ));
  }
}
