import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:pos_it/UserInfo/UserInformation.dart';
import 'package:pos_it/ExternalCalls.dart';
import 'package:intl/intl.dart';
import 'package:pos_it/SettingsViews/Accessibility.dart';
import 'package:shared_preferences/shared_preferences.dart';


//mainCalendarView will be the view that shows the current day and allows the user to
//select how they felt throughout the day.

class MainCalendarView extends StatefulWidget {
  @override
  _MainCalendarView createState() => new _MainCalendarView();
}

class _MainCalendarView extends State<MainCalendarView> {

  //Future<dynamic> userAccessibility = getExplodedViewBool();
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
  String descripValue;
  final TextEditingController _Textcontroller = new TextEditingController();

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
    if(map != null) {
      map.forEach((k, v) {
        DateTime date = DateTime.parse(k);
        List<dynamic> temp = new List();
        if(v["sentiment"] == null) {
          temp.add(1.0) as dynamic;
        } else {
          temp.add(v["sentiment"]) as dynamic;
        }
        _events[date] = temp;
      });
    }
  }

  Widget returnDateMood() {
    String todayDateFormatted = DateFormat('yyyy-MM-dd').format(_controller.selectedDay);
    if(map.containsKey(todayDateFormatted) == true) {
      double sentiment;
      if(map[todayDateFormatted].runtimeType == double) {
        sentiment = map[todayDateFormatted];
      } else {
        if(map[todayDateFormatted] == null) {
          sentiment = 1.0;
        } else {
          sentiment = map[todayDateFormatted]['sentiment'].toDouble();
        }
      }
      String description;
      if(map[todayDateFormatted] is double) {

      } else {
        if(map[todayDateFormatted]['description'] == null || map[todayDateFormatted]['description'] == 'placeholder') {
          description = '';
        } else {
          description = map[todayDateFormatted]['description'];
        }
      }

      currentDateSentiment = sentiment.toString();

      return new Container(
        width: 150.0,
        height: 45.0,
        child: Center(
          child: new Text('Mood: ' + sentiment.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 17.0),
          ),
        ),

        decoration: BoxDecoration(
          color: getColor(sentiment.toString()),
          shape:  BoxShape.rectangle,
          border: Border.all(width: 2.0, color: Colors.black12),
          borderRadius: BorderRadius.circular(5),

        ),
      );
    } else {
      return new Container(
         //width: 100.0,
          //height: 50.0,
          child: new Text('No sentiment data found.',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45, fontSize: 14.0),
          )
      );
    }
  }

  Widget getDescription() {
    String todayDateFormatted = DateFormat('yyyy-MM-dd').format(_controller.selectedDay);
    if(map.containsKey(todayDateFormatted) == true) {
      double sentiment;
      String description;
      if (map[todayDateFormatted] is double) {

      } else {
        if (map[todayDateFormatted]['description'] == null ||
            map[todayDateFormatted]['description'] == 'placeholder') {
          description = '';
        } else {
          description = map[todayDateFormatted]['description'];
        }
      }
      currentDateSentiment = sentiment.toString();

      if (description == '' || description == null) {
        return new Container(
            //width: 100.0,
            //height: 50.0,
            child: FittedBox(
              fit:BoxFit.fitWidth,
              child: new Text('No description data found.',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45, fontSize: 14.0),
              ),
            )
        );
      } else {
        return new Text('Note: ' + description,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold,
              color: Colors.black87,
              fontSize: 17.0),
        );
      }
    } else {
      return new Container(
          //width: 100.0,
          //height: 50.0,
          child: FittedBox(
            fit:BoxFit.fitWidth,
            child: new Text('No description data found.',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black45, fontSize: 14.0),
            ),
          )
      );
    }
  }

  void updateCurrentSentiment() {
    String todayDateFormatted = DateFormat('yyyy-MM-dd').format(_controller.selectedDay);
    if(map.containsKey(todayDateFormatted) == true) {
      double sentiment;
      if(map[todayDateFormatted].runtimeType == double) {
        sentiment = map[todayDateFormatted];
      } else {
        if(map[todayDateFormatted] == null) {
          sentiment = 1.0;
        } else {
          sentiment = map[todayDateFormatted]['sentiment'].toDouble();
        }
      }
      currentDateSentiment = sentiment.toString();
    } else {
      currentDateSentiment = 11.0.toString();
    }
  }

  getExplodedViewBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool boolValue = prefs.getBool('Accessibility');
    return boolValue;
  }


  void explodedView(date, events, _) {
    getExplodedViewBool().then((boolValue){
      if(boolValue == false) {
        _onDaySelected(date, events, _);
        updateCurrentSentiment();
      } else {
        _showUserData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          backgroundColor: Color(0xff131d47),
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
                        //_onDaySelected(date, events, _);
                        //updateCurrentSentiment();
                        //_showUserData();
                        explodedView(date, events, _);
                      },
                      /*
                      onDaySelected: (date, events, _) {
                        _onDaySelected(date, events, _);
                        updateCurrentSentiment();
                      },
                       */
                      calendarStyle: CalendarStyle(
                        selectedColor: getColor(currentDateSentiment),
                        todayColor: Colors.lightBlue,
                        //markersColor: Colors.brown[700],
                      ),
                    ),
                    Container(
                      height: 25,
                      width: 75,
                      /*
                      child: new Text('Color Preview: ' + sliderValue.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                       */
                      decoration: BoxDecoration(
                        color: getColor(sliderValue.toString()),
                        shape:  BoxShape.rectangle,
                        border: Border.all(width: 2.0, color: Colors.black12),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Slider(
                      activeColor: getColor(sliderValue.toString()),
                      value: _currentSliderValue,
                      min: 1,
                      max: 10,
                      divisions: 9,
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
                      child: Column(
                        children: [
                          returnDateMood(),
                          new Divider(
                            color: Colors.white,
                          ),
                          getDescription(),
                        ],
                      ),
                    ),
                    ),
                    new Divider(
                      color: Colors.white,
                    ),
                    TextField(
                      controller: _Textcontroller,
                      autofocus: false,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: "Enter a note about your day!",
                      ),
                      onChanged: (text) {
                        descripValue = _Textcontroller.text;
                      },
                    ),
                  ]
              )
          )
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlue,
        child: Icon(Icons.add),
        onPressed: (){
          setState(() {
            _Textcontroller.clear();
            FocusScope.of(context).unfocus();

            if(_events[_controller.selectedDay] == null) {
              if (_events[_controller.selectedDay] != null) {
                print(sliderValue);
                if(sliderValue == null) {
                  _events[_controller.selectedDay].add("1.0");
                  APICall.sendUserDaySentimentData(1.0, descripValue, _controller.selectedDay).whenComplete(() => UserInformation.setUserBasedNews());
                  UserInformation.addUserSentimentData(_controller.selectedDay, 1.0,descripValue);
                } else {
                  _events[_controller.selectedDay].add(sliderValue.toString());
                  APICall.sendUserDaySentimentData(sliderValue, descripValue, _controller.selectedDay).whenComplete(() => UserInformation.setUserBasedNews());
                  UserInformation.addUserSentimentData(_controller.selectedDay, sliderValue,descripValue);
                }
              } else {
                if(sliderValue == null) {
                  _events[_controller.selectedDay] = ["1.0"];
                  APICall.sendUserDaySentimentData(1.0, descripValue, _controller.selectedDay).whenComplete(() => UserInformation.setUserBasedNews());
                  UserInformation.addUserSentimentData(_controller.selectedDay, 1.0,descripValue);
                } else {
                  _events[_controller.selectedDay] = [sliderValue.toString()];
                  APICall.sendUserDaySentimentData(sliderValue, descripValue, _controller.selectedDay).whenComplete(() => UserInformation.setUserBasedNews());
                  UserInformation.addUserSentimentData(_controller.selectedDay, sliderValue,descripValue);
                }

              }
              descripValue = '';
              //sleep(const Duration(milliseconds:350));
              //remove in order for calendar to save properly.
              sleep(const Duration(milliseconds:350));
              //UserInformation.setAllUserInformationData();
            }
          });
          eventMoods[_controller.selectedDay] = sliderValue;
        },
      ),
    );
  }

  _showUserData() {
    showGeneralDialog(
        barrierLabel: "Popup User Data",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder: (_, __, ___) {
          return Align(
              alignment: Alignment.center,
              child: Container(

                //borderRadius: BorderRadius.circular(40.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular(25.0)
                    )
                ),
                height: 300,
                width: 300,
                child: Padding(
                  padding: new EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      returnDateMood(),
                      new Divider(
                        color: Colors.white,
                      ),
                      getDescription()
                    ],
                  ),
                )
              )
            );
         },
    );
  }

  //simple function that takes a number as a double input (1 -10) and returns a color
  Color getColor(String event) {
    double mood = 0.0;
    if(event == 'null') {
      return Color(0xff000000);
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
      return Color(0xffffffff);
    } else {
      mood = double.parse(event);
    }

    if(mood <= 9.0) {
      return Color(0xffffffff);
    } else {
      return Color(0xff000000);
    }
  }
}