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

  CalendarController _controller;
  String globalSentiment;
  Map<DateTime, List<dynamic>> _events;
  double _currentSliderValue = 1;
  final children = <Widget>[];
  double sliderValue;
  List<dynamic> _selectedEvents;
  var eventMoods = new Map();
  Map<String, dynamic> map;
  SharedPreferences prefs;

  void initState() {
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
    super.initState();
    addEventstoCalendar();
    //initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(decodeMap(json.decode(prefs.getString("events") ?? "{ }")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
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
      double sentiment = map[todayDateFormatted]["sentiment"].toDouble();

      return new Container(
        width: 100.0,
        height: 20.0,
        child: new Text('Mood: ' + sentiment.toString(),
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold, color: getTextColor(sentiment.toString())),
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
          child: new Text('No sentiment value found.',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45),
           )
      );
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
                  },
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

    if(mood == 0.0) {
      return const Color(0xff3a3858);
    } else if(mood == 1.0) {
      return const Color(0xff2a4858);
    } else if (mood == 2.0) {
      return const Color(0xff215d6e);
    } else if (mood == 3.0) {
      return const Color(0xff08737f);
    } else if (mood == 4.0) {
      return const Color(0xff00898a);
    } else if (mood == 5.0) {
      return const Color(0xff089f8f);
    } else if (mood == 6.0) {
      return const Color(0xff39b48e);
    } else if (mood == 7.0) {
      return const Color(0xff64c987);
    } else if (mood == 8.0) {
      return const Color(0xff92dc7e);
    } else if (mood == 9.0) {
      return const Color(0xffc4ec74);
    } else {
      return const Color(0xfffafa6e);
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