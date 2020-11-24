import 'package:flutter/material.dart';
import 'package:zariya/login.dart';
import 'package:zariya/academies.dart';

class NavDrawer extends StatelessWidget {
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
                      image: NetworkImage(
                          'https://images.com/image.jpg'))),
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
                 Navigator.push(context, MaterialPageRoute(builder: (context) => Academies()),)
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
                onTap: () => {Navigator.of(context).pop()},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
