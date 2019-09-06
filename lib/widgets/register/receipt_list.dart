import 'package:flutter/material.dart';
import 'package:genesis19_publicity/model/reciept.dart';
import 'package:genesis19_publicity/pages/receipt_page.dart';
import 'package:provider/provider.dart';

class ReceiptList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var receipts = Provider.of<List<Receipt>>(context);
    return receipts != null
        ? ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      itemBuilder: (context, index) {
        Receipt receipt = receipts[index];
        return GestureDetector(
          onTap: () =>
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ReceiptPage(receipt: receipt))),
          child: Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        receipt.id,
                        style: TextStyle(fontSize: 32.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Expanded(
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              receipt.event,
                              style: TextStyle(fontSize: 20.0),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Date : ${receipt.date}",
                              style: TextStyle(fontSize: 20.0),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
      itemCount: receipts.length,
    )
        : Center(
      child: Text(
        "Add an Entry First",
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}
