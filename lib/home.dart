import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zariya/academies.dart';
import 'package:zariya/resources/colors.dart' as appColors;
import 'package:carousel_pro/carousel_pro.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
//       margin: EdgeInsets.all(5),
      child: FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance.collection('community').document('home').get(),
        builder:(context, snapshot){
          if(!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return Column(
                children: <Widget>[
                  Center(
                    child: SizedBox(
                      height: 250.0,
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
                          for (var image in snapshot.data['images'])
                            NetworkImage(image),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height - 375,
                    child: ListView.builder(
                      itemCount: snapshot.data['genres'].length,
                      itemBuilder: (context, item){
                        return Column(children: <Widget>[
                          Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: <Widget>[
                                  SizedBox(width: 20),
                                  Text(
                                    snapshot.data['genres'][item]['name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 22),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    height: 7,
                                    width: 7,
                                    decoration: new BoxDecoration(
                                        color: Colors.black, shape: BoxShape.circle),
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    snapshot.data['genres'][item]['topic'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 22),
                                  ),
                                ],
                              )),
                          Container(
                            height: 125,
                            color: Colors.transparent,
                            child: ListView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data['genres'][item]['categories'].length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10),
                                      child: FlatButton(
                                        padding: EdgeInsets.all(0),
                                        onPressed: () {
                                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Academies(category: snapshot.data['genres'][item]['categories'][index]['name'])));
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              width: 130,
                                              height: 100,
//                          child:Image.network('${postImg[index]}',
//                             fit: BoxFit.cover),
                                              decoration: BoxDecoration(
                                                image: new DecorationImage(
                                                    image: NetworkImage(
                                                        snapshot.data['genres'][item]['categories'][index]['image']),
                                                    fit: BoxFit.cover),
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight: Radius.circular(20),
                                                ),
                                                color: appColors.grey1,
                                              ),
                                            ),
                                            Container(
                                              color: Colors.white,
                                              height: 25,
                                              width: 130,
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal: 20),
                                                      child: Text(snapshot.data['genres'][item]['categories'][index]['name'],
                                                          style: TextStyle(
                                                              fontWeight: FontWeight.bold),
                                                          textAlign: TextAlign.right),
                                                    ),
                                                  ]),
                                            ),
                                          ],
                                        ),
                                      ));
                                }),
                          ),
                        ]);
                      }
                    ),
                  ),
                ],
              );
        },
      ),
    );
  }
}