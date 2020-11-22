import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zariya/index.dart';
import 'package:zariya/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    Firebase.initializeApp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Para Font',
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/root' : (context) => IndexPage(),
      },
      debugShowCheckedModeBanner: false,
      home: IndexPage(),
    );
  }
}
