import 'package:flutter/material.dart';
import 'package:zariya/chat.dart';
import 'package:zariya/community.dart';
import 'package:zariya/home.dart';
import 'package:zariya/navDrawer.dart';
import 'package:zariya/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class IndexPage extends StatefulWidget {
  IndexPage({this.currentUser, this.followId, @required this.handleSignOut});

  final FirebaseUser currentUser;
  final String followId;
  final VoidCallback handleSignOut;

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  static GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  // final GoogleSignIn googleSignIn = GoogleSignIn();

  bool isLoading = false;
  int _selectedIndex = 0;

  void openProfile() {
    setState(() {
      _selectedIndex = 1;
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
          signOut: widget.handleSignOut,
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
                SizedBox(width: MediaQuery.of(context).size.width - 280),
                Text(
                  'zariya',
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
                  child: Image.asset('assets/images/homeicona.png'),
                  height: 40,
                  width: 40,
                ),
                icon: Container(
                  child: Image.asset('assets/images/homeicon.png'),
                  height: 40,
                  width: 40,
                ),
                title: Padding(padding: EdgeInsets.all(0)),
              ),
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
            ? HomePage(email: widget.currentUser.email)
            : (_selectedIndex == 1)
                ? ProfilePage(
                    email: widget.currentUser.email,
                    type: 'users',
                  )
                : (_selectedIndex == 2)
                    ? Community(
                        email: widget.currentUser.email,
                        name: widget.currentUser.displayName,
                        photoUrl: widget.currentUser.photoUrl,
                        followId: widget.followId)
                    : ChatPage(currentUser: widget.currentUser));
  }
}
