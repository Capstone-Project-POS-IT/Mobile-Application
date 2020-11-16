import 'dart:io';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pos_it/Authentication/Login.dart';
import 'package:pos_it/Authentication/EmailAuthentication.dart';
import 'package:pos_it/Authentication/SignUp.dart';
import 'package:pos_it/ExternalCalls.dart';
import 'package:pos_it/Profile.dart';
import 'package:pos_it/creators.dart';
import 'package:pos_it/home.dart';
import 'package:pos_it/news.dart';
import 'package:pos_it/settings.dart';
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
      home: ProfileView(),
    );
  }
}
