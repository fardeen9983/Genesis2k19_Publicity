import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParticipantForm extends StatelessWidget {
  final int index;

  const ParticipantForm({Key key, @required this.index}) : super(key: key);

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
                "Participant $index",
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
                    ],
                  ))
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
        ),
      ),
    );
  }
}
