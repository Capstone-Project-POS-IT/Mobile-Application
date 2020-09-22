import 'dart:io';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pos_it/APICall.dart';


void main(){
  runApp(MyApp());

  //test function call
  APICall.testAPI();


}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to POS.IT!!!'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
