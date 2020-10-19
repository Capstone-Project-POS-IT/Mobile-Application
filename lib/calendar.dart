import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  AnimationController _animationController;

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
          padding: const EdgeInsets.all(8.0),
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
                  ), */
                  events: _events,
                  calendarController: _controller,
                  initialCalendarFormat: CalendarFormat.week,
                  formatAnimation: FormatAnimation.slide,
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  availableGestures: AvailableGestures.all,
                  /*
                  builders: CalendarBuilders(
                    selectedDayBuilder: (context, date, _) {
                      return FadeTransition(
                        opacity: Tween(begin: 0.0, end: 1.0).animate(_animationController),
                        child: Container(
                          margin: const EdgeInsets.all(4.0),
                          padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                          color: Colors.deepOrange[300],
                          width: 100,
                          height: 100,
                          child: Text(
                            '${date.day}',
                            style: TextStyle().copyWith(fontSize: 16.0),
                          ),
                        ),
                      );
                    },
                  ), */
                ),
                Slider(
                  value: _currentSliderValue,
                  min: 0,
                  max: 10,
                  divisions: 10,
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
  //function for the dialog box that appears when the user clicks on the floating button.
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

  /*
  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _controller.isSelected(date)
            ? Colors.brown[500]
            : _controller.isToday(date)
            ? Colors.brown[300]
            : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
  */

  //simple function that takes a number as a string input (1 -10) and returns a color
  Color getColor(String mood) {
    Color c10 = const Color(0xfafa6e);
    Color c9 = const Color(0xc4ec74);
    Color c8 = const Color(0x92dc7e);
    Color c7 = const Color(0x64c987);
    Color c6 = const Color(0x39b48e);
    Color c5 = const Color(0x089f8f);
    Color c4 = const Color(0x00898a);
    Color c3 = const Color(0x08737f);
    Color c2 = const Color(0x215d6e);
    Color c1 = const Color(0x2a4858);

    if(mood == '1') {
      return c1;
    } else if (mood == '2') {
      return c2;
    } else if (mood == '3') {
      return c3;
    } else if (mood == '4') {
      return c4;
    } else if (mood == '5') {
      return c5;
    } else if (mood == '6') {
      return c6;
    } else if (mood == '7') {
      return c7;
    } else if (mood == '8') {
      return c8;
    } else if (mood == '9') {
      return c9;
    } else {
      return c10;
    }
  }
}