import 'dart:io';
import 'package:flutter/material.dart';

//Views
import './Home.dart';
import './calendar.dart';
import './settings.dart';
import './News.dart';

class NaviView extends StatefulWidget {
  @override
  _NaviView createState() => new _NaviView();
}

class _NaviView extends State<NaviView> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeView(),
    MainCalendarView(),
    NewsView(),
    SettingsView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.calendar_today),
            title: new Text("Tracker"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.report),
            title: new Text("News"),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.settings),
            title: new Text("Settings"),
          ),
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