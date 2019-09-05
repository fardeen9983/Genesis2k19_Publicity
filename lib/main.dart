import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:genesis19_publicity/pages/home_page.dart';
import 'package:genesis19_publicity/pages/register_page.dart';
import 'package:genesis19_publicity/pages/signin/SignInPage.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
          value: FirebaseAuth.instance.onAuthStateChanged,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SignInPage(),
          '/home': (context) => HomePage(),
          '/register': (context) => RegisterPage()
        },
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
