import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Receipt {
  final String id;
  final String event;
  final List<dynamic> participants;
  final String date;
  final String referrer;

  Receipt({@required this.event,
    @required this.participants,
    @required this.date,
    @required this.id,
    @required this.referrer});

  factory Receipt.fromDocument(DocumentSnapshot doc) {
    Map data = doc.data;
    return Receipt(
        date: data['date'],
        id: doc.documentID,
        event: data['event'],
        participants: data['participants'],
        referrer: data['referrer']);
  }

  factory Receipt.fromMap(Map<String, dynamic> data) {
    return Receipt(
        referrer: data['referrer'],
        date: data['date'],
        id: data['id'],
        event: data['event'],
        participants: data['participants']);
  }

  Map<String, dynamic> toMap() {
    return {
      'date': this.date,
      'id': this.id,
      'event': this.event,
      'participants': this.participants,
      'referrer': this.referrer
    };
  }

  @override
  String toString() {
    return "Receipt : $id : $date : $event : $participants : $referrer ";
  }
}
