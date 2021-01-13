

import 'package:S_ATM/routes/home.dart';
import 'package:S_ATM/routes/profile.dart';
import 'package:flutter/material.dart';


void main() => runApp(
  MaterialApp(
    initialRoute: '/',
    routes:{
      '/':(context)=>Home(),
      'profile':(context)=>Profile(),
    },
  )
);
  

