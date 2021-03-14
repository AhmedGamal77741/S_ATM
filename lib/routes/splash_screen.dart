import 'home.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class SplashScreen extends StatefulWidget {
  
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   

  @override
  void initState() {
    
    super.initState();
    Future.delayed(Duration(seconds:4),(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder:(context)=>Home()));  
    });
  
    
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SafeArea(
                    
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height:180.0,),
                  Text('S_ATM',style:TextStyle(
                    color:Colors.blue,
                    fontFamily:'FiraSans-BlackItalic'
                  )),
                  SizedBox(height:180),
                  SpinKitChasingDots(
                      color: Colors.blue,
                      size: 35.0
                  )
                ],
              ),
                    ),
        
      );
  }
}