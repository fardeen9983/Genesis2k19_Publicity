import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genesis19_publicity/model/reciept.dart';
import 'package:genesis19_publicity/services/db.dart';
import 'package:genesis19_publicity/widgets/ReceiptList.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  final db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    FirebaseUser user = Provider.of<FirebaseUser>(context);
    if (user == null) {
      Navigator.pushReplacementNamed(context, "/");
    }
    return Scaffold(
        appBar: AppBar(
          actionsIconTheme: IconThemeData(color: Colors.black),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.settings,
                ),
                onPressed: () =>
                    showDialog(
                        context: context,
                        builder: (context) =>
                            AlertDialog(
                              title: Text('Log Out'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("Cancel"),
                                  onPressed: () => Navigator.pop(context),
                                ),
                                FlatButton(
                                  child: Text("OK"),
                                  onPressed: () => auth.signOut(),
                                ),
                              ],
                            )))
          ],
          backgroundColor: Colors.white,
          elevation: 5.0,
          centerTitle: true,
          title: Text(
            "GENESIS 2K19",
            style: TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => Navigator.pushNamed(context, "/register")),
        body: StreamProvider<List<Receipt>>.value(
            child: ReceiptList(), value: db.getReceipts(user.email)));
  }
}
