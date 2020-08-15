import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final Color grey1 = Colors.grey.shade300;

//class Chat extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: PreferredSize(
//          preferredSize: Size.fromHeight(45.0),
//          child: AppBar(
//            backgroundColor: Colors.transparent,
//            leading: SizedBox(
//                width: 60,
//                height: 30,
//                child: FlatButton(
//                    padding: EdgeInsets.all(0),
//                    onPressed: () {},
//                    child: Icon(Icons.menu, color: Colors.black))),
////             SizedBox(
////                   width: 60,
////                 height: 30,
////                   child: FlatButton(
////                 padding: EdgeInsets.all(0),
////                       onPressed: () {},: Colors.black))),
//            title: Center(
//              child: Text(
//                'zariya',
//                style: TextStyle(
//                    fontWeight: FontWeight.bold,
//                    fontSize: 25,
//                    color: Colors.black),
//              ),
//            ),
//            elevation: 0,
//            actions: <Widget>[
//              SizedBox(
//                  width: 60,
//                  height: 30,
//                  child: FlatButton(
//                      padding: EdgeInsets.all(0),
//                      onPressed: () {},
//                      child: Icon(Icons.home, color: Colors.black))),
//            ],
//          ),
//        ),
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
//        floatingActionButton: FloatingActionButton(
//            onPressed: () {},
//            child: Icon(Icons.people),
//            mini: true,
//            backgroundColor: Colors.green),
//        body: ChatPage(),
//      );
//  }
//}

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
final List<String> sName = ['kala', 'paritra?a', 'aarogya', 'Kri?a'];
final List<String> eName = [
  'performing arts',
  'self defense',
  'fitness',
  'sports'
];

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
//       margin: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(10,10,10,5),
              child: Text('MESSENGER',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.left,)),
//           Container(height: 1, color: grey1),
          Stack(children:<Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(10,5,10,10),
                padding: EdgeInsets.symmetric(horizontal:10),
                decoration: BoxDecoration(
                    color: grey1,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child:
                TextField(
                    decoration:InputDecoration(
                        hintText:'Search',
                        border: InputBorder.none))),
            Positioned(
              right:10,
              top: -5,
              child:Container(
                margin: EdgeInsets.all(10),
//             padding: EdgeInsets.symmetric(horizontal:10),
                width: 50,
                height: 50,
                child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  child: Icon(Icons.search, color: Colors.black),),),),
          ]),
          Container(
              padding: EdgeInsets.fromLTRB(10,5,10,10),
              child: Text('Chats',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (BuildContext context, int i ){
              return Container(
                  height:70,
                  padding: EdgeInsets.all(10),
                  child: Row(children:<Widget>[
                    Padding(
                      padding: EdgeInsets.only(right:10),
                      child: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSBUXESNi9dDwsxnZoDpAktF-piO2mU778bEQ&usqp=CAU',
                          )),
                    ),
                    Column(children:<Widget>[
                      Text('Star Academy ',
                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                      Container(
                          padding: EdgeInsets.only(top:5, right:5),
                          child: Text('See the schedule',
                              style: TextStyle(fontSize: 15))),
                    ]),
                    Spacer(),
                    Column(children:<Widget>[
                      Text('10:09 am',),
                      Container(
                        margin: EdgeInsets.only(top:15),
                        height: 10,
                        width: 10,
                        decoration: new BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle),
                      ),
                    ]),
                  ]));
            }),
          ),


        ],
      ),
    );
  }
}
