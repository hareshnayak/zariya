import 'package:flutter/material.dart';
import 'package:zariya/login.dart';
import 'package:zariya/academies.dart';
import 'package:zariya/resources/strings.dart' as Strings;
import 'package:firebase_auth/firebase_auth.dart';

class NavDrawer extends StatelessWidget {

  NavDrawer({@required this.signOut, this.currentUser});

  final signOut;
  final FirebaseUser currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(Strings.defaultImageIcon))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Kalakaar',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.book, color: Colors.deepPurple),
              title: Text('Courses'),
              onTap: () => {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Academies(email: currentUser.email)),)
              },
            ),
            Container(
              color: Colors.grey.shade300,
              child: ListTile(
                leading: Icon(Icons.chat, color: Colors.deepPurple),
                title: Text('Chat'),
                onTap: () => {
                 Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(title: 'Zariya')),)
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.verified_user, color: Colors.deepPurple),
              title: Text('Profile'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            Container(
              color: Colors.grey.shade300,
              child: ListTile(
                leading: Icon(Icons.settings, color: Colors.deepPurple),
                title: Text('Settings'),
                onTap: () => {Navigator.of(context).pop()},
              ),
            ),
            ListTile(
              leading: Icon(Icons.border_color, color: Colors.deepPurple),
              title: Text('Feedback'),
              onTap: () => {Navigator.of(context).pop()},
            ),
            Container(
              color: Colors.grey.shade300,
              child: ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.deepPurple),
                title: Text('Logout'),
                onTap: () {
                  signOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
