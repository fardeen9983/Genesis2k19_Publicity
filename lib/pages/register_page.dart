import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String DD1 = 'Branch',
      DD2 = 'Event';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
                    BranchDD(),
                    EventDD(),
                    RaisedButton(
                      onPressed: () {},
                      child: Text(
                        "Done",
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  Widget BranchDD() =>
      DropdownButton<String>(
          value: DD1,
          items: ['Civil', 'CP-IT', 'EC-EL', 'ME-PE', 'EE', 'Other']
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

  Widget EventDD() =>
      DropdownButton<String>(
          value: DD1,
          items: ['1', '2', '3', '4', '5', '6']
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
}
