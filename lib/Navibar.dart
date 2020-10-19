import 'dart:io';
import 'package:flutter/material.dart';

//Views
import './home.dart';
import './calendar.dart';
import './news.dart';

class NaviView extends StatefulWidget {
  @override
  _NaviView createState() => new _NaviView();
}

class _NaviView extends State<NaviView> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    MainCalendarView(),
    NewsView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.calendar_today),
            title: new Text('Tracker'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.report),
            title: new Text('News'),
          )
        ],
      ),
    );
  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}