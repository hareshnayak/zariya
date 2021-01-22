import 'package:flutter/material.dart';
import 'package:zariya/services/authentication.dart';

class RootPage extends StatefulWidget {
  RootPage({@required this.auth});

  final BaseAuth auth;

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
