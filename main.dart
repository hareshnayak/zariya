import 'package:flutter/material.dart';

final Color grey1 = Colors.grey.shade400;

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
                    child: Icon(Icons.menu, color: Colors.black))),
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
        body: HomePage(),
      ),
    );
  }
}

final List<String> postImg = [
  'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__340.jpg',
  'https://cdn.pixabay.com/photo/2017/08/30/01/05/milky-way-2695569__340.jpg',
  'https://cdn.pixabay.com/photo/2015/03/17/14/05/sparkler-677774__340.jpg',
  'https://cdn.pixabay.com/photo/2017/12/10/20/56/feather-3010848__340.jpg',
  'https://cdn.pixabay.com/photo/2016/11/14/04/45/elephant-1822636__340.jpg'
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
      child: ListView(
        children: <Widget>[
          Container(height: 250, child: Center(child: Text('Corousel'))),
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
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 3,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(                       
                                  width: 130,
                                  height: 100,
//                          child:Image.network('${postImg[index]}',
//                             fit: BoxFit.cover),
                                  decoration: BoxDecoration(
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
    );
  }
}
