import 'package:flutter/material.dart';
import 'package:pos_it/Authentication/Login.dart';
import 'package:pos_it/News.dart';

//Views
import './Navibar.dart';
import 'Calendar.dart';

void main() {
  runApp(MyApp());

  //test function call


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NewsView(),
    );
  }
}
