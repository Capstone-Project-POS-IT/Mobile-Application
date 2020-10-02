import 'dart:io';
import 'package:flutter/material.dart';

class CalendarView extends StatefulWidget {
  @override
  _CalendarView createState() => new _CalendarView();
}

class _CalendarView extends State<CalendarView> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Calendar View'),
      ),
    );
  }
}