import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccessibilityView extends StatefulWidget {
  @override
  _AccessibilityView createState() => new _AccessibilityView();
}

bool explodedViewBool = false;

class _AccessibilityView extends State<AccessibilityView> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xff131D47),
      body: Center(
        child: Column(
            children: <Widget>[
              Title(),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xff1D2D6B),
                    border: Border(
                      top: BorderSide(width: 0.5, color: Color(0xffFFFFFF)),
                      bottom: BorderSide(width: 0.5, color: Color(0xffFFFFFF)),
                    ),
                  ),
                  child: Row(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Text("Calendar Exploded Views",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xffFFFFFF), fontSize: 20, backgroundColor: Color(0xff1D2D6B))),
                    ),
                    Checkbox(
                        value: explodedViewBool,
                        onChanged: _explodedViewBoolChanged,
                    ),
                  ]),
                ),
        ]),
      ),
    );
  }
  _explodedViewBoolChanged(bool newValue) => setState(() {
    explodedViewBool = newValue;
    addBoolToSF(explodedViewBool);
  });
}

addBoolToSF(BoolValue) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool('Accessibility', BoolValue);
}






class Title extends StatefulWidget {
  @override
  _Title createState() => _Title();
}

class _Title extends State<Title> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset("lib/assets/images/posit_logo.png", height:150),
          Align(
            alignment: Alignment.center,
            child: Text("Accessibility",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xffDCFCDD), fontWeight: FontWeight.bold, fontSize: 30)),
          ),
        ],
      ),
    );
  }
}