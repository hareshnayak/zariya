import 'package:flutter/material.dart';

final Color grey1 = Colors.grey.shade300;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Container(
              padding: EdgeInsets.all(30),
              child: ListView(
                children: <Widget>[
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 100),
                  Container(
//          width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                        color: grey1,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Email'),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        color: grey1,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Password'),
                      ),
                    ),
                  ),
                  Container(
//                 width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(vertical:20),
                    child: FlatButton(
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      color: Colors.black,
                      onPressed: () {},
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                  Container(height: 1, color: Colors.black),
                  Padding(
                    padding:  EdgeInsets.symmetric(vertical:10),
                    child:Text('Do not have an account?'),),
                  Container(
//                 width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(vertical:10),
                    child: FlatButton(
                      padding: EdgeInsets.all(10),
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15)),
                      color: Colors.black,
                      onPressed: () {},
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
