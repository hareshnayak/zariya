import 'package:zariya/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zariya/resources/strings.dart';

class ChatBox extends StatefulWidget {
  ChatBox(
      {this.myImage,
      this.email,
      this.myName,
      this.academyEmail,
      this.academyImage,
      this.academyName,
      this.otherEmail,
      this.otherImage,
      this.otherName,
      this.isAcademyChat,
      this.isTeacher});

  final String academyEmail, academyName, academyImage;
  final String otherEmail, otherName, otherImage;
  final String email, myName, myImage;
  final bool isAcademyChat, isTeacher;

  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  TextEditingController messageController = new TextEditingController();

  bool recordPresent = false;

  Future<bool> checkRecord() async {
    if (widget.isAcademyChat == true) {
      try {
        await Firestore.instance
            .collection('academies/${widget.academyEmail}/chats')
            .document(widget.email)
            .get()
            .then((value) {
          if (value.exists == true)
            recordPresent = true;
          else
            recordPresent = false;
        });
      } catch (e) {
        print('Cannot access firestore!!!');
      }
    } else if (widget.isTeacher) {
      print('is teacher is true');
      print(widget.email);
      print(widget.otherEmail);
      try {
        await Firestore.instance
            .collection('teachers/${widget.email}/chats')
            .document(widget.otherEmail)
            .get()
            .then((value) {
          if (value.exists == true)
            recordPresent = true;
          else
            recordPresent = false;
        });
      } catch (e) {
        print('Cannot access firestore!!!');
      }
    } else {
      try {
        await Firestore.instance
            .collection('teachers/${widget.otherEmail}/chats')
            .document(widget.email)
            .get()
            .then((value) {
          if (value.exists == true)
            recordPresent = true;
          else
            recordPresent = false;
        });
      } catch (e) {
        print('Cannot access firestore!!!');
      }
    }
    return recordPresent;
  }

  void sendMessage() {
    List<Map<String, dynamic>> message = [
      {
        'message': messageController.value.text,
        'dateTime': DateTime.now(),
        'sender': (widget.isTeacher) ? 'teacher' : 'user',
      }
    ];
    Map<String, dynamic> sendData = {};
    if (!recordPresent) {
      if (widget.isTeacher) {
        sendData = {
          'messages': FieldValue.arrayUnion(message),
          'email': widget.otherEmail,
          'name': widget.otherName,
          'photoUrl': widget.otherImage,
        };
      } else {
        sendData = {
          'messages': FieldValue.arrayUnion(message),
          'email': widget.email,
          'name': widget.myName,
          'photoUrl': widget.myImage,
        };
      }
    } else {
      sendData = {'messages': FieldValue.arrayUnion(message)};
    }
    if (widget.isAcademyChat) {
      Firestore.instance
          .collection('academies/${widget.academyEmail}/chats')
          .document(widget.email)
          .setData(sendData, merge: true);
    } else if (widget.isTeacher) {
      Firestore.instance
          .collection('teachers/${widget.email}/chats')
          .document(widget.otherEmail)
          .setData(sendData, merge: true);
    } else {
      Firestore.instance
          .collection('teachers/${widget.otherEmail}/chats')
          .document(widget.email)
          .setData(sendData, merge: true);
    }
    setState(() {
      messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.deepPurple),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
            child: Container(
              color: Colors.deepPurple,
              height: 4.0,
            ),
            preferredSize: Size.fromHeight(4.0)),
//           centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              child: ListTile(
                trailing: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: CircleAvatar(
                    radius: 25,
                    backgroundImage: new NetworkImage(
                        widget.academyImage ?? defaultImageIcon),
                  ),
                ),
                title: Text(
                  (widget.isAcademyChat)
                      ? widget.academyName
                      : widget.otherName,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    letterSpacing: -0.3,
                    fontFamily: 'Inter',
                  ),
                ),
                subtitle: Text(
                  'Admin Office',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal,
                    fontSize: 13,
                    letterSpacing: -0.3,
                    fontFamily: 'Inter',
                  ),
                ),
              ),
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
            ),
            Container(
              height: MediaQuery.of(context).size.height - 160,
              padding: EdgeInsets.symmetric(horizontal: 10),
              color: Colors.transparent,
              child: FutureBuilder<bool>(
                future: checkRecord(),
                builder: (context, bool) {
                  print('record present : $recordPresent');
                  if (recordPresent)
                    return FutureBuilder<DocumentSnapshot>(
                      future: (widget.isAcademyChat)
                          ? Firestore.instance
                              .collection('academies')
                              .document(
                                  '${widget.academyEmail}/chats/${widget.email}')
                              .get()
                          : (widget.isTeacher)
                              ? Firestore.instance
                                  .collection('teachers')
                                  .document(
                                      '${widget.email}/chats/${widget.otherEmail}')
                                  .get()
                              : Firestore.instance
                                  .collection('teachers')
                                  .document(
                                      '${widget.otherEmail}/chats/${widget.email}')
                                  .get(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Center(child: CircularProgressIndicator());
                        return _buildChats(context, snapshot.data['messages']);
                      },
                    );
                  return Center(
                      child: emptyListWidget('There are no messages.'));
                },
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.white,
                height: 55,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 45,
                      margin: EdgeInsets.fromLTRB(10, 5, 5, 8),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width - 80,
                      decoration: BoxDecoration(
                        color: Color(0xFFF0EDFF),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      child: TextField(
                        controller: messageController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
//                 contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: -10),
                          hintText: 'Enter Message',
                          hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 65,
                      child: Builder(builder: (context) {
                        return FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            if (messageController.value.text.isEmpty) {
                              final snackBar = SnackBar(
                                  content: Text('Please Enter Text!!!'));
                              Scaffold.of(context).showSnackBar(snackBar);
                            } else
                              setState(() {
                                sendMessage();
                              });
                          },
                          child: Container(
                            height: 45,
                            margin: EdgeInsets.fromLTRB(0, 5, 10, 8),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            // width: 60,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChats(BuildContext context, List<dynamic> dataList) {
    if (dataList.isEmpty)
      return emptyListWidget('There are no messages till now.');
    else
      return ListView.builder(
          itemCount: dataList.length,
          physics: ScrollPhysics(),
          shrinkWrap: true,
          reverse: true,
          itemBuilder: (context, i) {
            int item = dataList.length - i - 1;
            if (widget.isTeacher) {
              if (dataList[item]['sender'] == 'teacher')
                return userMsg(context, dataList[item]);
              else
                return otherMsg(context, dataList[item]);
            } else {
              if (dataList[item]['sender'] == 'user')
                return userMsg(context, dataList[item]);
              else
                return otherMsg(context, dataList[item]);
            }
          });
  }
}
