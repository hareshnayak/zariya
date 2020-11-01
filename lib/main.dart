import 'package:flutter/material.dart';
import 'package:zariya/chat.dart';
import 'package:zariya/home.dart';
import 'package:zariya/navDrawer.dart';
import 'package:zariya/profile.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _selectedIndex = 1;
  bool isLoaded = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    Firebase.initializeApp().whenComplete(() => setState((){
//      isLoaded = true;
//    }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
//        primarySwatch: Colors.white,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: (!isLoaded)
        ? Scaffold(body:Center(child:CircularProgressIndicator()))
        : Scaffold(
        drawer: NavDrawer(),
        drawerScrimColor: Colors.black54,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: new IconThemeData(color: Colors.black),
//            leading: SizedBox(
//                width: 60,
//                height: 30,
//                child: FlatButton(
//                    padding: EdgeInsets.all(0),
//                    onPressed: () {
//                      Scaffold.of(context).openDrawer();
//                    },
//                    child: Icon(Icons.menu, color: Colors.black))),
//             SizedBox(
//                   width: 60,
//                 height: 30,
//                   child: FlatButton(
//                 padding: EdgeInsets.all(0),
//                       onPressed: () {},: Colors.black))),
            title: Center(
              child: Text(
                'zariyā',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black),
              ),
            ),
            elevation: 0,
            actions: <Widget>[
              SizedBox(
                  width: 60,
                  height: 30,
                  child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {},
                      child: Icon(Icons.search, color: Colors.black)))
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 40,
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.grey),
                title: Padding(padding: EdgeInsets.all(0)),
              ),              
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.grey),
                title: Padding(padding: EdgeInsets.all(0)),
              ),              
              BottomNavigationBarItem(
                icon: Icon(Icons.chat, color: Colors.grey),
                title: Padding(padding: EdgeInsets.all(0)),
              ),
            ],
         currentIndex: _selectedIndex,
         selectedItemColor: Colors.amber[800],
         onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
         },
          ),
        ),
//        floatingActionButton: FloatingActionButton(
//            onPressed: () {
//              Navigator.push(
//                  context,
//                  MaterialPageRoute(builder:
//                      (BuildContext context) => Community()));
//            },
//            child: Icon(Icons.people),
//            backgroundColor: Colors.green),
        body: (_selectedIndex == 0)
          ? ProfilePage()
          : (_selectedIndex == 1)
            ? HomePage()
            : ChatPage()
      ),
    );
  }
}