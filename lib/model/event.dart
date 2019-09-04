import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String cat;
  final int roundCount;
  final int numParticipants;
  final String title;

  Event({this.cat, this.roundCount, this.numParticipants, this.title});

  factory Event.fromDocument(DocumentSnapshot doc) {
    Map data = doc.data;
    return Event(cat: data['cat'], numParticipants: data['no_participants']);
  }
}
