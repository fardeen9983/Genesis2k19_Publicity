import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:genesis19_publicity/model/event.dart';
import 'package:genesis19_publicity/services/db.dart';
import 'package:genesis19_publicity/widgets/register_form.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String DD1 = 'civil',
      DD2 = 'Doom',
      code;
  Map<String, dynamic> data = {};
  bool loadB = true,
      formLoaded = false;
  final db = DatabaseService();
  Widget placeholder = Container(),
      error = Container(),
      errWidget = Center(child: Text("No such event exists"));
  final RegisterForm _registerForm = RegisterForm();
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.check,
                  size: 32.0,
                  color: Colors.green,
                ),
                onPressed: validate),
            IconButton(
                icon: Icon(
                  Icons.clear,
                  size: 32.0,
                  color: Colors.red,
                ),
                onPressed: () => Navigator.pop(context))
          ],
          title: Text(
            "New Registeration",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection('event_cat').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
            if (snap.hasData) {
              setData(snap.data.documents);
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          branchDD(data),
                          eventDD(data),
                          RaisedButton(
                            onPressed: selectEvent,
                            child: Text(
                              "Done",
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                      placeholder,
                      error
                    ],
                  ),
                ),
              );
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          },
        ));
  }

  Widget branchDD(data) {
    return DropdownButton<String>(
        value: DD1,
        items: data.keys
            .toList()
            .map<DropdownMenuItem<String>>(
                (String val) =>
                DropdownMenuItem<String>(
                  child: Text(
                    val,
                    textAlign: TextAlign.center,
                  ),
                  value: val,
                ))
            .toList(),
        onChanged: (val) =>
            this.setState(() {
              this.DD1 = val;
              this.loadB = true;
            }));
  }

  Widget eventDD(Map<String, dynamic> map) {
    return DropdownButton<String>(
        value: DD2,
        items: map[DD1]
            .map<DropdownMenuItem<String>>((val) =>
            DropdownMenuItem<String>(
              child: Text(
                val['name'],
                textAlign: TextAlign.center,
              ),
              value: val['name'],
            ))
            .toList(),
        onChanged: (val) => this.setState(() => this.DD2 = val));
  }

  void selectEvent() {
    setState(() {
      formLoaded = true;
      if (data != null) {
        String code;
        data[DD1].forEach((val) {
          if (val['name'] == DD2) {
            code = val['code'];
          }
        });
        this.code = code;
        placeholder = StreamProvider<Event>.value(
          // ignore: missing_return
            catchError: (context, error) {
              error = errWidget;
            },
            value: db.getEvent(code) ?? Event(title: 'None'),
            child: Form(child: _registerForm));
      }
    });
  }

  void setData(List<DocumentSnapshot> docs) {
    docs.forEach((doc) {
      data[doc.documentID] = [];
      (doc.data['events'] as List<dynamic>)
          .forEach((val) => data[doc.documentID].add(val));
    });

    if (loadB) {
      DD2 = data[DD1][0]['name'];
      loadB = false;
    }
  }

  void validate() {
    if (error != errWidget && formLoaded) {
      Map val = _registerForm.validate();
      if (val != null && val['list'].isNotEmpty) {
        showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text('Createing Receipt'),
                  content: Text("Are you Sure? Please check all the fields!!"),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("Cancel")),
                    FlatButton(
                        onPressed: () {
                          save(val);
                          Navigator.pop(context);
                        },
                        child: Text("OK"))
                  ],
                ));
      }
    }
  }

  void save(val) async {
    await db.addReceipt(val['code'], val['list'], val['receipt'], Provider
        .of<FirebaseUser>(_key.currentContext)
        .email);
  }
}
