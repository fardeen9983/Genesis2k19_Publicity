import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Participant {
  final String name;
  final String mobile;
  final String branch;
  final int year;
  final bool leader;
  Map<String, dynamic> events;
  final String email;

  Participant({
    @required this.leader,
    @required this.name,
    this.mobile,
    this.branch,
    this.year,
    this.events,
    @required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'mobile': this.mobile,
      'branch': this.branch,
      'year': this.year,
      'events': this.events
    };
  }

  factory Participant.fromMap(Map<String, dynamic> data) {
    data = data ?? {};
    return Participant(
        leader: data['leader'] ?? false,
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
        leader: data['leader'] ?? false,
        name: data['name'],
        mobile: data['mobile'],
        branch: data['branch'],
        year: data['year'],
        events: Map<String, dynamic>.from(data['events']),
        email: doc.documentID);
  }

  @override
  String toString() {
    return "Participannt : $name , mobile : $mobile, branch : $branch, year : $year, email : $email, events : $events";
  }
}
