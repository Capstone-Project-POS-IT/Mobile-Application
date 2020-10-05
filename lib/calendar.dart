import 'dart:io';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream
=======
import 'package:table_calendar/table_calendar.dart';
>>>>>>> Stashed changes

class CalendarView extends StatefulWidget {
  @override
  _CalendarView createState() => new _CalendarView();
}

class _CalendarView extends State<CalendarView> {
<<<<<<< Updated upstream
=======

  CalendarController _controller;

  @override
  void initState() {
    _controller = CalendarController();
  }

>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Calendar View'),
      ),
<<<<<<< Updated upstream
=======
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(calendarController: _controller,)
          ],
        )
      )
>>>>>>> Stashed changes
    );
  }
}