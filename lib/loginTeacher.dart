import 'package:flutter/material.dart';
import 'package:zariya/services/authentication.dart';
import 'package:zariya/teacher.dart';
import 'package:zariya/main.dart';

class LoginTeacher extends StatefulWidget {
  final BaseAuth auth;

  LoginTeacher({this.auth});

  @override
  _LoginTeacherState createState() => _LoginTeacherState();
}

class _LoginTeacherState extends State<LoginTeacher> {
  static GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  bool isLoading = false;

  void signIn() async {
    print('signIn start');
    setState(() {
      isLoading = true;
    });
    if (emailController.value.text.isNotEmpty &&
        passwordController.value.text.isNotEmpty) {
      print('not empty');
      try {
        widget.auth
            .signIn(emailController.value.text, passwordController.value.text)
            .catchError((e) {
          var snackbar = SnackBar(
            content: Text('Please enter the details correctly!'),
          );
          _scaffoldKey.currentState.showSnackBar(snackbar);
        }).then((value) async {
          if (value != null) {
            print('signedIn');
            setState(() {
              isLoading = false;
            });
            await widget.auth
                .getCurrentUser()
                .then((value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TeacherIndexPage(
                              signOut: widget.auth.signOut,
                              currentUser: value,
                            ))));
          } else {
            print('Not Logged In');
            setState(() {
              isLoading = false;
            });
            var snackbar = SnackBar(
              content: Text('Email and Password doesn\'t match!'),
            );
            _scaffoldKey.currentState.showSnackBar(snackbar);
          }
        });
      } catch (e) {
        print(e);
        setState(() {
          isLoading = false;
        });
        var snackbar = SnackBar(
          content:
              Text('Something\'s not right. Please check the details again.'),
        );
        _scaffoldKey.currentState.showSnackBar(snackbar);
      }
    } else {
      setState(() {
        isLoading = false;
      });
      var snackbar = SnackBar(
        content: Text('Please enter email / password correctly.'),
      );
      _scaffoldKey.currentState.showSnackBar(snackbar);
    }
  }

  // void isSignedIn() async {
  //   await widget.auth.getCurrentUser().then((value) {
  //     print('he is logged in $value');
  //     if (value != null) {
  //       Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //               builder: (context) => TeacherIndexPage(
  //                     signOut: signOut,
  //                     currentUser: value,
  //                   )));
  //     }
  //   });
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   isSignedIn();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: (isLoading)
          ? Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Center(child: CircularProgressIndicator()))
          : Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 150),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Text("Login as Instructor",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    width: MediaQuery.of(context).size.width - 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      border: Border.all(
                        width: 1,
                        color: Colors.deepPurple,
                      ),
                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Email',
                        prefixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    width: MediaQuery.of(context).size.width - 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      border: Border.all(
                        width: 1,
                        color: Colors.deepPurple,
                      ),
                    ),
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Password',
                        prefixIcon: Icon(Icons.vpn_key),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 17, horizontal: 20),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                    width: MediaQuery.of(context).size.width - 100,
                    height: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      border: Border.all(
                        width: 1,
                        color: Colors.deepPurple,
                      ),
                      color: Colors.deepPurple,
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        signIn();
                      },
                      child: Text(
                        'Log me in',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Text(
                        "The login username and password has been provided by the institute",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
    );
  }
}
