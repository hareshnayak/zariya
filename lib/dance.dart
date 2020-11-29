import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zariya/navDrawer.dart';
import 'package:zariya/resources/strings.dart' as Strings;

final Color grey1 = Colors.grey.shade300;

class Dance extends StatelessWidget {

  Dance({this.category});

  final String category;
//  email, name, photoUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
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
                      onPressed: null,
                      child: Icon(Icons.search, color: Colors.black)))
            ],
          ),
        ),
        body: DancePage(category: category,),
      );
  }
}

class DancePage extends StatefulWidget {

  DancePage({this.category});

  final String category;

  @override
  _DancePageState createState() => _DancePageState();
}

class _DancePageState extends State<DancePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
//       margin: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Container(
//                 width: 70,
              height: 50,
              decoration: BoxDecoration(
                color: grey1,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              padding: EdgeInsets.symmetric(horizontal: 5),
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: Text('#${widget.category}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.black)),
              )),
          FutureBuilder(
            future: Firestore.instance.collection('community').document(widget.category).get(),
            builder: (context, snapshot){
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              return Container(
                height: MediaQuery.of(context).size.height - 125,
                child: ListView.builder(
                  itemCount: snapshot.data['posts'].length,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return postCard(context, snapshot.data['posts'][i]);
                }),
              );
            }
          ),
          ],        
      ),
    );
  }

  Widget postCard(BuildContext context, dynamic data)
  {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(children: <Widget>[
        Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 20,
            child: Row(children: <Widget>[
              CircleAvatar(
                  backgroundImage: NetworkImage(data['photoUrl'] ?? Strings.defaultImageIcon)),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(data['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        Text(data['email'],
                            style: TextStyle(color: Colors.grey))
                      ])),
              Spacer(),
              Container(
                height: 30,
                width: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: FlatButton(
                  padding: EdgeInsets.symmetric(horizontal:5),
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.add, color: Colors.blue),
                      Text(
                        'Follow',
                        style: TextStyle(color: Colors.blue),),
                    ],),
                ),
              ),
            ])),
        Stack(children: <Widget>[
          FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: () {},
            child: Container(
              height: 250,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: grey1,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  image: new DecorationImage(
                      image: NetworkImage(
                          data['image'] ?? 'https://cdn.pixabay.com/photo/2016/10/21/14/50/plouzane-1758197__340.jpg'),
                      fit: BoxFit.cover)),
            ),
          ),
          Positioned(
            bottom: 10,
            child: FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {},
              child: Container(
                width: MediaQuery.of(context).size.width - 100,
//                height: 20,
                padding: EdgeInsets.symmetric(horizontal: 5),
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Text(data['text'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white)),
              ),
            ),
          ),
        ]),
      ]),
    );
  }

}
