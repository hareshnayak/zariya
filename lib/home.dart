import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zariya/academies.dart';
import 'package:zariya/community.dart';
import 'package:zariya/resources/colors.dart' as appColors;
import 'package:carousel_pro/carousel_pro.dart';

final List<String> postImg = [
  'https://cdn.pixabay.com/photo/2016/07/08/23/17/girl-1505407__340.jpg',
  'https://cdn.pixabay.com/photo/2018/02/06/14/07/dance-3134828__340.jpg',
  'https://cdn.pixabay.com/photo/2013/05/01/21/46/tango-108483__340.jpg',
  'https://cdn.pixabay.com/photo/2016/05/06/17/06/ballet-1376250__340.jpg',
  'https://cdn.pixabay.com/photo/2014/02/27/16/10/medieval-276019__340.jpg'
];
final List<String> arrived = [
  'https://cdn.pixabay.com/photo/2018/01/14/23/12/nature-3082832__340.jpg',
  'https://cdn.pixabay.com/photo/2016/10/21/14/50/plouzane-1758197__340.jpg',
  'https://cdn.pixabay.com/photo/2013/08/20/15/47/sunset-174276__340.jpg',
  'https://cdn.pixabay.com/photo/2013/07/18/10/56/railroad-tracks-163518__340.jpg',
  'https://cdn.pixabay.com/photo/2013/11/28/10/36/road-220058__340.jpg'
];

final List<String> aCat = ['Dance', 'Music', 'theatre'];
final List<String> sdCat = ['Dance', 'Music', 'theatre'];
final List<String> sName = ['kalā', 'paritrāṇa', 'aarogya', 'Krīḍā'];
final List<String> eName = [
  'performing arts',
  'self defense',
  'fitness',
  'sports'
];

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
        future: FirebaseFirestore.instance.collection('community').doc('home').get(),
        builder:(context, snapshot){
          if(!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return Stack(
            children: [
              Column(
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
                    height: MediaQuery.of(context).size.height - 270,
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
                                          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Academies()));
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
              ),
              Positioned(
                bottom: 10,
                right:10,
                child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder:
                              (BuildContext context) => Community()));
                    },
                    child: Icon(Icons.people),
                    backgroundColor: Colors.green),
              ),
            ],
          );
        },
      ),
    );
  }
}