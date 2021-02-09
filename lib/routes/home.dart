import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  List _outputs;

  @override
  void initState() {
    super.initState();
 

    loadModel();
    pickImage();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SafeArea(
                    
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height:220.0,),
                 Text(
                   _outputs==null?'loading':'hello ${_outputs[0]["label"]}',
                   style: TextStyle(
                     fontFamily:'HanaleiFill',
                     color:Colors.blue,
                     letterSpacing:2.0,
                     fontSize: 30,
                   ),
                   ),
                   SizedBox(height:50),
                   _outputs==null?  SpinKitChasingDots(
                      color: Colors.blue,
                      size: 50.0
                  ):Image.asset('assets/verfiy.png',width: 180,height:180,),
                  
                ],
              ),
                      ),
                    ),
        
      );
  }

  pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    await classifyImage(image);
     Future.delayed(Duration(seconds:2),(){
    Navigator.pushReplacementNamed(context, 'profile',arguments: {
      'outputs':this._outputs
    });
     });
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      
      _outputs = output;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }
}