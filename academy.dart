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
        floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: Icon(Icons.people),
            mini: true,
            backgroundColor: Colors.green),
        body: AcademiesPage(),
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
final List<String> subCat = ['Bhangra', 'Kathak', 'Western'];
final List<String> sName = ['kalā', 'paritrāṇa', 'aarogya', 'Krīḍā'];
final List<String> eName = [
  'performing arts',
  'self defense',
  'fitness',
  'sports'
];

class AcademiesPage extends StatefulWidget {
  @override
  _AcademiesPageState createState() => _AcademiesPageState();
}

class _AcademiesPageState extends State<AcademiesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
//       margin: EdgeInsets.all(5),
      child: ListView(
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
                ),
                SizedBox(
                  width: 40,
                  child: FlatButton(
                    onPressed: () {},
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int f = 0; f < 3; f++)
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 2),
                              height: 5,
                              width: 5,
                              decoration: new BoxDecoration(
                                  color: Colors.black, shape: BoxShape.circle),
                            ),
                        ]),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 210,
            child: Column(children:<Widget>[
              Image.network('${postImg[0]}', fit: BoxFit.cover),
              SizedBox(height:2),
            Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int f = 0; f < 3; f++)
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 2),
                              height: 7,
                              width: 7,
                              decoration: new BoxDecoration(
                                  color: Colors.grey.shade400, shape: BoxShape.circle),
                            ),],)],),
          ),
          Container(
            height: 50,
            color: Colors.white,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.near_me, color: Colors.black, size: 30),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text('4/5',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30)),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon:
                        Icon(Icons.chat_bubble, color: Colors.black, size: 30),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            ),
          ),
          for (int k = 0; k < 3; k++)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Card(
                        color: grey1,
                        child: Column(                         
                          children: <Widget>[
                            Container(color: grey1,height:5),
                            Row(          
                              mainAxisAlignment:MainAxisAlignment.start,
                    children:<Widget>[                    
                  Row(                                       
                  children: <Widget>[
                    SizedBox(width:10),
                    Text(
                     'Bhangra',
                      style:
                          TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
                    ),                    
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      height: 5,
                      width: 5,
                      decoration: new BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle),
                    ),
                    SizedBox(width:5),
                    Text(
                     '3 months',
                      style:
                          TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
                    ), 
                  ],
                ),],),
                            Container(color: grey1,height:3),
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
      ),
    );
  }
}
