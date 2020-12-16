import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());
  

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  File _image;
  Future getImage()async{
    File image;
   
      image = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _image=image;
      });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('S_ATM'),
        centerTitle: true,
      ),
      body: Center(
        child:Column(
          children: <Widget>[
               IconButton(
              icon:Icon(Icons.camera),
              onPressed: (){
                getImage();
              }
               ,),
              _image == null ? Container(): Image.file(_image,height:300,width:300),

          ]
        )
        ,
      ),

    );
  }
}