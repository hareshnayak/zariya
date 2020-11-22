import 'package:flutter/material.dart';
import 'package:zariya/chat.dart';
import 'package:zariya/community.dart';
import 'package:zariya/home.dart';
import 'package:zariya/navDrawer.dart';
import 'package:zariya/profile.dart';

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
                activeIcon: Icon(Icons.person, color: Colors.black)
              ),              
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.grey),
                title: Padding(padding: EdgeInsets.all(0)),
                activeIcon: Icon(Icons.home, color: Colors.black)
              ),              
              BottomNavigationBarItem(
                icon: Icon(Icons.chat, color: Colors.grey),
                title: Padding(padding: EdgeInsets.all(0)),
                activeIcon: Icon(Icons.chat, color: Colors.black)
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people, color: Colors.grey),
                title: Padding(padding: EdgeInsets.all(0)),
                activeIcon: Icon(Icons.people, color: Colors.black)
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
        body: (_selectedIndex == 0)
          ? ProfilePage(email: 'hareshnayak018@gmail.com')
          : (_selectedIndex == 1)
            ? HomePage()
            : (_selectedIndex == 2)
              ? ChatPage(email: 'hareshnayak018@gmail.com', name: 'Haresh Nayak')
              : Community()
      ),
    );
  }
}