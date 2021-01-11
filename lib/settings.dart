import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:zariya/widgets/widgets.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
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
          // actions: <Widget>[
          //   SizedBox(
          //       width: 60,
          //       height: 30,
          //       child: FlatButton(
          //           padding: EdgeInsets.all(0),
          //           onPressed: () {},
          //           child: Icon(Icons.home, color: Colors.black)))
          // ],
        ),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Text(
                'Settings',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Text(
                'OTHER PROFILES',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Text(
                'DELETE MY ACCOUNT',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: Text(
                'VIEW ZARIYA WEBSITE',
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Container(
            //         margin: EdgeInsets.symmetric(horizontal: 20),
            //         height: 30,
            //         width: 30,
            //         child: Image.asset('assets/images/instagram.jpg',
            //             fit: BoxFit.cover),
            //       ),
            //       (data['insta'] != null)
            //           ? Text(
            //         data['insta'] ?? instaId,
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 15,
            //             color: Colors.black87),
            //         textAlign: TextAlign.left,
            //       )
            //           : Container(
            //         width: MediaQuery.of(context).size.width - 130,
            //         child: TextField(
            //           controller: instaController,
            //           style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 15,
            //               color: Colors.black87),
            //           decoration: InputDecoration(
            //             contentPadding: EdgeInsets.all(0),
            //             hintText: 'ENTER INSTAGRAM ID',
            //             hintStyle: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 15,
            //                 color: Colors.black87),
            //             suffix: IconButton(
            //               icon: Icon(Icons.done),
            //               onPressed: () {
            //                 setState(
            //                       () {
            //                     instaId = instaController.value.text;
            //                   },
            //                 );
            //                 Firestore.instance
            //                     .collection('users')
            //                     .document(widget.email)
            //                     .updateData({'insta': instaId});
            //               },
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
            //   child: Text(
            //     'OTHER PROFILES',
            //     style: TextStyle(
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.black),
            //   ),
            // ),
            Container(
              height: MediaQuery.of(context).size.height - 400,
            ),
            Center(child: zariyaTeam()),
          ],
        ),
      ),
    );
  }
}
