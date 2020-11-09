import 'package:flutter/material.dart';
import 'package:pos_it/Authentication/Login.dart';

//Views
import './Navibar.dart';
import 'calendar.dart';

void main() {
  runApp(MyApp());

  //test function call


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}
