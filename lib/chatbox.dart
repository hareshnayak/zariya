import 'package:zariya/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatBox extends StatefulWidget {
  ChatBox(
      {this.myImage,
      this.email,
      this.myName,
      this.academyImage,
      this.academyName});

  final String academyName, academyImage;
  final String email, myName, myImage;

  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  TextEditingController messageController = new TextEditingController();

  bool recordPresent = false;

//  void checkRecord() async {
//    var doc;
//    if (widget.office == true) {
//      doc = await Firestore.instance
//          .collection('schools')
//          .document(
//              '${widget.school}/students/${widget.studentID}/otherDetails/messages')
//          .get();
//    } else {
//      doc = await Firestore.instance
//          .collection('schools')
//          .document(
//              '${widget.school}/teachers/${widget.teacherID}/chatBox/${widget.studentID}')
//          .get();
//    }
//    setState(() {
//      if (doc.exists)
//        recordPresent = true;
//      else
//        recordPresent = false;
//    });
//  }

//  void sendMessage() {
//    var data;
//    if (recordPresent == false) {
//      if (widget.office == true) {
//        Firestore.instance
//            .collection('schools')
//            .document(
//                '${widget.school}/students/${widget.studentID}/otherDetails/messages')
//            .setData({
//          'messages': [
//            {
//              'dateAndTime': DateTime.now(),
//              'text': messageController.value.text,
//              'type': false,
//            }
//          ],
//        }, merge: true).then((value) => setState(() {
//                  recordPresent = true;
//                }));
//      } else {
//        Firestore.instance
//            .collection('schools')
//            .document(
//                '${widget.school}/teachers/${widget.teacherID}/chatBox/${widget.studentID}')
//            .setData({
//          'name': (widget.type) ? widget.chatHead : widget.stdName,
//          'classSec': (widget.type) ? widget.chatSub : widget.stdClass,
//          'image': (widget.type) ? widget.image : widget.stdImage,
//          'email': widget.studentID,
//        }, merge: true).then((value) => setState(() {
//                  recordPresent = true;
//                }));
//      }
//    }
//    data = {
//      'dateAndTime': DateTime.now(),
//      'text': messageController.value.text,
//      'type': widget.type,
//    };
//    if (widget.office == true) {
//      Firestore.instance
//          .collection('schools')
//          .document(
//              '${widget.school}/students/${widget.studentID}/otherDetails/messages')
//          .updateData({
//        'messages': FieldValue.arrayUnion([data]),
//      });
//      Firestore.instance
//          .collection('schools')
//          .document('${widget.school}/others/messageToOfficeDoc')
//          .updateData({
//        'messages': FieldValue.arrayUnion([
//          {
//            'dateAndTime': DateTime.now(),
//            'text': messageController.value.text,
//            'sender': '${widget.stdName} - ${widget.stdClass}',
//            'email' : widget.studentID,
//          }
//        ]),
//      });
//    } else {
//      Firestore.instance
//          .collection('schools')
//          .document(
//              '${widget.school}/teachers/${widget.teacherID}/chatBox/${widget.studentID}')
//          .setData({
//        'chats': FieldValue.arrayUnion([data])
//      }, merge: true);
//    }
//    setState(() {
//      messageController.clear();
//    });
//  }

//  @override
//  void initState() {
//    // TODO: implement initState
//    checkRecord();
//    super.initState();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
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
                leading: Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: CircleAvatar(
                    radius: 25,
//                     backgroundImage: new NetworkImage(widget.academyImage ?? Strings.defaultImageIcon),
                  ),
                ),
                title: Text(
                  'widget.academyName',
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
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 160,
            padding: EdgeInsets.symmetric(horizontal: 10),
            color: Colors.transparent,
            child: FutureBuilder<DocumentSnapshot>(
              future: Firestore.instance
                  .collection('users')
                  .document('${widget.email}/chatBox')
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                else if (recordPresent == true)
                  return _buildChats(context, snapshot.data['messages']);
                return Container();
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
                    margin: EdgeInsets.fromLTRB(10, 5, 10, 8),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width - 60,
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
                    width: 40,
                    child: Builder(builder: (context) {
                      return FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          if (messageController.value.text.isEmpty) {
                            final snackBar =
                                SnackBar(content: Text('Please Enter Text!!!'));
                            Scaffold.of(context).showSnackBar(snackBar);
                          }
//                          else
//                            setState(() {
//                              sendMessage();
//                            });
                        },
                        child: Image.asset('assets/images/send.png', width: 20),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChats(BuildContext context, List<dynamic> dataList) {
    return ListView.builder(
        itemCount: dataList.length,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        reverse: true,
        itemBuilder: (context, i) {
          int item = dataList.length - i - 1;
          if (dataList[item]['type'] ==
              true) // teacher message is true and student message type is false
            return otherMsg(context, dataList[item]);
          else
            return myMsg(context, dataList[item]);
        });
  }
}
