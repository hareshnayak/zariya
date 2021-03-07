import 'package:flutter/material.dart';
import 'package:zariya/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zariya/main.dart';
import 'package:zariya/login.dart';
import 'package:zariya/index.dart';
import 'package:zariya/teacher.dart';

class RootPage extends StatefulWidget {
  RootPage({@required this.auth});

  final BaseAuth auth;

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

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
    print('running isSignedIn');
    this.setState(() {
      isLoading = true;
    });

    await widget.auth.getCurrentUser().then((value) async {
      print('getting user!');
      if (value != null) {
        print('value is not null!');
        if (value.displayName == null || value.displayName.isEmpty) {
          this.setState(() {
            isLoading = false;
          });
          print('signed in as a teacher!');
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => TeacherIndexPage(
                        signOut: widget.auth.signOut,
                        currentUser: value,
                      )));
        } else {
          print('not a teacher');
          await googleSignIn.isSignedIn().then((value) async {
            setState(() {
              isLoggedIn = value;
            });
            if (isLoggedIn == true) {
              print('signedin a user!');
              currentUser =
                  await firebaseAuth.currentUser().whenComplete(() async {
                String followId = 'none';
                (currentUser != null)
                    ? await Firestore.instance
                        .collection('users')
                        .document(currentUser.email)
                        .get()
                        .then((data) {
                        followId = data['followId'] ?? 'none';
                      }).whenComplete(() {
                        this.setState(() {
                          isLoading = false;
                        });
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => IndexPage(
                                    currentUser: currentUser,
                                    followId: followId,
                                    handleSignOut: handleSignOut,
                                  )),
                        );
                      })
                    : Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IndexPage(
                                  currentUser: currentUser,
                                  followId: 'none',
                                  handleSignOut: handleSignOut,
                                )),
                      );
              });
            } else {
              print('no user signed in !!');
              // Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => LoginScreen(
              //           auth: widget.auth,
              //           handleSignIn: handleSignIn,
              //         )));
            }
          });
        }
      } else {
        print('no user is logged in!');
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => LoginScreen(
                      auth: widget.auth,
                      handleSignIn: handleSignIn,
                    )));
      }
    });

    this.setState(() {
      isLoading = false;
      print('isLoading if false!');
    });
  }

  Future<Null> handleSignIn(BuildContext context) async {
    print('signInProcessStart');
    // this.setState(() {
    //   isLoading = true;
    // });
    print('isLoading is set True');
    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;
    print('user is got');

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
          // this.setState(() {
          //   isLoading = false;
          // });
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => IndexPage(
                        currentUser: firebaseUser,
                        handleSignOut: handleSignOut,
                      )));
        });
      } catch (err) {
        print(err);
      }
    } else {
      print("Sign in fail");
      // this.setState(() {
      //   isLoading = false;
      // });
    }
  }

  Future<Null> handleSignOut() async {
    // this.setState(() {
    //   isLoading = true;
    // });

    print('started sign out!');

    await FirebaseAuth.instance.signOut();
    print('firebase sign out!');
    await googleSignIn.signOut();
    print('google sign out!');
    try {
      await googleSignIn.disconnect();
      print('disconnect');
    } catch (e) {
      print(e);
    }
    print('signed Out! and going to my app');

    // this.setState(() {
    //   isLoading = false;
    // });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
