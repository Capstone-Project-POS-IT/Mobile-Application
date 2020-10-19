import 'dart:io';
import 'package:flutter/material.dart';

//Views
import './calendar.dart';
import './news.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeView createState() => new _HomeView();
}

class _HomeView extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: SingleChildScrollView(
        child: new Text('Inspiring quote here')
      )
    );
  }
}