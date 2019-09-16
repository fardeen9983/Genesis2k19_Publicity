import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  final String code;
  final int numParticipants;
  final String title;
  final int price;
  final int credit;

  Event({this.code, this.credit, this.numParticipants, this.title, this.price});

  factory Event.fromDocument(DocumentSnapshot doc) {
    Map data = doc.data;
    return Event(
        code: doc.documentID,
        credit: data['credit'],
        price: data['price'],
        numParticipants: data['no_participants'],
        title: data['title']);
  }
}
