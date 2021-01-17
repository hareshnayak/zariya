import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zariya/settings.dart';

class NavDrawer extends StatelessWidget {
  NavDrawer({@required this.signOut, this.openProfile, this.currentUser});

  final VoidCallback signOut, openProfile;
  final FirebaseUser currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 250,
              padding: EdgeInsets.all(0),
              margin: EdgeInsets.all(0),
              child: DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://firebasestorage.googleapis.com/v0/b/kalakar-c7f21.appspot.com/o/misc%2F1.png?alt=media&token=589cc643-f339-4ba7-9004-865dee6db0e3'),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      'kalakaar apps',
                      style: TextStyle(color: Colors.black, fontSize: 25),
                    ),
                  ],
                ),
              ),
            ),
//             ListTile(
//               leading: Icon(Icons.book, color: Colors.deepPurple),
//               title: Text('Courses'),
//               onTap: () => {
//                  Navigator.push(context, MaterialPageRoute(builder: (context) => Academies(email: currentUser.email)),)
//               },
//             ),
//             Container(
//               color: Colors.grey.shade300,
//               child: ListTile(
//                 leading: Icon(Icons.chat, color: Colors.deepPurple),
//                 title: Text('Chat'),
//                 onTap: () => {
//                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(title: 'Zariya')),)
//                 },
//               ),
//             ),
            ListTile(
              leading: Icon(Icons.verified_user, color: Colors.deepPurple),
              title: Text('Profile'),
              onTap: () {
                openProfile();
                Navigator.of(context).pop();
              },
            ),
            Container(
              color: Colors.grey.shade300,
              child: ListTile(
                leading: Icon(Icons.settings, color: Colors.deepPurple),
                title: Text('Settings'),
                onTap: () => {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ),
                  ),
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.border_color, color: Colors.deepPurple),
              title: Text('Feedback'),
              onTap: () {
                Navigator.of(context).pop();
                launch('https://kalakar-c7f21.web.app');
              },
            ),
            Container(
              color: Colors.grey.shade300,
              child: ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.deepPurple),
                title: Text('Logout'),
                onTap: () {
                  Navigator.of(context).pop();
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
