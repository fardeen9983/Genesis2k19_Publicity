import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParticipantForm extends StatefulWidget {
  final int index;

  ParticipantForm({Key key, @required this.index}) : super(key: key);

  @override
  _ParticipantFormState createState() => _ParticipantFormState();
}

class _ParticipantFormState extends State<ParticipantForm> {
  String DD1 = 'CE',
      DD2 = '1';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Card(
        elevation: 3.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.30)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 18.0),
          child: Column(
            children: <Widget>[
              Text(
                "Participant ${widget.index}",
                style: TextStyle(fontSize: 20.0),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 18.0, vertical: 2.0),
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(helperText: 'Name'),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(helperText: 'Email'),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(helperText: 'Mobile no'),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          branchDD(), yearDD()
                        ],
                      )
                    ],
                  ))
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }

  branchDD() =>
      DropdownButton<String>(
          value: DD1,
          items: <String>['CE', 'CP', 'IT', 'EC', 'EL', 'ME', 'PE', 'EE']
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

  yearDD() =>
      DropdownButton<String>(
          value: DD2,
          items: <String>['1', '2', '3', '4']
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
          onChanged: (val) => this.setState(() => this.DD2 = val));
}
