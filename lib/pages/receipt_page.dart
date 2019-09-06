import 'package:flutter/material.dart';
import 'package:genesis19_publicity/model/event.dart';
import 'package:genesis19_publicity/model/reciept.dart';
import 'package:genesis19_publicity/services/db.dart';
import 'package:genesis19_publicity/widgets/display/receipt_display.dart';
import 'package:provider/provider.dart';

class ReceiptPage extends StatelessWidget {
  final Receipt receipt;

  final db = DatabaseService();

  ReceiptPage({Key key, @required this.receipt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: StreamProvider<Event>.value(
              value: db.getEvent(receipt.event) ?? Event(title: 'None'),
              child: ReceiptDisplay(receipt: receipt,)),
        ),
      ),
    );
  }
}
