import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zariya/book.dart';
import 'package:zariya/chatbox.dart';
import 'package:zariya/widgets/functions.dart';
import 'package:zariya/resources/strings.dart';
import 'package:zariya/resources/colors.dart';

class Academy extends StatelessWidget {
  Academy({this.data, this.email, this.currentUser});

  final dynamic data;
  final String email;
  final FirebaseUser currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.0),
        child: AppBar(
          iconTheme: new IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
//            leading: SizedBox(
//              width: 60,
//              height: 30,
//              child: FlatButton(
//                padding: EdgeInsets.all(0),
//                onPressed: () {},
//                child: Icon(Icons.menu, color: Colors.black),
//              ),
//            ),
//             SizedBox(
//                   width: 60,
//                 height: 30,
//                   child: FlatButton(
//                 padding: EdgeInsets.all(0),
//                       onPressed: () {},: Colors.black),
//           ),),
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
          //           child: Icon(Icons.search, color: Colors.black)))
          // ],
        ),
      ),
      body: Container(
        child: new Builder(
          builder: (context) {
            return AcademyPage(
                data: data, email: email, currentUser: currentUser);
          },
        ),
      ),
    );
  }
}

int _current = 0;
int noReviews = 0;

class AcademyPage extends StatefulWidget {
  AcademyPage({this.data, this.email, this.currentUser});

  final dynamic data;
  final String email;
  final FirebaseUser currentUser;

  @override
  _AcademyPageState createState() => _AcademyPageState();
}

class _AcademyPageState extends State<AcademyPage> {
  List<String> subCategories = [];
  List<dynamic> course = [];
  List<String> imgList = [];

  @override
  void initState() {
    // TODO: implement initState
    widget.data['subCategories'].forEach((key, value) {
      subCategories.add(key);
      for (int i = 0; i < value.length; i++) {
        course.add(value[i]);
      }
    });

    for (var image in widget.data['images'])
      imgList.add(image['url'] ?? defaultImageIcon);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
//       margin: EdgeInsets.all(5),
      child: new Builder(
        builder: (context) {
          return new ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                height: 40,
                color: grey300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(widget.data['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                    ),
                    SizedBox(
                      width: 60,
                      child: FlatButton(
                        onPressed: () => about(context),
                        child: Icon(Icons.info_outline, color: Colors.blue),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      initialPage: 0,
                      autoPlay: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                  items: imgList
                      .map(
                        (item) => Container(
                          margin: EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            child: Image.network(item,
                                fit: BoxFit.cover, width: 1000.0),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              Container(
                height: 70,
                color: Colors.white,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 90,
                        child: FlatButton(
                          padding: EdgeInsets.only(left: 40),
                          onPressed: () => address(context),
                          child: Icon(Icons.near_me,
                              color: Colors.black, size: 40),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: SizedBox(
                          width: 70,
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () => rating(context),
                            child: Text('${widget.data['rating']}/5',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 40)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 90,
                        child: FlatButton(
                          padding: EdgeInsets.only(right: 40),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatBox(
                                  email: widget.currentUser.email,
                                  myName: widget.currentUser.displayName,
                                  myImage: widget.currentUser.photoUrl,
                                  academyName: widget.data['name'],
                                  academyImage: widget.data['logo']['url'] ??
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSBUXESNi9dDwsxnZoDpAktF-piO2mU778bEQ&usqp=CAU',
                                ),
                              ),
                            );
                          },
                          child: Icon(Icons.chat_bubble,
                              color: Colors.black, size: 50),
                        ),
                      ),
                    ]),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int j = 0; j < subCategories.length; j++)
                      Row(
                        children: <Widget>[
                          Text(
                            '${subCategories[j]}',
                            style: TextStyle(fontSize: 15),
                          ),
                          if (j != subCategories.length - 1)
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 3),
                              height: 5,
                              width: 5,
                              decoration: new BoxDecoration(
                                  color: Colors.black, shape: BoxShape.circle),
                            ),
                          SizedBox(width: 5),
                        ],
                      ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                height: 40,
                color: grey300,
                child: Center(
                  child: Text('UPCOMING CLASSES',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
              ),
              for (int k = 0; k < course.length; k++) _buildCourse(course[k])
            ],
          );
        },
      ),
    );
  }

  Widget _buildCourse(dynamic course) {
    List<String> keys = [], values = [];
    course.forEach((key, value) {
      if (key == 'start') {
        keys.add('Start Date');
        values.add(getDateString(value.toDate()));
      } else if (key == 'end') {
        keys.add('End Date');
        values.add(getDateString(value.toDate()));
//      } else if (key == 'title') {
//        keys.insert(0, 'Title');
//        values.insert(0, value);
//      } else if (key == 'seats') {
//        keys.add('Seats');
//        values.add('$value');
//      } else if (key == 'enrolled') {
//        keys.add('Enrolled');
//        values.add('$value');
      }
    });
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Card(
        color: grey300,
        child: Column(
          children: <Widget>[
            Container(color: grey300, height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(width: 10),
                    Text(
                      course['category'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      height: 5,
                      width: 5,
                      decoration: new BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle),
                    ),
                    SizedBox(width: 5),
                    Text(
                      course['title'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(width: 5),
                    Text(
                      course['duration'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ],
                ),
              ],
            ),
            Container(color: grey300, height: 3),
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    for (int i = 0; i < keys.length; i++)
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text('${keys[i]}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left),
                      ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    for (int i = 0; i < values.length; i++)
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(': ${values[i]}',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.left),
                      ),
                  ],
                ),
              ],
            ),
            Container(
//                           margin: EdgeInsets.all(15),
              margin: EdgeInsets.only(top: 15),
              height: 30,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: FlatButton(
                onPressed: () {
                  print(course);
                  print(widget.data.documentID);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Book(
                              course: course,
                              email: widget.email,
                              academyEmail: widget.data.documentID,
                              academyLogo: widget.data['logo']['url'],
                              isReserved: false)));
                },
                child: Text(
                  'BOOK NOW',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  address(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return new Container(
            height: 250,
            child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                height: 40,
                color: grey300,
                child: Center(
                  child: Text('ADDRESS',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 1,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(widget.data['address'],
                                  textAlign: TextAlign.center)));
                    }),
              )
            ]),
          );
        });
  }

  about(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return new Container(
            height: 250,
            child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                height: 40,
                color: grey300,
                child: Center(
                  child: Text('ABOUT',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 1,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(widget.data['about'],
                                  textAlign: TextAlign.center)));
                    }),
              )
            ]),
          );
        });
  }

  rating(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return new Container(
            height: 300,
            child: Column(children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                height: 40,
                color: grey300,
                child: Center(
                  child: Text('RATING AND REVIEWS',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int f = 0; f < 5; f++)
                      if (f < widget.data['rating'])
                        Icon(Icons.star, color: Colors.black, size: 18)
                      else
                        Icon(Icons.star_border, color: Colors.grey, size: 18)
                  ],
                ),
              ),
              Text('$noReviews students reviewed', textAlign: TextAlign.center),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text('${widget.data['rating']}/5',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              Text('By Category',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                    itemCount: subCategories.length,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Row(children: <Widget>[
                                Text('${subCategories[index]}'),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    for (int f = 0; f < 5; f++)
                                      if (f < widget.data['rating'])
                                        Icon(Icons.star,
                                            color: Colors.black, size: 15)
                                      else
                                        Icon(Icons.star_border,
                                            color: Colors.grey, size: 15)
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text('${widget.data['rating']}/5',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)),
                                ),
                              ])));
                    }),
              )
            ]),
          );
        });
  }
}
