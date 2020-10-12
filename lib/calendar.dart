import 'dart:io';
import 'package:flutter/material.dart';
<<<<<<< Updated upstream
<<<<<<< Updated upstream
=======
import 'package:table_calendar/table_calendar.dart';
>>>>>>> Stashed changes
=======
import 'package:table_calendar/table_calendar.dart';
>>>>>>> Stashed changes

class CalendarView extends StatefulWidget {
  @override
  _CalendarView createState() => new _CalendarView();
}

<<<<<<< Updated upstream
class _CalendarView extends State<CalendarView> {
<<<<<<< Updated upstream
=======
=======
//CalendarView will be the view that shows the whole month after the user
//selects how they felt.
class _CalendarView extends State<CalendarView> {
>>>>>>> Stashed changes

  CalendarController _controller;

  @override
  void initState() {
    _controller = CalendarController();
  }

<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Calendar View'),
      ),
<<<<<<< Updated upstream
<<<<<<< Updated upstream
=======
=======
>>>>>>> Stashed changes
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(calendarController: _controller,)
          ],
        )
      )
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
    );
  }
}

//mainCalendarView will be the view that shows the current day and allows the user to
//select how they felt throughout the day.
class MainCalendarView extends StatefulWidget {
  @override
  _MainCalendarView createState() => new _MainCalendarView();
}

class _MainCalendarView extends State<MainCalendarView> {

  CalendarController _controller;

  @override
  void initState() {
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Daily Mood'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                TableCalendar(
                  calendarController: _controller,
                  initialCalendarFormat: CalendarFormat.week,
                  formatAnimation: FormatAnimation.slide,
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  availableGestures: AvailableGestures.all,
                ),
                RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CalendarView()),
                    );
                  },
                )
              ]
            )
        )
        )
>>>>>>> Stashed changes
    );
  }
}