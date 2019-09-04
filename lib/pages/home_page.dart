import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genesis19_publicity/model/reciept.dart';
import 'package:genesis19_publicity/widgets/ReceiptList.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    if (user == null) {
      Navigator.pushReplacementNamed(context, "/");
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 5.0,
          centerTitle: true,
          title: Text(
            "GENESIS 2K19",
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, "/register")),
        body: StreamBuilder<QuerySnapshot>(
          builder: (context, snap) {
            if (snap.hasData) {
              List<Receipt> receipts = snap.data.documents
                  .map((doc) => Receipt.fromDocument(doc))
                  .toList();
              print(receipts[0]);
              return ReceiptList(receipts: receipts);
            } else
              return Center(
                child: Text(
                  "Add a record",
                  style: TextStyle(fontSize: 24.0),
                ),
              );
          },
          stream: db
              .collection('receipt')
              .where('referrer', isEqualTo: user.email)
              .snapshots(),
        ));
  }
}
