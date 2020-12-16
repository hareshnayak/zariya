import 'package:flutter/material.dart';


final Color grey1 = Colors.grey.shade300;

class ChatPage extends StatefulWidget {  

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: new IconThemeData(color: Colors.black),
            title: Center(
              child: Text(
                'zariya',
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
                      child: Icon(Icons.home, color: Colors.black)))
            ],
          ),
        ),
      body: Container(
//       margin: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              padding: EdgeInsets.fromLTRB(10,10,10,5),
              child: Text('SEARCH',
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
              child: Text('Courses',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15))),
//           StreamBuilder<QuerySnapshot>(
//             stream: Firestore.instance.collection('academies').snapshots(),
//             builder: (context, snapshot){
//               if(!snapshot.hasData)
//                 return Center(child: CircularProgressIndicator());
//               else if (snapshot.data.documents == null || snapshot.data.documents.length == 0)
//                 return Center(child: Text('Nothing here!!!'));
//               return chatItemsList(context, snapshot.data.documents);
//             },          
//           ),
          _buildCourse(),
        ],
      ),
    ));
  }
}

  Widget _buildCourse(dynamic course){
    List<String> keys = [], values = [];
    course.forEach((key, value){
      if (key == 'start')
      {
        keys.add('Start Date');
        values.add(getDateString(value.toDate()));
      } else if (key == 'end') {
        keys.add('End Date');
        values.add(getDateString(value.toDate()));
//      } else if (key == 'title') {
//        keys.insert(0, 'Title');
//        values.insert(0, value);
//      } else if (key == 'seats') {
//        keys.add('Seats');
//        values.add('$value');
//      } else if (key == 'enrolled') {
//        keys.add('Enrolled');
//        values.add('$value');
      }
    });
    return Padding(
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
                      course['category'],
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
                      course['title'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    SizedBox(width: 5),
                    Text(
                      course['duration'],
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
                    for(int i = 0; i < keys.length; i++)
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text('${keys[i]}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    for(int i = 0; i < values.length; i++)
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(': ${values[i]}',
                          style: TextStyle(
                            color: Colors.black,
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
                onPressed: () {
                  print(course);
                  print(widget.data.documentID);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Book(course:course, email: widget.email, academyEmail: widget.data.documentID, academyLogo: widget.data['logo']['url'])));
                },
                child: Text(
                  'BOOK',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:20,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
