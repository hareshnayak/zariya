import 'package:flutter/material.dart';
import 'package:zariya/chat.dart';
import 'package:zariya/community.dart';
import 'package:zariya/navDrawer.dart';
import 'package:zariya/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TeacherIndexPage extends StatefulWidget {
  TeacherIndexPage({this.currentUser, this.signOut});

  final FirebaseUser currentUser;
  final VoidCallback signOut;

  @override
  _TeacherIndexPageState createState() => _TeacherIndexPageState();
}

class _TeacherIndexPageState extends State<TeacherIndexPage> {
  static GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  bool isLoading = false;
  int _selectedIndex = 1;

  void openProfile() {
    setState(() {
      _selectedIndex = 0;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        drawer: NavDrawer(
          signOut: widget.signOut,
          openProfile: openProfile,
        ),
        drawerScrimColor: Colors.black54,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(
            leading: IconButton(
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
              icon:
                  Image.asset('assets/images/navl.png', fit: BoxFit.fitHeight),
              iconSize: 10,
            ),
            backgroundColor: Colors.white,
            iconTheme: new IconThemeData(color: Colors.black),
            title: Row(
              children: [
                SizedBox(width: 20),
                Text(
                  'Zariya Instructor',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.black),
                ),
              ],
            ),
            elevation: 0,
//            actions: <Widget>[
//              SizedBox(
//                  width: 60,
//                  height: 30,
//                  child: FlatButton(
//                      padding: EdgeInsets.all(0),
//                      onPressed: () {},
//                      child: Icon(Icons.search, color: Colors.black)))
//            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 60,
          decoration: BoxDecoration(color: Color(0xFF6F90FA)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                activeIcon: Container(
                  child: Image.asset('assets/images/profileicona.png'),
                  height: 40,
                  width: 40,
                ),
                icon: Container(
                  child: Image.asset('assets/images/profileicon.png'),
                  height: 40,
                  width: 40,
                ),
                title: Padding(padding: EdgeInsets.all(0)),
              ),
              BottomNavigationBarItem(
                activeIcon: Container(
                  child: Image.asset('assets/images/commicona.png'),
                  height: 40,
                  width: 40,
                ),
                icon: Container(
                  child: Image.asset('assets/images/commicon.png'),
                  height: 40,
                  width: 40,
                ),
                title: Padding(padding: EdgeInsets.all(0)),
              ),
              BottomNavigationBarItem(
                activeIcon: Container(
                  child: Image.asset('assets/images/chaticona.png'),
                  height: 40,
                  width: 40,
                ),
                icon: Container(
                  child: Image.asset('assets/images/chaticon.png'),
                  height: 40,
                  width: 40,
                ),
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
        body: (_selectedIndex == 0)
            ? ProfilePage(
                email: widget.currentUser.email,
                type: 'teachers',
              )
            : (_selectedIndex == 1)
                ? Community(
                    email: widget.currentUser.email,
                    name: widget.currentUser.displayName,
                    photoUrl: widget.currentUser.photoUrl,
                  )
                : ChatPage(currentUser: widget.currentUser));
  }
}
