import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'form.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _email;

  String _password;

  /// GoogleSignIn googleauth = new GoogleSignIn();
  final formkey = new GlobalKey<FormState>();

  Map<String, List<dynamic>> data = {};

  checkFields() {
    final form = formkey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  LoginUser(BuildContext context) {
    if (checkFields()) {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((user) => Navigator.pushNamed(context, '/home'))
          .catchError((e) {
        print(e);
      });
    }
  }

  Widget radioButton(bool isSelected) =>
      Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
          width: double.infinity,
          height: double.infinity,
          decoration:
          BoxDecoration(shape: BoxShape.circle, color: Colors.black),
        )
            : Container(),
      );

  Widget horizontalLine() =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<FirebaseUser>(context);
    ScreenUtil.instance = ScreenUtil.getInstance()
      ..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    Future.delayed(Duration.zero, () async {
      Firestore.instance.collection('event_cat').snapshots().listen((query) {
        query.documents.forEach((doc) {
          data[doc.documentID] = [];
          data[doc.documentID].addAll((doc.data['events']) as List);
        });
        File jsonFile;
        Directory dir;
        String fileName = "EventCat.json";
        getApplicationDocumentsDirectory().then((Directory directory) {
          dir = directory;
          jsonFile = new File(dir.path + "/" + fileName);
          jsonFile.createSync();
          jsonFile.writeAsStringSync(json.encode(data));
        });
      });
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Container(
                    height: 280, child: Image.asset("assets/dvm.jpg")),
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/dvmcity.gif"),
                        fit: BoxFit.fitWidth)),
              )
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 35.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(275),
                  ),
                  Form(
                      key: formkey,
                      child: FormCard(
                        validation: 'required',
                        saveemail: (value) => _email = value,
                        savepwd: (value) => _password = value,
                      )),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () => LoginUser(context),
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(330),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF17ead9),
                                Color(0xFF6078ea)
                              ]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => LoginUser(context),
                              child: Center(
                                child: Text("SIGNIN",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
