import 'package:flutter/material.dart';
import 'package:genesis19_publicity/model/reciept.dart';
import 'package:genesis19_publicity/pages/receipt_page.dart';

class ReceiptList extends StatelessWidget {
  final List<Receipt> receipts;

  const ReceiptList({Key key, @required this.receipts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(10.0),
      itemBuilder: (context, index) {
        Receipt receipt = receipts[index];
        return GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ReceiptPage(receipt: receipt))),
          child: ListTile(
            leading: Text(receipt.id),
            title: Text(receipt.event),
            subtitle: Text(receipt.date),
          ),
        );
      },
      itemCount: receipts.length,
    );
  }
}
