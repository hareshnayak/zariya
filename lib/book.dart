import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zariya/resources/colors.dart';
import 'package:zariya/widgets/functions.dart';

class Book extends StatefulWidget {
  final dynamic course;
  final String email;
  Book({this.course, this.email});
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading : Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: SizedBox(
            width: 20,
            height: 20,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              child: Icon(Icons.arrow_back_ios,
                  color: Colors.black, size: 20),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
        title: Text(
            'CLASS DETAILS',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 17,
                fontFamily: 'Inter',
                letterSpacing: -0.3),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                for (int i = 0; i < widget.course['images'].length; i++)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 2),
                    height: 170,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(widget.course['images'][i]['url']),
                  ),
              ],
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(top:10,left:10),
                      decoration: BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                      ),
                      child: Text(
                        widget.course['category'], style: TextStyle(color: Colors.white,fontSize: 13, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal:10),
                          width: 200,
                          child: Text(
                            '${widget.course['title']} : ${widget.course['duration']}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ),
                        Spacer(),
                        Container(
                          margin: EdgeInsets.only(right: 10, top: 10),
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: Text(
                        'End Date : ${getDateString(widget.course['end'])}',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: Text(
                        'Fees : ${widget.course['fees']}',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: Text(
                        'Date of Registry : ${getDateString(DateTime.now())}',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.normal,
                            fontSize: 15),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          try{
                            Firestore.instance.collection('users').document(widget.email)
                                .setData({
                              'reservations' : FieldValue.arrayUnion([{
                                'id' : widget.course['id'],
                                'title' : widget.course['title'],
                                'duration' : widget.course['duration'],
                                'timing' : '${getDateString(widget.course['start'])} - ${getDateString(widget.course['end'])}',
                                'fees' : widget.course['fees'],
                              }])
                            }, merge: true).whenComplete(() => Navigator.pop(context));
                          } catch(err) {
                            print(err);
                          }
                        },
                        child: Text(
                          'Reserve',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
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
}