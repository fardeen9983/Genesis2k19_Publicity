import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Receipt {
  final String id;
  final String event;
  final List<String> participants;
  final String date;
  final String referrer;

  Receipt({@required this.event,
    @required this.participants,
    this.date,
    this.id,
    this.referrer});

  factory Receipt.fromDocument(DocumentSnapshot doc) {
    Map data = doc.data;

    return Receipt(
        date: data['date'],
        id: doc.documentID,
        event: data['events'],
        participants: data['partcipants'],
        referrer: data['referrer']);
  }

  factory Receipt.fromMap(Map<String, dynamic> data) {
    return Receipt(
        referrer: data['referrer'],
        date: data['date'],
        id: data['id'],
        event: data['event'],
        participants: data['partcipants']);
  }

  @override
  String toString() {
    return "Receipt : $id : $date : $event : $participants : $referrer ";
  }


}
