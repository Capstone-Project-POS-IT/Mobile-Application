import 'dart:io';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pos_it/ExternalCalls.dart';
import 'package:pos_it/Login.dart';
import 'package:pos_it/SignUp.dart';

//Views
import './Navibar.dart';

void main(){
  runApp(MyApp());

  //test function call





}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUp(),
    );
  }
}
