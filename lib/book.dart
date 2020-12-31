import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zariya/resources/strings.dart' as Strings;
import 'package:zariya/widgets/functions.dart';

class Book extends StatefulWidget {
  final dynamic course;
  final String email, academyEmail, academyLogo;
  final bool isReserved;

  Book({this.course, this.email, this.academyEmail, this.academyLogo, this.isReserved});

  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  @override
  void initState(){
    super.initState();
    print(widget.academyEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: SizedBox(
            width: 20,
            height: 20,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              child: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
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
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              (widget.isReserved == false)
              ? Container(
                height: MediaQuery.of(context).size.height - 300,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    for (int i = 0; i < widget.course['images'].length; i++)
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 2),
                        height: 250,
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(widget.course['images'][i]['url'] ??
                            Strings.defaultImageIcon, fit : BoxFit.cover),
                      ),
                  ],
                ),
              )
              : Container(),
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
                        margin: EdgeInsets.only(top: 10, left: 10),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Text(
                          '${widget.course['category']}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
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
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Image.network(widget.academyLogo ??
                                  Strings.defaultImageIcon)),
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child: Text(
                          'End Date : ${getDateString(widget.course['end'])}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                        ),
                      ),
                      (widget.course['start']==null)?
                      Container()  :
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child:
                        Text(
                          'Start Date: ${getDateString(widget.course['start'])}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                        ),
                      ),
                      (widget.course['fees']==null)?
                      Container()  :
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child:
                        Text(
                          'Fees : ${widget.course['fees']}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                        ),
                      ),
                      (widget.course['Seats']==null)?
                      Container()  :
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child:
                        Text(
                          'Total Seats : ${widget.course['seats']}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                        ),
                      ),
                      (widget.course['enrolled']==null)?
                      Container()  :
                      Container(
                        padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child:
                        Text(
                          'Enrolled : ${widget.course['enrolled']}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.only(left: 10, top: 2, bottom: 10),
                        child: Text(
                          'Date of Registry : ${getDateString(DateTime.now())}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 15),
                        ),
                      ),
                      (widget.isReserved == false)
                      ? Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            try {
                              Firestore.instance
                                  .collection('users')
                                  .document(widget.email)
                                  .setData({
                                    'reservations': FieldValue.arrayUnion([
                                      {
                                        'id': widget.course['id'],
                                        'title': widget.course['title'],
                                        'duration': widget.course['duration'],
                                        'schedule':
                                            '${getDateString(widget.course['start'])} - ${getDateString(widget.course['end'])}',
                                        'timing' : '${getTimeString(widget.course['start'])} - ${getTimeString(widget.course['end'])}',
                                        'fees' : widget.course['fees'],
                                        'dateAndTime' : DateTime.now()
                                      }
                                    ])
                                  }, merge: true)
                                  .then((data) => Firestore.instance
                                          .collection('academies')
                                          .document(widget.academyEmail)
                                          .collection('enrolled')
                                          .document(widget.course['id'])
                                          .setData({
                                        'users': FieldValue.arrayUnion([
                                          {
                                            'email': widget.email,
                                          }
                                        ])
                                      }, merge: true))
                                  .then((value) async => await Firestore.instance
                                          .collection('academies')
                                          .document(widget.academyEmail)
                                          .get()
                                          .then((data) {
                                            Map<String, dynamic> subCats = data['subCategories'];
                                            subCats.forEach((key, value) {
                                              if (widget.course['category'] == key)
                                              {
                                                List<dynamic> courseList = subCats[key];
                                                for(int i = 0; i < courseList.length; i++)
                                                {
                                                  if (widget.course['id'] == courseList[i]['id'])
                                                  {
                                                    courseList[i]['enrolled'] += 1;
                                                  }
                                                }
                                                subCats[key] = courseList;
                                              }
                                            });
                                        Firestore.instance
                                            .collection('academies')
                                            .document(widget.academyEmail)
                                            .updateData({
                                              'subCategories': subCats
                                        });
                                      }))
                                  .whenComplete(() => Navigator.pop(context));
                            } catch (err) {
                              print(err);
                            }
                          },
                          child: Text(
                            'RESERVE',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      )
                      : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
