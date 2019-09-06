import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis19_publicity/model/participant.dart';

class ParticipantDisplay extends StatelessWidget {
  final int index;
  final Participant participant;

  const ParticipantDisplay(
      {Key key, @required this.index, @required this.participant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Card(
        elevation: 3.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.30)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
          child: Column(
            children: <Widget>[
              Text(
                "Participant ${index}",
                style: TextStyle(fontSize: 20.0),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Column(
                    children: [
                      Container(
                        height: 1.0,
                        decoration: BoxDecoration(color: Colors.grey),
                        margin: EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 8.0),
                      ),
                      Row(children: [
                        Container(
                          child: Text(
                            "Name",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18.0),
                          ),
                          width: 80,
                        ),
                        Expanded(
                            child: Text(participant.name,
                                style: TextStyle(fontSize: 18.0)))
                      ]),
                      Container(
                        height: 1.0,
                        decoration: BoxDecoration(color: Colors.grey),
                        margin: EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 8.0),
                      ),
                      Row(children: [
                        Container(
                          child: Text("Email",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18.0)),
                          width: 80,
                        ),
                        Expanded(
                            child: Text(participant.email,
                                style: TextStyle(fontSize: 18.0)))
                      ]),
                      Container(
                        height: 1.0,
                        decoration: BoxDecoration(color: Colors.grey),
                        margin: EdgeInsets.symmetric(
                            horizontal: 18.0, vertical: 8.0),
                      ),
                      Row(children: [
                        Container(
                          child: Text("Phone",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18.0)),
                          width: 80,
                        ),
                        Expanded(
                            child: Text(participant.mobile,
                                style: TextStyle(fontSize: 18.0)))
                      ]),
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
