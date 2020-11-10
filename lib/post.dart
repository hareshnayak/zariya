import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';

final Color grey1 = Colors.grey.shade400;
final List<String> cat = ['#Dance', '#Music', '#theatre'];


class Post extends StatefulWidget {

  Post({this.name, this.email});

  final String name, email;

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

  bool imageTaken = false;
  File _image;
  final picker = ImagePicker();

  String category = 'DANCE';
  TextEditingController textController = new TextEditingController();

  Future getImage() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    if (image != null)
    {
      setState(() {
        _image = image;
        imageTaken = true;
      });
      print(_image.path);
    }
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('community/$category/posts/${Path.basename(_image.path)}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      Firestore.instance.collection('community')
          .document('$category').setData(
          {
            'posts' : FieldValue.arrayUnion([{
              'image' : fileURL,
              'name' : widget.name,
              'email' : widget.email,
              'text' : fileURL
            }])
          }, merge: true).then((value){
        setState(() {
          textController.clear();
          imageTaken = false;
          _image.delete();
          print('image path is : ${_image.path}');
        });
      });
    });
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
                  'zariyā',
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
                        child: Icon(Icons.home, color: Colors.black)))
              ],
            ),
          ),
          body: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: ListView(
//                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                   Row(children:<Widget>[
                     Text(
                      'Post',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                     Spacer(),
                   Container(
                      height: 30,
                      width: 70,
                       margin: EdgeInsets.symmetric(horizontal:5),
                     padding: EdgeInsets.symmetric(horizontal:10,vertical: 5 ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),                     
                        child: 
                            Text(
                            '${cat[0]}',
                            style: TextStyle(color: Colors.blue),),                                               
                    ),
                   ]),                       
                    Padding(
                      padding: EdgeInsets.all(10),
                      child:FlatButton(                     
                      padding: EdgeInsets.all(0),
                     onPressed:(){},
                      child: Container(                                               
                        decoration: BoxDecoration(                        
                          color: grey1,
                        borderRadius: BorderRadius.all(Radius.circular(15))),                        
                        height: 200,  
//                         width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:<Widget>[
                            Icon(Icons.add, size:50, color: Colors.grey.shade800)
                          ]),
                         ),),),
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

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal:10),
                      child:TextField(
                      decoration: InputDecoration(
                        hintText: 'Attach post link:',
                      ),),),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Description",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),                    
                     Padding(
                      padding: EdgeInsets.all(10),
                      child:FlatButton(                     
                      padding: EdgeInsets.all(0),
                     onPressed:(){},
                      child: Container(          
                        decoration: BoxDecoration(                        
                          color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(10))),                        
                        height: 40,  
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:<Widget>[
                            Text('Post', style: TextStyle(fontWeight:  FontWeight.bold, fontSize: 25, color:Colors.white))
                          ]),
                         ),),),
                  ])),
        ));
  }
}
