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
//         floatingActionButton: FloatingActionButton(
//             onPressed: () {},
//             child: Icon(Icons.people),
//             mini: true,
//             backgroundColor: Colors.green),
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
          Stack(children: <Widget>[
            FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              child: Container(
                height: 350,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: grey1,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    image: new DecorationImage(
                        image: NetworkImage(
                            'https://cdn.pixabay.com/photo/2016/10/21/14/50/plouzane-1758197__340.jpg'),
                        fit: BoxFit.cover)),
              ),
            ),
            Positioned(
              bottom: 50,
              child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed:(){},
                child:Container(
                width: 150,
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 5),
                margin: EdgeInsets.symmetric(horizontal: 10),                
                child: Text('#Dance',
                      style: TextStyle(fontWeight:FontWeight.bold,fontSize:30,color: Colors.white)),                
              ),),
            ),
            Positioned(
              bottom: 10,
              child: Container(
                width: MediaQuery.of(context).size.width - 20,
                height: 40,
                padding: EdgeInsets.all(0),
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15)),
                ),
                child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('number of views',
                              style: TextStyle(color: Colors.white)),
                          Icon(Icons.visibility, color: Colors.white),
                        ])),
              ),
            )
          ]),          
            Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(10),
                  child: 
                      Text(
                        'New Posts',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),                     
                  ),
               for (int k = 0; k < 3; k++)
                Padding(
                  padding: EdgeInsets.symmetric(vertical:10),
                  child:Row(
                 mainAxisAlignment:MainAxisAlignment.center,
                 children:<Widget>[
                 for (int k = 0; k < 3; k++)
                 FlatButton(
                            padding: EdgeInsets.symmetric(horizontal:10),
                            onPressed: () {},
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    image: new DecorationImage(
                                    image:NetworkImage('${arrived[1]}'),fit: BoxFit.cover),
                                   borderRadius: BorderRadius.all(Radius.circular(15),),
                                    color: grey1,
                                  ),
                                ),                                
                              ],
                            ),
                          ) ]))             
            ]),
        ],
      ),
    );
  }
}
