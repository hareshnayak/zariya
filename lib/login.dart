import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zariya/resources/colors.dart';
import 'package:zariya/index.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SharedPreferences prefs;

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

    prefs = await SharedPreferences.getInstance();

    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IndexPage(currentUserId: prefs.getString('id'))),
      );
    }

    this.setState(() {
      isLoading = false;
    });
  }

  Future<Null> handleSignIn() async {
    prefs = await SharedPreferences.getInstance();

    this.setState(() {
      isLoading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;

    if (firebaseUser != null) {
      try{
        await Firestore.instance.collection('users').where('email', isEqualTo: firebaseUser.email).getDocuments().then((snapshot) async {
          final List<DocumentSnapshot> documents = snapshot.documents;
          if (documents.length == 0) {
            print('new User present');
            // Update data to server if new user
            Firestore.instance.collection('users').document(firebaseUser.email).setData({
              'name': firebaseUser.displayName,
              'photoUrl': firebaseUser.photoUrl,
              'email': firebaseUser.email,
              'coupons': [],
              'reservations': [],
            }).whenComplete(() => print('Data Written to firebase!'));
            // Write data to local
            currentUser = firebaseUser;
            await prefs.setString('email', currentUser.email);
            await prefs.setString('name', currentUser.displayName);
            await prefs.setString('photoUrl', currentUser.photoUrl);
          } else {
            // Write data to local
            print('email present in firebase!');
            await prefs.setString('email', documents[0]['email']);
            await prefs.setString('name', documents[0]['name']);
            await prefs.setString('photoUrl', documents[0]['photoUrl']);
          }
          print("Sign in success");
          this.setState(() {
            isLoading = false;
          });
          Navigator.push(context, MaterialPageRoute(builder: (context) => IndexPage(currentUserId: firebaseUser.email)));
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
      body: Container(
        decoration: BoxDecoration(
            image: new DecorationImage(
                image: new NetworkImage(
                    'https://cdn.pixabay.com/photo/2018/11/25/12/59/silhouette-3837379__340.png'),
                fit: BoxFit.fitWidth)),
        padding: EdgeInsets.all(30),
        child: ListView(
          children: <Widget>[
            Text(
              'Zariya',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                  color: Colors.black),
            ),
            Text(
              'Login',
              style: TextStyle(
                  fontSize: 20, fontFamily: 'Inter', color: Colors.black),
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
              margin: EdgeInsets.symmetric(vertical: 20),
              child: FlatButton(
                padding: EdgeInsets.all(10),
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15)),
                color: grey1,
                onPressed: () {
                  handleSignIn();
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'Inter'),
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
//                  ),
          ],
        ),
      ),
    );
  }
}
