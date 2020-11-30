import 'dart:collection';
//import 'dart:html';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pos_it/Authentication/Login.dart';
import 'package:pos_it/UserInfo/UserInformation.dart';
import 'package:pos_it/UserInfo/UserInformation.dart';
import 'package:intl/intl.dart';
//Views
import './Calendar.dart';
import './News.dart';
import 'ExternalCalls.dart';

class WelcomeName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Welcome "+UserInformation.getDisplayName(),
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 40,color: Color(0xff131d47)));
  }
}

class userStats extends StatelessWidget {
  Map<String, dynamic> map = UserInformation.getUserSentimentMap();


  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Column(
            children: [
              new Text('Current Month:'),
              new Text('Previous Month:'),
              new Divider(
                color: Colors.black87,
              ),
              new Text('Happiness Streak:'),
            ],
          ),
          new Column(
            children: [
              new Text(currentMonthAverage(),
                  style: TextStyle(color: getColor(currentMonthAverage().toString()))),
              new Text(previousMonthAverage(),
                  style: TextStyle(color: getColor(previousMonthAverage().toString()))),
              new Divider(
                color: Colors.black87,
              ),
              new Text(happyStreak()),
            ],
          ),
        ]
    );
  }

  /*
  function that returns a string of the previous months average sentiment
  */
  String previousMonthAverage() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    var parsedDate = DateTime.parse(formattedDate);
    int currentMonth = monthParser(parsedDate);
    int previousMonth;
    if(currentMonth == 1) {
      previousMonth = 12;
    } else {
      previousMonth = currentMonth - 1;
    }

    int month;
    double average = 0;
    int count = 0;

    if(map != null) {
      map.forEach((k, v) {
        DateTime date = DateTime.parse(k);
        month = monthParser(date);
        if (month == previousMonth) {
          average = average + v['sentiment'];
          count++;
        }
      });
    } else {
      return 'No data availible.';
    }

    if(average == 0) {
      return 'No data availible.';
    } else {
      average = average / count;
      return average.toStringAsFixed(0);
    }
  }

  /*
  function that returns a string of the current average sentiment for that month
  */
  String currentMonthAverage() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    var parsedDate = DateTime.parse(formattedDate);
    int currentMonth = monthParser(parsedDate);
    int month;
    double average = 0;
    int count = 0;

    if(map != null) {
      map.forEach((k, v) {
        DateTime date = DateTime.parse(k);
        month = monthParser(date);
        if (month == currentMonth) {
          average = average + v['sentiment'];
          count++;
        }
      });
    } else {
      return 'No data availible.';
    }

    if(average == 0) {
      return 'No data availible.';
    } else {
      average = average / count;
      return average.toStringAsFixed(0);
    }
  }

  /*
  function that returns a int month from a datetime day
  */
  int monthParser(DateTime date) {
    String Date = date.toString();
    String month = '';

    for(int i=0; i < Date.length; i++) {
      if(i > 4 && i < 7) {
        var char = Date[i];
        month = month + char;
      }
    }
    return int.parse(month);
  }

  /*
  function that returns an int day from a datetime day
  */
  int dayParser(DateTime date) {
    String Date = date.toString();
    String day = '';
    //print(Date);

    for(int i=0; i < Date.length; i++) {
      if(i > 7 && i < 10) {
        var char = Date[i];
        day = day + char;
      }
    }
    return int.parse(day);
  }

  /*
  function that returns an organzied map where keys = int day and values = a datetime object of that day
  */
  Map dayMonthOrganizer(int currentMonth) {
    final SplayTreeMap<int, DateTime> organizedMonth = SplayTreeMap<int, DateTime>();
    int month;
    int day;

    if(map != null) {
      map.forEach((k, v) {
        DateTime date = DateTime.parse(k);
        month = monthParser(date);
        if (month == currentMonth) {
          day = dayParser(date);
          print(date);
          organizedMonth[day] = date;
        }
      });
    };
    return organizedMonth;
  }

  /*
  a function that will make an organized copy of the global map.
   */
  Map globalMapOrganizer() {
    final SplayTreeMap<String, dynamic> organizedMap = SplayTreeMap<String, dynamic>();

    if(map != null) {
      map.forEach((k, v) {
        organizedMap[k] = v;
      });
    } else {
      return null;
    }
    return organizedMap;
  }

  /*
  function that returns a string that represents the current streak of happy days
  */
  String happyStreak() {
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    var parsedDate = DateTime.parse(formattedDate);

    int streak = 0;
    int longestStreak = 0;
    String previousDay;
    bool onStreak = false;

    Map<String, dynamic> organizedMap = globalMapOrganizer();
    //print(organizedMap);

    if(organizedMap != null) {
      organizedMap.forEach((date, dyn) {
        if(monthParser(DateTime.parse(date)) <= monthParser(parsedDate) && dayParser(DateTime.parse(date)) <= dayParser(parsedDate)) {
          if(previousDay == null) {
            if(map[date]['sentiment'] <= 6.0) {
              streak = streak + 1;
              if(onStreak == false) {
                onStreak = true;
              }
            }
            previousDay = date;
            print(previousDay);
            if(streak > longestStreak) {
              longestStreak = streak;
            }
          } else {
            if(dayParser(DateTime.parse(date)) - dayParser(DateTime.parse(previousDay)) == 1) {
              if(map[date]['sentiment'] <= 6.0) {
                streak = streak + 1;
                if(onStreak == false) {
                  onStreak = true;
                }
              }
            } else {
              streak = 0;
              onStreak = false;
            }
            print('current bool' + onStreak.toString());
            previousDay = date;
            if(streak > longestStreak) {
              longestStreak = streak;
            }
          }
        }
      });
    }

    print('Streak :' + longestStreak.toString());
    print(onStreak);
    if(longestStreak > 0 && onStreak == true) {
      return longestStreak.toString();
    } else {
      return 'No data availible';
    }
  }

  /*
  function that returns a color given a sentiment value
   */
  Color getColor(String average) {
    double mood = 0.0;
    if(average == 'null') {
      return Colors.black54;
    } else {
      if(average == 'No data availible.') {
        return Colors.black54;
      } else {
        mood = double.parse(average);
      }
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
}

class HomeView extends StatefulWidget {
  @override
  _HomeView createState() => new _HomeView();
}

class _HomeView extends State<HomeView> {
  @override
  Widget build(context) {
    return Scaffold(
        backgroundColor: Color(0xff131D47),
        body: SingleChildScrollView(
            child: Column(
              children: <Widget> [
                Title(),
                Padding(
                  padding: EdgeInsets.all(40),
                  child: Container(
                    width: 300,
                    child: Text (
                        "Welcome " + UserInformation.getDisplayName(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Color(0xffDCFCDD)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(40),
                  child: Container (
                    width: 200,
                    child: FutureBuilder<String> (
                        future: APICall.getInspirationalQuote(),
                        builder: (context, AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return Text(snapshot.data,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 20, color: Color(0xffffffff)),
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        }
                    )
                  ),
                ),
              ],
            )
        )
    );
  }
}

class Title extends StatefulWidget {
  @override
  _Title createState() => _Title();
}

class _Title extends State<Title> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 15, 0, 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset("lib/assets/images/posit_logo.png", height:150),
          ]),
          Align(
            alignment: Alignment.topRight,
          ),
        ],
      ),
    );
  }
}
