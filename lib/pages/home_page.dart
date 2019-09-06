import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genesis19_publicity/model/reciept.dart';
import 'package:genesis19_publicity/services/db.dart';
import 'package:genesis19_publicity/widgets/register/receipt_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final auth = FirebaseAuth.instance;
  FirebaseUser user;
  final db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    user = Provider.of<FirebaseUser>(context);
//    if (user == null) {
//      Navigator.pushReplacementNamed(context, "/");
//    }

    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
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
                                    onPressed: () {
                                      auth.signOut();
                                    },
                                  ),
                                ],
                              )))
            ],
            backgroundColor: Colors.white,
            elevation: 5.0,
            centerTitle: true,
            title: Text(
              "GENESIS 2K19",
              style:
              TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => Navigator.pushNamed(context, "/register")),
          body: getReceipt(context)),
    );
  }

  getReceipt(BuildContext context) {
    try {
      var x = db.getReceipts(user.email);
      return StreamProvider<List<Receipt>>.value(
        child: ReceiptList(),
        value: x,
        catchError: (context, e) {
          print(e);
          return [];
        },
      );
    } catch (e) {
      Future.delayed(Duration(seconds: 1),
              () => Navigator.pushReplacementNamed(context, "/"));
      return Container();
    }
  }
}
