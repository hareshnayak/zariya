import 'package:flutter/material.dart';

final Color grey1 = Colors.grey.shade300;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        hoverColor: Colors.transparent,
//         splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            leading: SizedBox(
              width: 60,
              height: 30,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: () {},
                child: Icon(Icons.menu, color: Colors.black),
              ),
            ),
//             SizedBox(
//                   width: 60,
//                 height: 30,
//                   child: FlatButton(
//                 padding: EdgeInsets.all(0),
//                       onPressed: () {},: Colors.black),
//           ),),
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
        bottomNavigationBar: Container(
          height: 40,
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.person, color: Colors.grey),
                title: Padding(padding: EdgeInsets.all(0)),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.grey),
                title: Padding(padding: EdgeInsets.all(0)),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat, color: Colors.grey),
                title: Padding(padding: EdgeInsets.all(0)),
              ),
            ],

//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.amber[800],
//         onTap: _onItemTapped,
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.people),
            mini: true,
            backgroundColor: Colors.green),
        body: Container(
          child: new Builder(
            builder: (context) {
              return AcademyPage();
            },
          ),
        ),
      ),
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
  'https://cdn.pixabay.com/photo/2016/07/08/23/17/girl-1505407__340.jpg',
  'https://cdn.pixabay.com/photo/2016/10/21/14/50/plouzane-1758197__340.jpg',
  'https://cdn.pixabay.com/photo/2013/08/20/15/47/sunset-174276__340.jpg',
  'https://cdn.pixabay.com/photo/2014/02/27/16/10/medieval-276019__340.jpg',
];

final List<String> aCat = ['Dance', 'Music', 'theatre'];
final List<String> subCat = ['Bhangra', 'Kathak', 'Western',];
final List<String> sName = ['kalā', 'paritrāṇa', 'aarogya', 'Krīḍā'];
final List<String> eName = [
  'performing arts',
  'self defense',
  'fitness',
  'sports'
];

int noReviews = 0;
int academyRate = 4;

class AcademyPage extends StatefulWidget {
  @override
  _AcademyPageState createState() => _AcademyPageState();
}

class _AcademyPageState extends State<AcademyPage> {
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
                color: grey1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Text('STAR ACADEMY',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25)),
                    ),
                    SizedBox(
                      width: 40,
                      child: FlatButton(
                        onPressed: () => about(context),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (int f = 0; f < 3; f++)
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 1),
                                  height: 5,
                                  width: 5,
                                  decoration: new BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle),
                                ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 210,
                child: Column(
                  children: <Widget>[
                    Image.network('${postImg[0]}', fit: BoxFit.cover),
                    SizedBox(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int f = 0; f < 3; f++)
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            height: 7,
                            width: 7,
                            decoration: new BoxDecoration(
                                color: Colors.grey.shade400,
                                shape: BoxShape.circle),
                          ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 50,
                color: Colors.white,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: 40,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {},
                          child: Icon(Icons.near_me,
                              color: Colors.black, size: 30),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: SizedBox(
                          width: 60,
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () => rating(context),
                            child: Text('$academyRate/5',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {},
                          child: Icon(Icons.chat_bubble,
                              color: Colors.black, size: 30),
                        ),
                      ),
                    ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int j = 0; j < 3; j++)
                    Row(
                      children: <Widget>[
                        Text(
                          '${subCat[j]}',
                          style: TextStyle(fontSize: 15),
                        ),
                        if (j != 2)
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
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                height: 40,
                color: grey1,
                child: Center(
                  child: Text('UPCOMING CLASSES',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
              ),
              for (int k = 0; k < 3; k++)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Card(
                    color: grey1,
                    child: Column(
                      children: <Widget>[
                        Container(color: grey1, height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                SizedBox(width: 10),
                                Text(
                                  'Bhangra',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 2),
                                  height: 5,
                                  width: 5,
                                  decoration: new BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  '3 months',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Container(color: grey1, height: 3),
                        Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('Instructor : ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.left),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('Time Slot :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.left),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('Fees/month : ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('Rakesh Jha',
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                      ),
                                      textAlign: TextAlign.left),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('16:00-17:00  M W F',
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                      ),
                                      textAlign: TextAlign.left),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text('Rs.3000/-',
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
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
                            onPressed: () {},
                            child: Text(
                              'Book',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
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
                color: grey1,
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
                              child: Text(
                                  'It\’s LOCKDOWNCE Time At Delhi Dance Academy: Has the ongoing lockdown started to take a toll on you? True that, losing on your body strength and agility while a whole good day oozes in a standstill is a definite no-no […]',
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
                color: grey1,
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
                      if (f < academyRate)
                        Icon(Icons.star, color: Colors.black, size: 18)
                      else
                        Icon(Icons.star_border, color: Colors.grey, size: 18)
                  ],
                ),
              ),
              Text('$noReviews students reviewed', textAlign: TextAlign.center),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text('$academyRate/5',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              Text('By Category',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                    itemCount: subCat.length,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 5),
                              child: Row(children: <Widget>[
                                Text('${subCat[index]}'),
                                Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    for (int f = 0; f < 5; f++)
                      if (f < academyRate)
                        Icon(Icons.star, color: Colors.black, size: 15)
                      else
                        Icon(Icons.star_border, color: Colors.grey, size: 15)
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text('$academyRate/5',
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

//           for (int k = 0; k < 5; k++)
//             Container(
//               margin: EdgeInsets.symmetric(vertical:5),
//               height:70,
//               color:Colors.white,
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     crossAxisAlignment:CrossAxisAlignment.center,
//                     children: <Widget>[
//                        Container(
//                          margin: EdgeInsets.symmetric(horizontal:10),
//                          height:70,
//                          width:70,
//                          child:Image.network('${postImg[k]}', fit:BoxFit.cover),),
//                     Container(
//                       height:70,
//                       child:Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment:CrossAxisAlignment.start,
//                       children:<Widget>[
//                     Padding (
//                       padding: EdgeInsets.only(bottom:2),
//                       child:Text('Star Academy',
//                   style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children:<Widget>[
//                     for(int j = 0; j < 3; j++)
//                   Row(
//                   children: <Widget>[
//                     Text(
//                       '${subCat[j]}',
//                       style:
//                           TextStyle(fontSize: 12),
//                     ),
//                     if(j!=2)
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 2),
//                       height: 3,
//                       width: 3,
//                       decoration: new BoxDecoration(
//                           color: Colors.black, shape: BoxShape.circle),
//                     ),
//                     SizedBox(width:5),
//                   ],
//                 ),],),
//                       Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         for (int s = 0; s < 5; s++)
//                           Icon(Icons.star, color: Colors.black, size:15),
//                       ],),],),)
//                 ],
//               ),
//                   ],),
//             ),
