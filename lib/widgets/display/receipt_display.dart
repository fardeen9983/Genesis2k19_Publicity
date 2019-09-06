import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:genesis19_publicity/model/event.dart';
import 'package:genesis19_publicity/model/participant.dart';
import 'package:genesis19_publicity/model/reciept.dart';
import 'package:genesis19_publicity/widgets/display/participant_display.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ReceiptDisplay extends StatelessWidget {
  final Receipt receipt;
  Event globalEvent;

  ReceiptDisplay({Key key, @required this.receipt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Event event = globalEvent = Provider.of<Event>(context);
    try {
      // ignore: unused_local_variable
      var credit = event.credit;
    } catch (e) {
      return Center(
        child: Text("No such event exists"),
      );
    }
    int i = 1;
    return event != null
        ? Container(
            width: MediaQuery.of(context).size.width * .95,
            padding: EdgeInsets.all(10.0),
            child: Card(
              margin: EdgeInsets.symmetric(vertical: 20.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 25.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              event.title,
                              style: TextStyle(fontSize: 28.0),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Price: ${event.price}",
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Text(
                            "Credits: ${event.credit}",
                            style: TextStyle(fontSize: 20.0),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Center(
                              child: Text(
                            "Date : ${receipt.date}",
                            style: TextStyle(fontSize: 18.0),
                          )),
                          Container(
                            child: Text("Reciept no : ${receipt.id}",
                                style: TextStyle(fontSize: 18.0)),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: receipt.participants.map((participant) {
                            return StreamBuilder(
                              builder: (context,
                                      AsyncSnapshot<DocumentSnapshot> snap) =>
                                  snap.hasData
                                      ? ParticipantDisplay(
                                          participant:
                                              Participant.fromFirestore(
                                                  snap.data),
                                          index: i++,
                                        )
                                      : Container(),
                              stream: Firestore.instance
                                  .collection('participant')
                                  .document(participant)
                                  .snapshots(),
                            );
                          }).toList(),
                        ),
                      ),
                    ]),
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
