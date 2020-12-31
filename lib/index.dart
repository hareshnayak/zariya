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

  IndexPage({this.currentUser, this.followId});

  final FirebaseUser currentUser;
  final String followId;

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  bool isLoading = false;
  int _selectedIndex = 0;

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

  void openProfile(){
    setState((){
      _selectedIndex = 1;
    });
  }

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(signOut: handleSignOut, openProfile: openProfile,),
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
                activeIcon: Container(child: Image.asset('assets/images/homeicona.png'), height: 40, width: 40,),
                icon: Container(child: Image.asset('assets/images/homeicon.png'), height: 40, width: 40,),
                title: Padding(padding: EdgeInsets.all(0)),
              ),
              BottomNavigationBarItem(
                activeIcon: Container(child: Image.asset('assets/images/profileicona.png'), height: 40, width: 40,),
                icon: Container(child: Image.asset('assets/images/profileicon.png'), height: 40, width: 40,),
                title: Padding(padding: EdgeInsets.all(0)),
              ),
              BottomNavigationBarItem(
                activeIcon: Container(child: Image.asset('assets/images/commicona.png'), height: 40, width: 40,),
                icon: Container(child: Image.asset('assets/images/commicon.png'), height: 40, width: 40,),
                title: Padding(padding: EdgeInsets.all(0)),
              ),
              BottomNavigationBarItem(
                activeIcon: Container(child: Image.asset('assets/images/chaticona.png'), height: 40, width: 40,),
                icon: Container(child: Image.asset('assets/images/chaticon.png'), height: 40, width: 40,),
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
          ? ProfilePage(email: widget.currentUser.email)
          : (_selectedIndex == 2)
          ? Community(email: widget.currentUser.email, name: widget.currentUser.displayName, photoUrl: widget.currentUser.photoUrl, followId: widget.followId)
          : ChatPage(currentUser: widget.currentUser)
    );
  }
}

