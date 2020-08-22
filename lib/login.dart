import 'package:flutter/material.dart';

final Color grey1 = Colors.grey.shade300;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:Scaffold(
            body: Container(
              decoration: BoxDecoration(
              image: new DecorationImage(
                  image: new NetworkImage(
                  'https://cdn.pixabay.com/photo/2018/11/25/12/59/silhouette-3837379__340.png'),fit: BoxFit.fitWidth)),
              padding: EdgeInsets.all(30),
              child: ListView(
                children: <Widget>[
                  Text(
                    'Zariya',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'Inter', color: Colors.black),),
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 20, fontFamily: 'Inter', color: Colors.black),
                  ),
                  SizedBox(height: 155),
                  Container(
                    height: 200,
//                   decoration:BoxDecoration(
//                     image: new DecorationImage(
//                   image: new NetworkImage(
//                   'https://cdn.pixabay.com/photo/2016/11/29/06/20/blonde-1867768__340.jpg'),fit: BoxFit.cover))),
                    ),
                  Container(
//                 width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(vertical:20),
                    child: FlatButton(
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      color: grey1,
                      onPressed: () {},
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20, 
                            fontFamily: 'Inter'
                        ),
                      ),
                    ),
                  ),
//                   Container(height: 1, color: Colors.black),
//                   Padding(
//                     padding:  EdgeInsets.symmetric(vertical:10),
//                     child:Text('Do not have an account?'),),
//                   Container(
// //                 width: MediaQuery.of(context).size.width,
//                     margin: EdgeInsets.symmetric(vertical:10),
//                     child: FlatButton(
//                       padding: EdgeInsets.all(10),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: new BorderRadius.circular(15)),
//                       color: Colors.black,
//                       onPressed: () {},
//                       child: Text(
//                         'Sign Up',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 20),
//                       ),
//                     ),
//                   ),
                  ),
                ],
              ),
            )));
  }
}
