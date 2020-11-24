import 'package:flutter/material.dart';
import 'package:zariya/chat.dart';
import 'package:zariya/community.dart';
import 'package:zariya/home.dart';
import 'package:zariya/navDrawer.dart';
import 'package:zariya/profile.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zariya/main.dart';
class IndexPage extends StatefulWidget {

  IndexPage({this.currentUserId});

  final String currentUserId;

  @override
  _IndexPageState createState() => _IndexPageState(currentUserId: currentUserId);
}

class _IndexPageState extends State<IndexPage> {

  _IndexPageState({this.currentUserId});

  final String currentUserId;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool isLoading = false;

  Future<Null> handleSignOut() async {
    this.setState(() {
      isLoading = true;
    });

    await FirebaseAuth.instance.signOut();
    await googleSignIn.disconnect();
    await googleSignIn.signOut();

    this.setState(() {
      isLoading = false;
    });

    Navigator.of(context)
        .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyApp()), (Route<dynamic> route) => false);
  }

  int _selectedIndex = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        drawerScrimColor: Colors.black54,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: new IconThemeData(color: Colors.black),
            title: Center(
              child: Text(
                'zariya',
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
          height: 50,
          decoration: BoxDecoration(color: Color(0xFF6F90FA)),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                activeIcon: Container(child: Image.asset('assets/images/profileicona.png'), height: 30, width: 30,),
                icon: Container(child: Image.asset('assets/images/profileicon.png'), height: 30, width: 30,),
                title: Padding(padding: EdgeInsets.all(0)),
              ),
              BottomNavigationBarItem(
                activeIcon: Container(child: Image.asset('assets/images/homeicona.png'), height: 30, width: 30,),
                icon: Container(child: Image.asset('assets/images/homeicon.png'), height: 30, width: 30,),
                title: Padding(padding: EdgeInsets.all(0)),
              ),
              BottomNavigationBarItem(
                activeIcon: Container(child: Image.asset('assets/images/chaticona.png'), height: 30, width: 30,),
                icon: Container(child: Image.asset('assets/images/chaticon.png'), height: 30, width: 30,),
                title: Padding(padding: EdgeInsets.all(0)),
              ),
              BottomNavigationBarItem(
                activeIcon: Container(child: Image.asset('assets/images/commicona.png'), height: 30, width: 30,),
                icon: Container(child: Image.asset('assets/images/commicon.png'), height: 30, width: 30,),
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
            ? ProfilePage(email: 'hareshnayak018@gmail.com')
            : (_selectedIndex == 1)
            ? HomePage()
            : (_selectedIndex == 2)
            ? ChatPage(
            email: 'hareshnayak018@gmail.com',
            name: 'Haresh Nayak')
            : Community());
  }
}

