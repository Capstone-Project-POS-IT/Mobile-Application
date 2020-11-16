import 'package:flutter/material.dart';
import 'package:pos_it/Authentication/Login.dart';
import 'package:pos_it/ExternalCalls.dart';

//Views
import './Navibar.dart';
import 'calendar.dart';

void main() {
  runApp(MyApp());


}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}
