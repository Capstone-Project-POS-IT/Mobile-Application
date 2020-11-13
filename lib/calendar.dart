import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pos_it/UserInfo/UserInformation.dart';
import 'package:pos_it/UserInfo/UserInformation.dart';
import 'package:pos_it/ExternalCalls.dart';
import 'package:intl/intl.dart';


//mainCalendarView will be the view that shows the current day and allows the user to
//select how they felt throughout the day.

class MainCalendarView extends StatefulWidget {
  @override
  _MainCalendarView createState() => new _MainCalendarView();
}

class _MainCalendarView extends State<MainCalendarView> {

  String currentDateSentiment = 11.0.toString();
  CalendarController _controller;
  String globalSentiment;
  Map<DateTime, List<dynamic>> _events;
  double _currentSliderValue = 1;
  final children = <Widget>[];
  double sliderValue;
  List<dynamic> _selectedEvents;
  var eventMoods = new Map();
  Map<String, dynamic> map;

  void initState() {
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
    super.initState();
    addEventstoCalendar();
  }

  void _onDaySelected(DateTime day, List events, _) {
    List events = [];
    events.add(eventMoods[day].toString());
    setState(() {
      _selectedEvents = events;
    });
  }

  void addEventstoCalendar() {
    map = UserInformation.getUserSentimentMap();

    map.forEach((k, v) {
      DateTime date = DateTime.parse(k);
      List<dynamic> temp = new List();
      temp.add(v["sentiment"]) as dynamic;
      //print(v["sentiment"]);
      _events[date] = temp;
    });
  }

  Widget returnDateMood() {
    String todayDateFormatted = DateFormat('yyyy-MM-dd').format(_controller.selectedDay);
    if(map.containsKey(todayDateFormatted) == true) {
      print(map[todayDateFormatted]);
      print(map[todayDateFormatted].runtimeType);
      double sentiment = map[todayDateFormatted];
      currentDateSentiment = sentiment.toString();

      return new Container(
        width: 100.0,
        height: 20.0,
        child: new Text('Mood: ' + sentiment.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold,
              //color: getTextColor(sentiment.toString())
                color: Colors.white),
        ),

        decoration: BoxDecoration(
          color: getColor(sentiment.toString()),
          //color: Colors.greenAccent,
          shape:  BoxShape.rectangle,
          border: Border.all(width: 2.0, color: Colors.black12),
          borderRadius: BorderRadius.circular(5),

        ),
      );
    } else {
      return new Container(
          width: 100.0,
          height: 50.0,
          child: new Text('No sentiment data found.',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
          )
      );
    }
  }

  void updateCurrentSentiment() {
    String todayDateFormatted = DateFormat('yyyy-MM-dd').format(_controller.selectedDay);
    if(map.containsKey(todayDateFormatted) == true) {
      double sentiment = map[todayDateFormatted];
      currentDateSentiment = sentiment.toString();
    } else {
      currentDateSentiment = 11.0.toString();
    }
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
                      events: _events,
                      calendarController: _controller,
                      initialCalendarFormat: CalendarFormat.week,
                      formatAnimation: FormatAnimation.slide,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      availableGestures: AvailableGestures.all,
                      onDaySelected: (date, events, _) {
                        _onDaySelected(date, events, _);
                        updateCurrentSentiment();
                      },
                      calendarStyle: CalendarStyle(
                        selectedColor: getColor(currentDateSentiment),
                        todayColor: Colors.lightBlue,
                        //markersColor: Colors.brown[700],
                      ),
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
                          sliderValue = value;
                        }
                        );
                      },
                    ),
                    ... _selectedEvents.map((globalSentiment) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: returnDateMood(),
                    ),
                    ),
                  ]
              )
          )
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          setState(() {
            if(sliderValue == null) {
              sliderValue = 1.0;
            }

            if(_events[_controller.selectedDay] == null) {
              if (_events[_controller.selectedDay] != null) {
                _events[_controller.selectedDay].add(sliderValue.toString());
              } else {
                _events[_controller.selectedDay] = [sliderValue.toString()];
              }

              APICall.sendUserDaySentimentData(sliderValue, 'placeholder', _controller.selectedDay);
              //sleep(const Duration(milliseconds:350));
              UserInformation.addUserSentimentData(_controller.selectedDay, sliderValue);

              //remove in order for calendar to save properly.
              //sleep(const Duration(milliseconds:350));
              //UserInformation.setAllUserInformationData();

            }
          });
          eventMoods[_controller.selectedDay] = sliderValue;
        },
      ),
    );
  }

  //simple function that takes a number as a double input (1 -10) and returns a color
  Color getColor(String event) {
    double mood = 0.0;
    if(event == 'null') {
      return Colors.black54;
    } else {
      mood = double.parse(event);
    }

    if(mood == 1.0) {
      return const Color(0xfF0b0742);
    } else if(mood == 2.0) {
      return const Color(0xff34104b);
    } else if (mood == 3.0) {
      return const Color(0xff531b53);
    } else if (mood == 4.0) {
      return const Color(0xff6f285a);
    } else if (mood == 5.0) {
      return const Color(0xff8a3960);
    } else if (mood == 6.0) {
      return const Color(0xffa24c66);
    } else if (mood == 7.0) {
      return const Color(0xffb8606c);
    } else if (mood == 8.0) {
      return const Color(0xffcd7773);
    } else if (mood == 9.0) {
      return const Color(0xffdf8e7c);
    } else if (mood == 10.0) {
      return const Color(0xffefa787);
    } else if (mood == 11.0) {
      return Colors.lightBlue;
    } else {
      return const Color(0xfffdc094);
    }
  }

  Color getTextColor(String event) {
    double mood = 0.0;
    if(event == 'null') {
      return Colors.white;
    } else {
      mood = double.parse(event);
    }

    if(mood <= 9.0) {
      return Colors.white;
    } else {
      return Colors.black45;
    }
  }
}