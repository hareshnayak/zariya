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
            height: 300,
            child: Image.network('${postImg[0]}', fit: BoxFit.cover),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 40,
            color: grey1,
            child: Center(
              child: Text('DANCE ACADEMIES',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            ),
          ),
          for (int k = 0; k < 5; k++)
            Container(
              margin: EdgeInsets.symmetric(vertical:5),
              height:70,
              color:Colors.white,
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment:CrossAxisAlignment.center,
                    children: <Widget>[
                       Container(
                         margin: EdgeInsets.symmetric(horizontal:10),
                         height:70,
                         width:70,
                         child:Image.network('${postImg[k]}', fit:BoxFit.cover),),
                    Container(
                      height:70,
                      child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children:<Widget>[
                    Padding (
                      padding: EdgeInsets.only(bottom:2),
                      child:Text('Star Academy',
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),),                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:<Widget>[
                    for(int j = 0; j < 3; j++)                  
                  Row(                    
                  children: <Widget>[                    
                    Text(
                      '${subCat[j]}',
                      style:
                          TextStyle(fontSize: 12),
                    ),
                    if(j!=2)
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      height: 3,
                      width: 3,
                      decoration: new BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle),
                    ),
                    SizedBox(width:5),                    
                  ],
                ),],),                    
                      Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        for (int s = 0; s < 5; s++)
                          Icon(Icons.star, color: Colors.black, size:15),                                               
                      ],),],),)
                ],
              ),
                  ],),
            ),
        ],
      ),
    );
  }
}
