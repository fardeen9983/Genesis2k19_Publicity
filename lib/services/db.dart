import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:genesis19_publicity/model/event.dart';
import 'package:genesis19_publicity/model/reciept.dart';

class DatabaseService {
  final Firestore _db = Firestore.instance;

  Stream<List<Receipt>> getReceipts(String user) => _db
      .collection('receipt')
      .where('referrer', isEqualTo: user)
      .snapshots()
      .map((list) =>
          list.documents.map((doc) => Receipt.fromDocument(doc)).toList());

  Stream<Event> getEvent(String code) {
    return _db
        .collection('events')
        .document(code)
        .snapshots()
        .map((doc) => Event.fromDocument(doc));
  }

  Future<Map<String, dynamic>> getEventCat() async {
    var ref = await _db.collection('event_cat').getDocuments();
    Map<String, dynamic> map = {};
    ref.documents.forEach((doc) {
      map[doc.documentID] = [];
      (doc.data['events'] as List<dynamic>)
          .forEach((val) => map[doc.documentID].add(val));
    });
    return map;
  }
}
