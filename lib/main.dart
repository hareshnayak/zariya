import 'package:flutter/material.dart';
import 'package:zariya/academies.dart';
import 'package:zariya/chat.dart';
import 'package:zariya/community.dart';
import 'package:zariya/navDrawer.dart';
import 'package:zariya/profile.dart';

final Color grey1 = Colors.grey.shade300;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
//        primarySwatch: Colors.white,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: NavDrawer(),
        drawerScrimColor: Colors.black54,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: new IconThemeData(color: Colors.black),
//            leading: SizedBox(
//                width: 60,
//                height: 30,
//                child: FlatButton(
//                    padding: EdgeInsets.all(0),
//                    onPressed: () {
//                      Scaffold.of(context).openDrawer();
//                    },
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
         currentIndex: _selectedIndex,
         selectedItemColor: Colors.amber[800],
         onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
         },
          ),
        ),
//        floatingActionButton: FloatingActionButton(
//            onPressed: () {
//              Navigator.push(
//                  context,
//                  MaterialPageRoute(builder:
//                      (BuildContext context) => Community()));
//            },
//            child: Icon(Icons.people),
//            backgroundColor: Colors.green),
        body: (_selectedIndex == 0)
          ? ProfilePage()
          : (_selectedIndex == 1)
            ? HomePage()
            : ChatPage()
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
      child: Stack(
        children: [
          ListView(
            children: <Widget>[
              Container(height: 250,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    image: new DecorationImage(
                      image: NetworkImage('${postImg[1]}',),
                        fit: BoxFit.cover,
                    ),
                  ),
                  ),
              for (int k = 0; k < 4; k++)
                Column(children: <Widget>[
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 20),
                          Text(
                            '${sName[k]}',
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
                            '${eName[k]}',
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
                        itemCount: 3,
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
                                                  '${postImg[index]}'),
                                              fit: BoxFit.cover),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                        color: grey1,
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
                                              child: Text('${aCat[index]}',
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
                ]),
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
      ),
    );
  }
}
