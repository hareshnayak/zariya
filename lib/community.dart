import 'package:flutter/material.dart';
import 'package:zariya/dance.dart';
import 'package:zariya/navDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_pro/carousel_pro.dart';

final Color grey1 = Colors.grey.shade300;

class Community extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
//       margin: EdgeInsets.all(5),
      child: FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance
            .collection('community')
            .document('community')
            .get(),
        builder: (context, snapshot) {
          if(!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return ListView(
            children: <Widget>[
              Center(
                child: SizedBox(
                  height: 350.0,
                  width: MediaQuery.of(context).size.width - 20,
                  child: Carousel(
                    boxFit: BoxFit.cover,
                    autoplay: true,
                    animationCurve: Curves.fastOutSlowIn,
                    animationDuration: Duration(milliseconds: 1000),
                    dotSize: 6.0,
                    dotIncreasedColor: Color(0xFFFF335C),
                    dotBgColor: Colors.transparent,
                    dotPosition: DotPosition.topRight,
                    dotVerticalPadding: 10.0,
                    showIndicator: true,
                    indicatorBgPadding: 7.0,
                    images: [
                      for (int index  = 0; index < snapshot.data['cards'].length; index++)
                        Stack(children: <Widget>[
                          FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => Dance()));
                            },
                            child: Container(
                              height: 350,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: grey1,
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  image: new DecorationImage(
                                      image: NetworkImage(
                                          snapshot.data['cards'][index]['image']),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Positioned(
                            bottom: 50,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {},
                              child: Container(
                                width: 150,
                                height: 30,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Text('#${snapshot.data['cards'][index]['tag']}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                        color: Colors.white)),
                              ),
                            ),
                          ),
//                          Positioned(
//                            bottom: 10,
//                            child: Container(
//                              width: MediaQuery.of(context).size.width - 20,
//                              height: 40,
//                              padding: EdgeInsets.all(0),
//                              margin: EdgeInsets.symmetric(horizontal: 10),
//                              decoration: BoxDecoration(
//                                color: Colors.black45,
//                                borderRadius: BorderRadius.only(
//                                    bottomLeft: Radius.circular(15),
//                                    bottomRight: Radius.circular(15)),
//                              ),
//                              child: Padding(
//                                  padding: EdgeInsets.all(10),
//                                  child: Row(
//                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                      children: <Widget>[
//                                        Text('number of views',
//                                            style: TextStyle(color: Colors.white)),
//                                        Icon(Icons.visibility, color: Colors.white),
//                                      ])),
//                            ),
//                          )
                        ]),
                    ],
                  ),
                ),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'New Posts',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                ),
                for (int k = 0, imageIndex = 0; k < 3 && imageIndex < snapshot.data['allPosts'].length; k++)
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            for (int k = 0; k < 3 && imageIndex < snapshot.data['allPosts'].length; k++, imageIndex++)
                              FlatButton(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                onPressed: () {
//                                  launch(snapshot.data['allPosts'][imageIndex]['link']);
                                },
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: 85,
                                      height: 85,
                                      decoration: BoxDecoration(
                                        image: new DecorationImage(
                                            image:
                                                NetworkImage(snapshot.data['allPosts'][imageIndex]['image']),
                                            fit: BoxFit.cover),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        color: grey1,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ]))
              ]),
            ],
          );
        },
      ),
    );
  }
}
