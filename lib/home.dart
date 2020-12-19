import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zariya/academies.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:zariya/resources/colors.dart' as appColors;
import 'package:carousel_pro/carousel_pro.dart';
import 'package:zariya/resources/strings.dart' as Strings;

class HomePage extends StatefulWidget {

  HomePage({this.email});

  final String email;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
//       margin: EdgeInsets.all(5),
      child: FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance.collection('community').document('home').get(),
        builder:(context, snapshot){
          if(!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          List<String> imgList = [];
          if (imgList.isEmpty)
            for(int i = 0; i < snapshot.data['images'].length; i++){
              imgList.add(snapshot.data['images'][i].toString());
            }
          return Column(
            children: <Widget>[
              Center(
                child: Column(
                  children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical:10.0),
                        child: CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            initialPage: 0,
                            autoPlay: true,
                            onPageChanged: (index, reason){
                              setState(() {
                                _current = index;
                              });
                            }
                          ),
                          items: imgList.map((item) => Container(
                              margin: EdgeInsets.all(5.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  child: Image.network(item, fit: BoxFit.cover, width: 1000.0),
                              ),
                            ),
                          ).toList(),
                        ),
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: imgList.map((url) {
                        int index = imgList.indexOf(url);
                        return Container(
                          width: 8.0,
                          height: 8.0,
                          margin: EdgeInsets.only(left: 2.0, right: 2.0, bottom: 10),
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
              Container(
                height: MediaQuery.of(context).size.height - 339,
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
                              String imageUrl = snapshot.data['genres'][item]['categories'][index]['image'];
                              if (imageUrl.isEmpty)
                                imageUrl = Strings.defaultImageIcon;
                              return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: FlatButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Academies(image: imageUrl, category: snapshot.data['genres'][item]['categories'][index]['name'], email: widget.email,)));
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
                                                     imageUrl ?? Strings.defaultImageIcon),
                                                fit: BoxFit.cover),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                            ),
//                                                color: appColors.grey1,
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white,
                                          height: 25,
                                          width: 130,
                                          child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
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
