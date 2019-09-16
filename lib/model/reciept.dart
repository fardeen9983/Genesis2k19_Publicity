import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Receipt {
  final String id;
  final String event;
  final List<dynamic> participants;
  final String date;
  final String referrer;
  final String leader;

  Receipt({@required this.event,
    @required this.leader,
    @required this.participants,
    @required this.date,
    @required this.id,
    @required this.referrer});

  factory Receipt.fromDocument(DocumentSnapshot doc) {
    Map data = doc.data;
    return Receipt(
        leader: data['leader'] ?? "",
        date: data['date'],
        id: doc.documentID,
        event: data['event'],
        participants: data['participants'],
        referrer: data['referrer']);
  }

  factory Receipt.fromMap(Map<String, dynamic> data) {
    return Receipt(
        leader: data['leader'] ?? "",
        referrer: data['referrer'],
        date: data['date'],
        id: data['id'],
        event: data['event'],
        participants: data['participants']);
  }

  Map<String, dynamic> toMap() {
    return {
      'leader': this.leader ?? null,
      'date': this.date,
      'id': this.id,
      'event': this.event,
      'participants': this.participants,
      'referrer': this.referrer
    };
  }

  @override
  String toString() {
    return "Receipt : $id : $date : $event : $participants : $referrer : $leader";
  }
}
