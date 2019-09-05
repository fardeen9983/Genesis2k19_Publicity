import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String cat;
  final int roundCount;
  final int numParticipants;
  final String title;
  final int price;
  final int credit;

  Event({this.cat,
    this.credit,
    this.roundCount,
    this.numParticipants,
    this.title,
    this.price});

  factory Event.fromDocument(DocumentSnapshot doc) {
    Map data = doc.data;
    return Event(
        credit: data['credit'],
        price: data['price'],
        cat: data['cat'],
        numParticipants: data['no_participants'],
        title: data['title']);
  }
}
