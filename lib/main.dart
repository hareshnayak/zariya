import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zariya/services/authentication.dart';
import 'package:zariya/services/root.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        '/root': (context) => RootPage(auth: new Auth()),
      },
      debugShowCheckedModeBanner: false,
      home: RootPage(auth: new Auth()),
    );
  }
}
