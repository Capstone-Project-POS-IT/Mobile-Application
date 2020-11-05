import 'dart:io';
import 'package:flutter/material.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsView createState() => new _NewsView();
}

class _NewsView extends State<NewsView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          children: <Widget>[TopBar()],
        ),
      ),
    );
  }
}

class TopBar extends StatefulWidget {
  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {

  void _doSomething(){

  }
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset("lib/assets/images/posit_logo.png"),
          Align(
            alignment: Alignment.topRight,
            child:IconButton(
              icon: Icon(Icons.search),
              iconSize: 50,
              onPressed: _doSomething,
            ) ,
          )

        ],
      ),
    );
  }
}

