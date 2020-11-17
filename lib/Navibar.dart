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
        // backgroundColor: Color(0xff131d47),
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.calendar_today),
            label: "Tracker",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.report),
            label: "News",
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.settings),
            label: "Settings",
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