import 'package:flutter/material.dart';
import 'package:zariya/dance.dart';
import 'package:zariya/navDrawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_pro/carousel_pro.dart';

final Color grey1 = Colors.grey.shade300;

class Community extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.0),
        child: AppBar(
          iconTheme: new IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
//            leading: SizedBox(
//                width: 60,
//                height: 30,
//                child: FlatButton(
//                    padding: EdgeInsets.all(0),
//                    onPressed: () {},
//                    child: Icon(Icons.menu, color: Colors.black))),
//             SizedBox(
//                   width: 60,
//                 height: 30,
//                   child: FlatButton(
//                 padding: EdgeInsets.all(0),
//                       onPressed: () {},: Colors.black))),
          title: Center(
            child: Text(
              'zariyā',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.black),
            ),
          ),
          elevation: 0,
          actions: <Widget>[
            SizedBox(
                width: 60,
                height: 30,
                child: FlatButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {},
                    child: Icon(Icons.search, color: Colors.black)))
          ],
        ),
      ),
//        bottomNavigationBar: Container(
//          height: 40,
//          child: BottomNavigationBar(
//            items: const <BottomNavigationBarItem>[
//              BottomNavigationBarItem(
//                icon: Icon(Icons.person, color: Colors.grey),
//                title: Padding(padding: EdgeInsets.all(0)),
//              ),
//              BottomNavigationBarItem(
//                icon: Icon(Icons.home, color: Colors.grey),
//                title: Padding(padding: EdgeInsets.all(0)),
//              ),
//              BottomNavigationBarItem(
//                icon: Icon(Icons.chat, color: Colors.grey),
//                title: Padding(padding: EdgeInsets.all(0)),
//              ),
//            ],
//
////         currentIndex: _selectedIndex,
////         selectedItemColor: Colors.amber[800],
////         onTap: _onItemTapped,
//          ),
//        ),
//         floatingActionButton: FloatingActionButton(
//             onPressed: () {},
//             child: Icon(Icons.people),
//             mini: true,
//             backgroundColor: Colors.green),
      body: CompanyPage(),
    );
  }
}

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

class CompanyPage extends StatefulWidget {
  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
//       margin: EdgeInsets.all(5),
      child: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('community')
            .doc('community')
            .get(),
        builder: (context, snapshot) {
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
                for (int k = 0; k < 3; k++)
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            for (int k = 0; k < 3; k++)
                              FlatButton(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                onPressed: () {},
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      width: 85,
                                      height: 85,
                                      decoration: BoxDecoration(
                                        image: new DecorationImage(
                                            image:
                                                NetworkImage('${postImg[4]}'),
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
