import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis19_publicity/model/event.dart';
import 'package:genesis19_publicity/services/db.dart';
import 'package:genesis19_publicity/widgets/register_form.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String DD1 = 'civil',
      DD2 = '1';
  Map<String, dynamic> data = {};
  bool loaded = false;
  final db = DatabaseService();
  Widget placeholder = Container();

  @override
  void initState() {
    readData();
  }

  @override
  Widget build(BuildContext context) {
    if (loaded) {
      DD1 = data.keys.toList()[0];
      print(DD1);
      return Scaffold(
          appBar: AppBar(
            title: Text(
              "New Registeration",
              style: TextStyle(color: Colors.black),
            ),
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      DropdownButton<String>(
                          value: DD1,
                          items: data.keys.toList()
                              .map<DropdownMenuItem<String>>(
                                  (String val) =>
                                  DropdownMenuItem<String>(
                                    child: Text(
                                      val,
                                      textAlign: TextAlign.center,
                                    ),
                                    value: val,
                                  ))
                              .toList(),
                          onChanged: (val) =>
                              this.setState(() => this.DD1 = val)),
                      EventDD(data),
                      RaisedButton(
                        onPressed: selectEvent,
                        child: Text(
                          "Done",
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  placeholder
                ],
              ),
            ),
          ));
    } else
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
  }

  Widget EventDD(Map<String, dynamic> map) {
    DD2 = map[DD1][0]['name'];
    return DropdownButton<String>(
        value: DD2,
        items: map[DD1]
            .map<DropdownMenuItem<String>>((val) =>
            DropdownMenuItem<String>(
              child: Text(
                val['name'],
                textAlign: TextAlign.center,
              ),
              value: val['name'],
            ))
            .toList(),
        onChanged: (val) => this.setState(() => this.DD2 = val));
  }

  void selectEvent() {
    setState(() {
      if (data != null) {
        String code;
        data[DD1].forEach((val) {
          if (val['name'] == DD2) {
            code = val['code'];
          }
        });
        placeholder = StreamProvider<Event>.value(
            value: db.getEvent(code), child: RegisterForm());
      }
    });
  }

  readData() {
    getApplicationDocumentsDirectory().then((Directory directory) {
      var dir = directory;
      var jsonFile = new File(dir.path + "/EventCat.json");
      this.setState(() {
        data = json.decode(jsonFile.readAsStringSync()) as Map<String, dynamic>;
        loaded = true;
      });
    });
  }
}
