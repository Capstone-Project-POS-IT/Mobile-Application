import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pos_it/Authentication/Login.dart';
import 'package:pos_it/UserInfo/UserInformation.dart';
import 'package:pos_it/UserInfo/UserInformation.dart';
//Views
import './calendar.dart';
import './News.dart';
import 'ExternalCalls.dart';

class WelcomeName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Welcome "+UserInformation.getDisplayName(),
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 40,color: Colors.blue));
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
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(100.0),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget> [WelcomeName() ,FutureBuilder<String> (
                    future: APICall.getInspirationalQuote(),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }
                )],
              )
            ),
          ),
        )
    );
  }
}