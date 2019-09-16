import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'form.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String _email;

  String _password;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      user = Provider.of<FirebaseUser>(context);
      if (user != null) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
  }

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

  loginUser(BuildContext context) {
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
    user = Provider.of<FirebaseUser>(context);
    ScreenUtil.instance = ScreenUtil.getInstance()
      ..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);


    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: ListView(
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
                  onTap: () => loginUser(context),
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
                        onTap: () => loginUser(context),
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
    );
  }
}
