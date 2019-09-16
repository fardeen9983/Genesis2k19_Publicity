import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:genesis19_publicity/model/event.dart';
import 'package:genesis19_publicity/model/participant.dart';
import 'package:genesis19_publicity/model/reciept.dart';
import 'package:intl/intl.dart';

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

  Future<bool> addReceipt(String code, List<Participant> particpants,
      String rid, String email) async {
    var eval,
        error = false;
    Receipt receipt = Receipt(
        leader: particpants[0].email,
        event: code,
        participants: particpants.map((doc) => doc.email).toList(),
        date: DateFormat('d/M/yy').format(DateTime.now()),
        id: rid,
        referrer: email);
    await _db
        .collection('receipt')
        .document(rid)
        .setData(receipt.toMap())
        .catchError((e) {
      error = true;
      eval = e;
    });
    if (error) return error;
    var doc = await _db.collection("events").document(code).get();
    if (!(doc.data['receipts'] as List).contains(rid))
      doc.data['receipts'] = List.from(doc.data['receipts'])
        ..add(rid);
    await _db
        .collection('events')
        .document(code)
        .updateData(doc.data)
        .catchError((e) {
      error = true;
      eval = e;
    });
    if (error) return error;
    for (Participant i in particpants) {
      var doc = await _db.collection("participant").document(i.email).get();
      if (!doc.exists) {
        await _db
            .collection("participant")
            .document(i.email)
            .setData(i.toMap(), merge: true)
            .catchError((e) {
          error = true;
          eval = e;
        });
      } else {
        doc.data['events'][receipt.id] = i.events[receipt.id];
//        doc.data['mobile'] = i.mobile;
        await _db
            .collection("participant")
            .document(i.email)
            .updateData(doc.data)
            .catchError((e) {
          error = true;
          eval = e;
        });
      }
    }
    return Future.value(error);
  }
}
