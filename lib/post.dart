import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:zariya/resources/colors.dart';

class Post extends StatefulWidget {
  Post({this.name, this.email, this.photoUrl, this.followId});

  final String name, email, photoUrl, followId;

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  bool imageTaken = false;
  File _image;
  final picker = ImagePicker();

  List<String> category = [];
  int categoryIndex = 0;

  bool isLoading = true;

  TextEditingController linkController = new TextEditingController();
  TextEditingController descController = new TextEditingController();

  Future getImage() async {
    var image =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      setState(() {
        _image = image as File;
        imageTaken = true;
      });
      print(_image.path);
    }
  }

  Future uploadFile() async {
    try {
      StorageReference storageReference = FirebaseStorage.instance.ref().child(
          'community/${category[categoryIndex]}/posts/${Path.basename(_image.path)}');
      StorageUploadTask uploadTask = storageReference.putFile(_image);
      await uploadTask.onComplete.whenComplete(() {
        storageReference.getDownloadURL().then((fileURL) {
          Firestore.instance
              .collection('community')
              .document('${category[categoryIndex]}')
              .setData({
                'posts': FieldValue.arrayUnion([
                  {
                    'image': fileURL,
                    'name': widget.name,
                    'email': widget.email,
                    'text': descController.value.text,
                    'photoUrl': widget.photoUrl,
                    'followId': widget.followId
                  }
                ])
              }, merge: true)
              .whenComplete(() => Firestore.instance
                      .collection('community')
                      .document('community')
                      .setData({
                    'allPosts': FieldValue.arrayUnion([
                      {
                        'image': fileURL,
//                  'link': linkController.value.text
                      }
                    ])
                  }, merge: true))
              .whenComplete(() {
                setState(() {
                  descController.clear();
                  linkController.clear();
                  imageTaken = false;
                  _image.delete();
                  print('image path is : ${_image.path}');
                });
              });
        });
      }).whenComplete(() => print('File Uploaded'));
    } catch (err) {
      print(err);
    }
  }

  void getCategory() async {
    await Firestore.instance
        .collection('community')
        .document('community')
        .get()
        .then((data) {
      setState(() {
        for (int i = 0; i < data['cards'].length; i++) {
          print(data['cards'][i]['tag']);
          category.add(data['cards'][i]['tag']);
        }
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(45.0),
            child: AppBar(
              backgroundColor: Colors.transparent,
              leading: SizedBox(
                  width: 60,
                  height: 30,
                  child: FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {},
                      child: Icon(Icons.menu, color: Colors.black))),
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
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/root', (route) => false);
                        },
                        child: Icon(Icons.home, color: Colors.black)))
              ],
            ),
          ),
          body: (isLoading)
              ? Container(child: Center(child: CircularProgressIndicator()))
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: ListView(
//                   crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(children: <Widget>[
                          Text(
                            'Post',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              if (categoryIndex > 0)
                                setState(() {
                                  categoryIndex--;
                                });
                            },
                          ),
                          Container(
                            height: 30,
//                        width: 100,
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Text(
                              '#${category[categoryIndex]}',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              if (categoryIndex < category.length - 1)
                                setState(() {
                                  categoryIndex++;
                                });
                            },
                          ),
                        ]),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              setState(() {
                                getImage();
                              });
                            },
                            child: (imageTaken)
                                ? Container(
                                    child: Image.file(_image),
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                        color: grey400,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    height: 200,
//                         width: MediaQuery.of(context).size.width,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(Icons.add,
                                              size: 50,
                                              color: Colors.grey.shade800)
                                        ]),
                                  ),
                          ),
                        ),
//                       child: SizedBox(
//                         child: Icon(Icons.add, size:30, color: Colors.black)),

//                        Stack(children:<Widget>[
//                          Container(
//                          margin: EdgeInsets.all(10),
//                       height: 250,
//                       decoration: BoxDecoration(
//                         color: grey1,

//                         borderRadius: BorderRadius.all(
//                           Radius.circular(15),
//                         ),),),
//                        Center(
//                        child: FlatButton(
//                       onPressed:(){},
//                          child: Icon(Icons.add,size: 30, color: Colors.black),
//                       ),),]),

//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: TextField(
//                         controller: linkController,
//                         decoration: InputDecoration(
//                           hintText: 'Attach post link:',
//                         ),
//                       ),
//                     ),
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: TextField(
                            controller: descController,
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: "Description",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: FlatButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              if (descController.value.text.isNotEmpty &&
                                  imageTaken == true) {
                                setState(() {
                                  isLoading = true;
                                });
                                uploadFile().whenComplete(() => setState(() {
                                      isLoading = false;
                                    }));
                              } else {
                                print('something is left!');
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              height: 40,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text('POST',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                            color: Colors.white))
                                  ]),
                            ),
                          ),
                        ),
                      ])),
        ));
  }
}
