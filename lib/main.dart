import 'package:flutter/material.dart';
import 'package:pos_it/Authentication/Login.dart';
import 'package:pos_it/SettingsViews/Settings.dart'; //TODO: get rid of later
import 'package:pos_it/SettingsViews/Profile.dart'; //TODO: get rid of later
import 'package:pos_it/home.dart';

void main() {
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SettingsView(),
    );
  }
}
