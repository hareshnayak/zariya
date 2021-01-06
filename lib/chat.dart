import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zariya/chatbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zariya/resources/strings.dart';
import 'package:zariya/resources/colors.dart';

class ChatPage extends StatefulWidget {
  ChatPage({this.currentUser});

  final FirebaseUser currentUser;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
//       margin: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Text(
                'MESSENGER',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.left,
              )),
//           Container(height: 1, color: grey1),
          Stack(children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: grey300,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search', border: InputBorder.none))),
            Positioned(
              right: 10,
              top: -5,
              child: Container(
                margin: EdgeInsets.all(10),
//             padding: EdgeInsets.symmetric(horizontal:10),
                width: 50,
                height: 50,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  child: Icon(Icons.search, color: Colors.black),
                ),
              ),
            ),
          ]),
          Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: Text('Chats',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('academies').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              else if (snapshot.data.documents == null ||
                  snapshot.data.documents.length == 0)
                return Center(child: Text('Nothing here!!!'));
              return chatItemsList(context, snapshot.data.documents);
            },
          ),
        ],
      ),
    );
  }

  Widget chatItemsList(BuildContext context, List<DocumentSnapshot> doc) {
    return Expanded(
      child: ListView.builder(
          itemCount: doc.length,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (BuildContext context, int i) {
            return chatItem(context, doc[i].data);
          }),
    );
  }

  Widget chatItem(BuildContext context, dynamic data) {
    return Container(
        height: 70,
        padding: EdgeInsets.all(10),
        child: FlatButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatBox(
                          email: widget.currentUser.email,
                          myName: widget.currentUser.displayName,
                          myImage: widget.currentUser.photoUrl,
                          academyName: data['name'],
                          academyImage: data['logo']['url'] ??
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSBUXESNi9dDwsxnZoDpAktF-piO2mU778bEQ&usqp=CAU',
                        )));
          },
          child: Row(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    data['logo']['url'] ?? defaultImageIcon,
                  )),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(data['name'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//              Container(
//                  padding: EdgeInsets.only(top:5, right:5),
//                  child:
                  Text('Admin Office', style: TextStyle(fontSize: 15)),
//    ),
                ]),
//            Spacer(),
//            Column(children:<Widget>[
//              Text((data['messages'].length != 0) ? getTimeString(data['messages'][data['messages'].length - 1]['dateAndTime']) : '',),
//              Visibility(
//                visible: (data['messages'].length != 0),
//                child: Container(
//                  margin: EdgeInsets.only(top:15),
//                  height: 10,
//                  width: 10,
//                  decoration: new BoxDecoration(
//                      color: Colors.blue,
//                      shape: BoxShape.circle),
//                ),
//              ),
//            ]),
          ]),
        ));
  }
}
