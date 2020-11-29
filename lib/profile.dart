import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:zariya/resources/strings.dart' as Strings;
final Color grey1 = Colors.grey.shade300;

class ProfilePage extends StatefulWidget {

  ProfilePage({this.email});

  final String email;

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
//       margin: EdgeInsets.all(5),
      child: FutureBuilder<DocumentSnapshot>(
        future: Firestore.instance.collection('users').document(widget.email).get(),
        builder: (context, snapshot){
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return profile(context, snapshot.data);
        },
      ),
    );
  }

  Widget profile(context, data)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(10),
            child: Text('MY ACCOUNT',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.left,)),
        Container(height: 1, color: grey1),
        Row(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(
                  data['photoUrl'] ?? Strings.defaultImageIcon,
                )),
          ),
          SizedBox(width: 5),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                data['name'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(data['email'], style: TextStyle(color: Colors.grey)),
            ],
          ),
          Spacer(),
          SizedBox(
              width: 50,
              child: FlatButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {},
                  child: Icon(Icons.edit, color: Colors.blue)))
        ]),
        DefaultTabController(
          length: 2,
          child: Container(
            height: MediaQuery.of(context).size.height - 260,
            child: Column(
              children: <Widget>[
                TabBar(
                  tabs: <Widget>[
                    Tab(
                        child: Text('Reservations',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                    Tab(
                        child: Text('Coupons',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black)))
                  ],
                ),
                Expanded(
                    child: TabBarView(children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
//                        Container(height:50,
//                          padding: EdgeInsets.all(10),
//                          child: Text('Reservation Details',
//                            style: TextStyle(fontWeight:FontWeight.bold, fontSize: 20))),
                            Expanded(
                                child: ListView.builder(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: data['reservations'].length,
                                    itemBuilder: (BuildContext context, int i) {
                                      if (data['reservations'].length == 0)
                                        return Text('No reservations till now!!!');
                                      return reservationCard(context, data['reservations'][i]);
                                    })),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
//                                   Container(height:50,
//                                             padding: EdgeInsets.all(10),                                            child: Text('Reservation Details', style:TextStyle(fontWeight:FontWeight.bold, fontSize: 20))),
                            Expanded(
                                child: ListView.builder(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: data['coupons'].length,
                                    itemBuilder: (BuildContext context, int i) {
                                      if (data['coupons'].length == 0)
                                        return Text('No coupons till now!!!');
                                      return couponCard(context, data['coupons'][i]);
                                    })),
                          ],
                        ),
                      ),
                    ]))
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget reservationCard(BuildContext context, dynamic data)
  {
    return Padding(
      padding:
      EdgeInsets.symmetric(vertical: 5),
      child: Card(
        child: Column(
          children: <Widget>[
            Container(height: 5),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(width: 10),
                    Text(
                      data['title'],
                      style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          fontSize: 17),
                    ),
                    Container(
                      margin:
                      EdgeInsets.symmetric(
                          horizontal: 2),
                      height: 5,
                      width: 5,
                      decoration:
                      new BoxDecoration(
                          color:
                          Colors.black,
                          shape: BoxShape
                              .circle),
                    ),
                    SizedBox(width: 5),
                    Text(
                      data['duration'],
                      style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
              ],
            ),
            Container(height: 3),
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10),
                      child: Text('Time Slot',
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .bold),
                          textAlign:
                          TextAlign.left),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10),
                      child: Text(
                          'Fees/month',
                          style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
                          ),
                          textAlign:
                          TextAlign.left),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10),
                      child: Text(
                          ': ${data['timing']}',
                          style: TextStyle(
                            color: Colors
                                .grey.shade500,
                          ),
                          textAlign:
                          TextAlign.left),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10),
                      child: Text(': ${data['fees']}',
                          style: TextStyle(
                            color: Colors
                                .grey.shade500,
                          ),
                          textAlign:
                          TextAlign.left),
                    ),
                  ],
                ),
              ],
            ),
            Container(
//                           margin: EdgeInsets.all(15),
              margin: EdgeInsets.only(top: 15),
              height: 30,
              width: MediaQuery.of(context)
                  .size
                  .width,
              color: Colors.black,
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  'Drop',
                  style: TextStyle(
                      fontWeight:
                      FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget couponCard(BuildContext context, dynamic data)
  {
    return Padding(
      padding:
      EdgeInsets.symmetric(vertical: 5),
      child: Card(
        child: Column(
          children: <Widget>[
            Container(height: 5),
            Row(
              mainAxisAlignment:
              MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(width: 10),
                    Text(
                      data['title'],
                      style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          fontSize: 17),
                    ),
                    Container(
                      margin:
                      EdgeInsets.symmetric(
                          horizontal: 2),
                      height: 5,
                      width: 5,
                      decoration:
                      new BoxDecoration(
                          color:
                          Colors.black,
                          shape: BoxShape
                              .circle),
                    ),
                    SizedBox(width: 5),
                    Text(
                      data['duration'],
                      style: TextStyle(
                          fontWeight:
                          FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
              ],
            ),
            Container(height: 3),
            Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10),
                      child: Text(
                          'Instructor : ',
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .bold),
                          textAlign:
                          TextAlign.left),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10),
                      child: Text('Time Slot :',
                          style: TextStyle(
                              fontWeight:
                              FontWeight
                                  .bold),
                          textAlign:
                          TextAlign.left),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10),
                      child: Text('Discount : ',
                          style: TextStyle(
                            fontWeight:
                            FontWeight.bold,
                          ),
                          textAlign:
                          TextAlign.left),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10),
                      child: Text(data['instructor'],
                          style: TextStyle(
                            color: Colors
                                .grey.shade500,
                          ),
                          textAlign:
                          TextAlign.left),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10),
                      child: Text(
                          data['timing'],
                          style: TextStyle(
                            color: Colors
                                .grey.shade500,
                          ),
                          textAlign:
                          TextAlign.left),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10),
                      child: Text(data['discount'],
                          style: TextStyle(
                            color: Colors
                                .grey.shade500,
                          ),
                          textAlign:
                          TextAlign.left),
                    ),
                  ],
                ),
              ],
            ),
            Container(
//                           margin: EdgeInsets.all(15),
              margin: EdgeInsets.only(top: 15),
              height: 30,
              width: MediaQuery.of(context)
                  .size
                  .width,
              color: Colors.green,
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  'Avail Coupon',
                  style: TextStyle(
                      fontWeight:
                      FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
