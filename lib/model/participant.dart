import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Participant {
  final String name;
  final int mobile;
  final String branch;
  final int year;
  final Map<String, dynamic> events;
  final String email;

  Participant({
    @required this.name,
    this.mobile,
    @required this.branch,
    this.year,
    @required this.events,
    @required this.email,
  });

  factory Participant.fromMap(Map<String, dynamic> data) {
    data = data ?? {};
    return Participant(
        name: data['name'],
        mobile: data['mobile'],
        branch: data['branch'],
        year: data['year'],
        events: data['events'],
        email: data['email']);
  }

  factory Participant.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data;
    return Participant(
        name: data['name'],
        mobile: data['mobile'],
        branch: data['branch'],
        year: data['year'],
        events: data['events'],
        email: doc.documentID);
  }
}
