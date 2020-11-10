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
    return DefaultTabController(
      //initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: new Text('News Reports'),
          bottom: TabBar(
            tabs: <Widget>[
              new Text('Top Stories', style: TextStyle(
                fontSize: 18,
              )),
              new Text('US', style: TextStyle(
                fontSize: 18,
              )),
              new Text('Health', style: TextStyle(
                fontSize: 18,
              )),
              new Text('Sports', style: TextStyle(
                fontSize: 18,
              )),
            ]
          ),
        ),
        body: TabBarView(
          //you can change the center widget to another widget that would
          //fit your need better.
          children: <Widget>[
            Center(
              child: Text('child body 1'),
            ),
            Center(
              child: Text('child body 2'),
            ),
            Center(
              child: Text('child body 3'),
            ),
            Center(
              child: Text('child body 4'),
            ),
          ],
        ),
      ),
    );
    }
}



/*
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



 */

