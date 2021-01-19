import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zariya/chatbox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:zariya/resources/strings.dart';
import 'package:zariya/resources/colors.dart';
import 'package:zariya/widgets/widgets.dart';

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
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Search', border: InputBorder.none),
              ),
            ),
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
              child: Text('Academies',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('academies').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              else if (snapshot.data.documents == null ||
                  snapshot.data.documents.length == 0)
                return Center(
                    child: emptyListWidget('There are no academies.'));
              return chatItemsList(context, snapshot.data.documents, true);
            },
          ),
          Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: Text('Teachers',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('teachers').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              else if (snapshot.data.documents == null ||
                  snapshot.data.documents.length == 0)
                return Center(
                    child: emptyListWidget('There are no teachers currently.'));
              return chatItemsList(context, snapshot.data.documents, false);
            },
          ),
        ],
      ),
    );
  }

  Widget chatItemsList(
      BuildContext context, List<DocumentSnapshot> doc, bool isAcademy) {
    return Expanded(
      child: ListView.builder(
          itemCount: doc.length,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (BuildContext context, int i) {
            return chatItem(context, doc[i].data, isAcademy);
          }),
    );
  }

  Widget chatItem(BuildContext context, dynamic data, bool isAcademy) {
    return Container(
        height: 70,
        padding: EdgeInsets.all(10),
        child: FlatButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              if (isAcademy) {
                return ChatBox(
                  email: widget.currentUser.email,
                  myName: widget.currentUser.displayName,
                  myImage: widget.currentUser.photoUrl,
                  isAcademyChat: true,
                  academyEmail: data['email'],
                  academyName: data['name'],
                  academyImage: data['logo']['url'] ?? defaultImageIcon,
                );
              } else {
                return ChatBox(
                  email: widget.currentUser.email,
                  myName: widget.currentUser.displayName,
                  myImage: widget.currentUser.photoUrl,
                  isAcademyChat: false,
                  teacherEmail: data['email'],
                  teacherName: data['name'],
                  teacherImage: data['photoUrl'] ?? defaultImageIcon,
                );
              }
            }));
          },
          child: Row(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    (isAcademy)
                        ? data['logo']['url'] ?? defaultImageIcon
                        : data['photoUrl'] ?? defaultImageIcon,
                  )),
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data['name'],
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
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
