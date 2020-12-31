import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:zariya/dance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:zariya/post.dart';
import 'package:zariya/resources/strings.dart' as Strings;

final Color grey1 = Colors.grey.shade300;

class Community extends StatefulWidget {
  Community({this.email, this.name, this.photoUrl, this.followId});

  final String email, name, photoUrl, followId;

  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
//       margin: EdgeInsets.all(5),
          child: FutureBuilder<DocumentSnapshot>(
            future: Firestore.instance
                .collection('community')
                .document('community')
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              List<String> imgList = [], tagList = [];
              if (imgList.isEmpty)
                for (int i = 0; i < snapshot.data['cards'].length; i++) {
                  imgList.add(snapshot.data['cards'][i]['image']);
                  tagList.add(snapshot.data['cards'][i]['tag']);
                }
              return ListView(
                children: <Widget>[
                  Center(
                    child: Column(
                      children: [
                        Container(
                          height: 250,
                          child: FlatButton(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => Dance(
                                            category: tagList[_current],
//                                              email: email, name: name, photoUrl: photoUrl
                                          )));
                            },
                            child: CarouselSlider(
                              options: CarouselOptions(
                                enlargeStrategy: CenterPageEnlargeStrategy.scale,
//                                aspectRatio: 2.0,
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
//                                      margin: EdgeInsets.all(5.0),
                                    color: grey1,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0)),
                                        child: Stack(
                                          children: [
                                            Container(
                                                width: MediaQuery.of(context).size.width,
                                                child: Image.network(item, fit : BoxFit.cover)),
                                            Positioned(
                                              bottom: 10,
                                              left: 10,
                                              child: Text(
                                                '#${tagList[_current]}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imgList.map((url) {
                            int index = imgList.indexOf(url);
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.only(
                                  left: 2.0, right: 2.0, bottom: 10),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _current == index
                                    ? Color.fromRGBO(0, 0, 0, 0.9)
                                    : Color.fromRGBO(0, 0, 0, 0.4),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
//                  Center(
//                    child: SizedBox(
//                      height: 350.0,
//                      width: MediaQuery.of(context).size.width - 20,
//                      child: Carousel(
//                        boxFit: BoxFit.cover,
//                        autoplay: true,
//                        animationCurve: Curves.fastOutSlowIn,
//                        animationDuration: Duration(milliseconds: 1000),
//                        dotSize: 6.0,
//                        dotIncreasedColor: Color(0xFFFF335C),
//                        dotBgColor: Colors.transparent,
//                        dotPosition: DotPosition.topRight,
//                        dotVerticalPadding: 10.0,
//                        showIndicator: true,
//                        indicatorBgPadding: 7.0,
//                        images: [
//                          for (int index = 0;
//                              index < snapshot.data['cards'].length;
//                              index++)
//                            FlatButton(
//                              padding: EdgeInsets.all(0),
//                              onPressed: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                        builder: (BuildContext context) =>
//                                            Dance(
//                                              category: snapshot.data['cards']
//                                                  [index]['tag'],
////                                              email: email, name: name, photoUrl: photoUrl
//                                            )));
//                              },
//                              child: Stack(children: <Widget>[
//                                Container(
//                                  height: 350,
//                                  margin: EdgeInsets.all(10),
//                                  decoration: BoxDecoration(
//                                      color: grey1,
//                                      borderRadius:
//                                          BorderRadius.all(Radius.circular(15)),
//                                      image: new DecorationImage(
//                                          image: NetworkImage(
//                                              snapshot.data['cards'][index]
//                                                      ['image'] ??
//                                                  Strings.defaultImageIcon),
//                                          fit: BoxFit.cover)),
//                                ),
//                                Positioned(
//                                  bottom: 50,
//                                  child: Container(
////                                    width: 150,
//                                    height: 30,
//                                    padding:
//                                        EdgeInsets.symmetric(horizontal: 5),
//                                    margin:
//                                        EdgeInsets.symmetric(horizontal: 10),
//                                    child: Text(
//                                        '#${snapshot.data['cards'][index]['tag']}',
//                                        style: TextStyle(
//                                            fontWeight: FontWeight.bold,
//                                            fontSize: 30,
//                                            color: Colors.white)),
//                                  ),
//                                ),
////                          Positioned(
////                            bottom: 10,
////                            child: Container(
////                              width: MediaQuery.of(context).size.width - 20,
////                              height: 40,
////                              padding: EdgeInsets.all(0),
////                              margin: EdgeInsets.symmetric(horizontal: 10),
////                              decoration: BoxDecoration(
////                                color: Colors.black45,
////                                borderRadius: BorderRadius.only(
////                                    bottomLeft: Radius.circular(15),
////                                    bottomRight: Radius.circular(15)),
////                              ),
////                              child: Padding(
////                                  padding: EdgeInsets.all(10),
////                                  child: Row(
////                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                                      children: <Widget>[
////                                        Text('number of views',
////                                            style: TextStyle(color: Colors.white)),
////                                        Icon(Icons.visibility, color: Colors.white),
////                                      ])),
////                            ),
////                          )
//                              ]),
//                            ),
//                        ],
//                      ),
//                    ),
//                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'New Posts',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ),
                        for (int k = 0, imageIndex = 0;
                            k < 3 &&
                                imageIndex < snapshot.data['allPosts'].length;
                            k++)
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    for (int k = 0;
                                        k < 3 &&
                                            imageIndex <
                                                snapshot
                                                    .data['allPosts'].length;
                                        k++, imageIndex++)
                                      FlatButton(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
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
                                                    image: NetworkImage(snapshot
                                                                        .data[
                                                                    'allPosts']
                                                                [imageIndex]
                                                            ['image'] ??
                                                        Strings
                                                            .defaultImageIcon),
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
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Post(
                    email: widget.email,
                    name: widget.name,
                    photoUrl: widget.photoUrl,
                    followId: widget.followId,
                  ),
                ),
              );
            },
            backgroundColor: Colors.black,
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
