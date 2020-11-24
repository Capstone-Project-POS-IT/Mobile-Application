import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pos_it/Authentication/Login.dart';
import 'package:pos_it/UserInfo/UserInformation.dart';
import 'package:pos_it/UserInfo/UserInformation.dart';
//Views
import './Calendar.dart';
import './News.dart';
import 'ExternalCalls.dart';

class WelcomeName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Welcome " + UserInformation.getDisplayName(),
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40, color: Color(0xffDCFCDD)));
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
                WelcomeName(),
                FutureBuilder<String> (
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
              )],
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset("lib/assets/images/posit_logo.png", height:150),
          Align(
            alignment: Alignment.topRight,
            /*child: Text("Welcome",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xffDCFCDD), fontWeight: FontWeight.bold, fontSize: 30)),*/
          ),
        ],
      ),
    );
  }
}