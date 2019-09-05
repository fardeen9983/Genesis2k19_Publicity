import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis19_publicity/model/event.dart';
import 'package:genesis19_publicity/services/db.dart';
import 'package:genesis19_publicity/widgets/register_form.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String DD1 = 'Civil',
      DD2 = '1';
  Map<String, dynamic> data;

  final db = DatabaseService();
  Widget placeholder = Container();

  @override
  Widget build(BuildContext context) {
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
        body: FutureBuilder(
          future: db.getEventCat(),
          builder:
              (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snap) {
            if (snap.hasData) {
              data = snap.data;
              List DD1Itmes = data.keys.toList();
              DD1 = DD1Itmes[0];
              DD2 = data[DD1][0]['name'];
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          BranchDD(DD1Itmes),
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
              );
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          },
        ));
  }

  Widget BranchDD(List<String> items) =>
      DropdownButton<String>(
          value: DD1,
          items: items
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
          onChanged: (val) => this.setState(() => this.DD1 = val));

  Widget EventDD(Map<String, dynamic> map) =>
      DropdownButton<String>(
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
}
