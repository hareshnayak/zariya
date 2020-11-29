import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zariya/academy.dart';
import 'package:zariya/resources/strings.dart';

final Color grey1 = Colors.grey.shade300;

class Academies extends StatelessWidget {

  Academies({this.category, this.email});

  final String category, email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(45.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
//          leading: SizedBox(
//              width: 60,
//              height: 30,
//              child: FlatButton(
//                  padding: EdgeInsets.all(0),
//                  onPressed: () {},
//                  child: Icon(Icons.menu, color: Colors.black))),
//             SizedBox(
//                   width: 60,
//                 height: 30,
//                   child: FlatButton(
//                 padding: EdgeInsets.all(0),
//                       onPressed: () {},: Colors.black))),
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
                    child: Icon(Icons.search, color: Colors.black)))
          ],
        ),
      ),
      body: AcademiesPage(category: category, email: email),
    );
  }
}

class AcademiesPage extends StatefulWidget {

  AcademiesPage({this.category, this.email});

  final String category, email;

  @override
  _AcademiesPageState createState() => _AcademiesPageState();
}

class _AcademiesPageState extends State<AcademiesPage> {

  List<dynamic> academies;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
//       margin: EdgeInsets.all(5),
      child: ListView(
        children: <Widget>[
          Container(
            height: 300,
            child: Image.network(defaultImageIcon, fit: BoxFit.cover),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 40,
            color: grey1,
            child: Center(
              child: Text((widget.category != null)?'${widget.category} ACADEMIES':'ACADEMIES',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
            ),
          ),
          Container(
            child:StreamBuilder(
            stream:
            (widget.category == null)
              ? Firestore.instance.collection('academies')
                .orderBy('rating', descending: true).snapshots()
              : Firestore.instance.collection('academies')
                .where('keywords', arrayContainsAny: [widget.category])
                .orderBy('rating', descending: true).snapshots(),
            builder: (context, snapshot){
              if(!snapshot.hasData)
                return Center(child:CircularProgressIndicator());
              return _buildAcademyList(context, snapshot.data.documents);
            },
          ),
          ),
        ],
      ),
    );
  }

  Widget _buildAcademyList(BuildContext context, List<dynamic> dataList)
  {
    return ListView.builder(
        itemCount: dataList.length,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, item){
          return _buildAcademyItem(context, dataList[item]);
        }
    );
  }

  Widget _buildAcademyItem(BuildContext context, dynamic data)
  {
    List<String> subCategories = [];
    data['subCategories'].forEach((key, value){
      subCategories.add(key);
    });
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      height: 70,
      color: Colors.white,
      child: FlatButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>Academy(data:data, email: widget.email,)));
        },
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 70,
                  width: 70,
                  child:
                  Image.network(data['logo']['url'] ?? defaultImageIcon, fit: BoxFit.cover),
                ),
                Container(
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: Text(
                          data['name'],
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          for (int j = 0; j < subCategories.length ?? 0; j++)
                            Row(
                              children: <Widget>[
                                Text(
                                  subCategories[j],
                                  style: TextStyle(fontSize: 12),
                                ),
                                if (j != 2)
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 2),
                                    height: 3,
                                    width: 3,
                                    decoration: new BoxDecoration(
                                        color: Colors.black,
                                        shape: BoxShape.circle),
                                  ),
                                SizedBox(width: 5),
                              ],
                            ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          for (int s = 0; s < data['rating'] ?? 0; s++)
                            Icon(Icons.star,
                                color: Colors.black, size: 15),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}
