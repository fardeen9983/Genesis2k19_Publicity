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
        // ignore: missing_return
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/':
              return MaterialPageRoute(builder: (context) => SignInPage());
              break;
            case "/home":
              return MaterialPageRoute(builder: (context) => HomePage());
              break;
            case "/register":
              return MaterialPageRoute(builder: (context) => RegisterPage());
              break;
            case "/signin":
              return MaterialPageRoute(builder: (context) => SignInPage());
              break;
            default:
              return MaterialPageRoute(builder: (context) => SignInPage());
          }
        },
        debugShowCheckedModeBanner: false,

        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
