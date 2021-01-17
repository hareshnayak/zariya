import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zariya/index.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zariya/loginTeacher.dart';
import 'package:zariya/resources/strings.dart';
import 'package:zariya/services/authentication.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final BaseAuth auth = new Auth();

//  SharedPreferences prefs;

  bool isLoading = false;
  bool isLoggedIn = false;
  FirebaseUser currentUser;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    this.setState(() {
      isLoading = true;
    });

    await auth.getCurrentUser().then((value) {
      if (value != null) {
        if (value.displayName == null) {
          this.setState(() {
            isLoading = false;
          });
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => LoginTeacher(
                        auth: auth,
                      )));
        }
      }
    });
//    prefs = await SharedPreferences.getInstance();

    await googleSignIn.isSignedIn().then((value) async {
      setState(() {
        isLoggedIn = value;
      });
      if (isLoggedIn == true) {
        currentUser = await firebaseAuth.currentUser().whenComplete(() async {
          String followId = 'none';
          (currentUser != null)
              ? await Firestore.instance
                  .collection('users')
                  .document(currentUser.email)
                  .get()
                  .then((data) {
                  followId = data['followId'] ?? 'none';
                }).whenComplete(() {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IndexPage(
                            currentUser: currentUser, followId: followId)),
                  );
                })
              : Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => IndexPage(
                          currentUser: currentUser, followId: 'none')),
                );
        });
      }
    });

    this.setState(() {
      isLoading = false;
    });
  }

  Future<Null> handleSignIn() async {
//    prefs = await SharedPreferences.getInstance();

    this.setState(() {
      isLoading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;

    if (firebaseUser != null) {
      try {
        await Firestore.instance
            .collection('users')
            .document(firebaseUser.email)
            .get()
            .then((doc) async {
          if (!doc.exists) {
            print('new User present');
            // Update data to server if new user
            Firestore.instance
                .collection('users')
                .document(firebaseUser.email)
                .setData({
              'name': firebaseUser.displayName,
              'photoUrl': firebaseUser.photoUrl,
              'email': firebaseUser.email,
              'coupons': [],
              'reservations': [],
            }).whenComplete(() {
              print('Data Written to firebase!');
            });
          }
        }).whenComplete(() {
          print("Sign in success");
          this.setState(() {
            isLoading = false;
          });
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => IndexPage(currentUser: firebaseUser)));
        });
      } catch (err) {
        print(err);
      }
    } else {
      print("Sign in fail");
      this.setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (isLoading)
          ? Center(child: CircularProgressIndicator())
          : Container(
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
                      handleSignIn();
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
                          builder: (BuildContext context) =>
                              LoginTeacher(auth: new Auth()),
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
