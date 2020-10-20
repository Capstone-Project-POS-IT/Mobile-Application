import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pos_it/APICall.dart';

//Views
import './calendar.dart';
import './news.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeView createState() => new _HomeView();
}

class _HomeView extends State<HomeView> {
  //var _quote = _getQuote();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(100.0),
          child: Center(
            child: Text("placeholder",
              textAlign: TextAlign.center,
            ),
         ),
        ),
      )
    );
  }
  Future<dynamic> _getQuote() async {
    final Future<List<dynamic>> _futureList = APICall.getInspirationalQuote();
    final _list = await _futureList;
    return _list;
  }
}