import 'dart:io';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
//mainCalendarView will be the view that shows the current day and allows the user to
//select how they felt throughout the day.
class MainCalendarView extends StatefulWidget {
  @override
  _MainCalendarView createState() => new _MainCalendarView();
}

class _MainCalendarView extends State<MainCalendarView> {

  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  double _currentSliderValue = 1;
  TextEditingController _eventController;

  @override
  void initState() {
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
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
                  /*builders: CalendarBuilders(
                    selectedDayBuilder: (context, date, events) =>
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                          ),
                        ),
                  ),*/
                  events: _events,
                  calendarController: _controller,
                  initialCalendarFormat: CalendarFormat.week,
                  formatAnimation: FormatAnimation.slide,
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  availableGestures: AvailableGestures.all,
                ),
                Slider(
                  value: _currentSliderValue,
                  min: 0,
                  max: 10,
                  divisions: 100,
                  label: _currentSliderValue.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _currentSliderValue = value;
                    });
                  },
                ),
              ]
            )
          )
        ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: _showAddDialog,

      ),
    );
  }
  _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: _eventController,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("Save"),
            onPressed: (){
              if(_eventController.text.isEmpty) return;
              setState(() {
                if(_events[_controller.selectedDay] != null) {
                  _events[_controller.selectedDay].add
                    (_eventController.text);
                }else{
                  _events[_controller.selectedDay] =
                      [_eventController.text];
                }
                _eventController.clear();
                Navigator.pop(context);
              });
            },
          )
        ]
      )
    );
  }
}