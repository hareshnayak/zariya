import 'package:flutter/material.dart';
import 'package:zariya/loginTeacher.dart';
import 'package:zariya/resources/strings.dart';
import 'package:zariya/services/authentication.dart';
import 'package:zariya/main.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, @required this.auth, @required this.handleSignIn})
      : super(key: key);

  final BaseAuth auth;
  final Function handleSignIn;

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage(loginBgImage), fit: BoxFit.cover)),
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () {
                print('signIn Tapped');
                widget.handleSignIn(context);
                print('after signIn');
              },
              child: new Image.asset('assets/images/signinGoogle.png'),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
                child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => LoginTeacher(
                      auth: widget.auth,
                    ),
                  ),
                );
              },
              child: Text(
                "Login as an Instructor",
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    fontFamily: 'Comfortaa'),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
