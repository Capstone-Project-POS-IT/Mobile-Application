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
  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: FutureBuilder<List<String>> (
          future: APICall.getInspirationalQuote(),
          builder: (context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data.join());
            } else {
              return CircularProgressIndicator();
            }
          }
      ),
    );
  }
}

/*
class _HomeView extends State<HomeView> {
  var quote = 'placeholder';
  var test = HomeView.getQuote();

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
            child: Text(test,
              textAlign: TextAlign.center,
            ),
         ),
        ),
      )
    );
  }
}
*/