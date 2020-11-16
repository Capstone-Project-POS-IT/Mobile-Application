import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//TODO: change images, add LinkedIn image, scrollable, bottom nav bar

const IconData email = IconData(0xe6f3, fontFamily: 'MaterialIcons');
const IconData arrow_back_rounded = IconData(0xf07b, fontFamily: 'MaterialIcons');

class CreatorsPage extends StatefulWidget {
  @override
  _CreatorsPage createState() => new _CreatorsPage();
}

class _CreatorsPage extends State<CreatorsPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Color(0xff131D47),
      body: Center (
        child: Column (
          children: <Widget>[
            Title(),

            //Nate
            Row( //Name
              children: <Widget>[
              Align(
                alignment: Alignment.center,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 40, 15, 15),
                child: Text("Nathan Kennedy",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xffDCFCDD), fontWeight: FontWeight.bold, fontSize: 25)),
              )
            ]),
            Row( //Image
              children: <Widget>[
              Image.asset("lib/assets/images/posit_logo.png", height:50),
              Align(
                alignment: Alignment.center,
              ),
              Padding( //Text
                padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                child: Container(
                  width: 150,
                  child: new Column(
                      children: <Widget> [
                        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                            textAlign: TextAlign.left,
                            style: TextStyle(color: Color(0xffFFFFFF), fontSize: 15)),
                      ]),
                ),
              )
            ]),
            Row( //Links - email and LinkedIn
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                ),
                Icon(
                  Icons.email,
                  color: Colors.white,
                  size: 40,
                  semanticLabel: 'Send Nathan an email',
                ),
              ]),


            //Tami
            Row( //Name
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 40, 15, 15),
                    child: Text("Tami Yousafi",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xffDCFCDD), fontWeight: FontWeight.bold, fontSize: 25)),
                  )
                ]),
            Row( //Image
                children: <Widget>[
                  Image.asset("lib/assets/images/posit_logo.png", height:50),
                  Align(
                    alignment: Alignment.center,
                  ),
                  Padding( //Text
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Container(
                      width: 150,
                      child: new Column(
                          children: <Widget> [
                            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Color(0xffFFFFFF), fontSize: 15)),
                          ]),
                    ),
                  )
                ]),
            Row( //Links - email and LinkedIn
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  Icon(
                    Icons.email,
                    color: Colors.white,
                    size: 40,
                    semanticLabel: 'Send Tami an email',
                  ),
                ]),


            //Anthony
            Row( //Name
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 40, 15, 15),
                    child: Text("Anthony Baron",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0xffDCFCDD), fontWeight: FontWeight.bold, fontSize: 25)),
                  )
                ]),
            Row( //Image
                children: <Widget>[
                  Image.asset("lib/assets/images/posit_logo.png", height:50),
                  Align(
                    alignment: Alignment.center,
                  ),
                  Padding( //Text
                    padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child: Container(
                      width: 150,
                      child: new Column(
                          children: <Widget> [
                            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Color(0xffFFFFFF), fontSize: 15)),
                          ]),
                    ),
                  )
                ]),
            Row( //Links - email and LinkedIn
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                  ),
                  Icon(
                    Icons.email,
                    color: Colors.white,
                    size: 40,
                    semanticLabel: 'Send Anthony an email',
                  ),
                ]),

          ]
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
  void goToSettings() {} //Go back to settings.dart

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 30, 15, 15),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                  size: 30,
                  semanticLabel: 'Account profile picture',
                ),
              ]),
          Align(
            alignment: Alignment.topRight,
          ),
          Align(
            alignment: Alignment.center,
            child: Padding (
              padding: EdgeInsets.all(20),
              child: Text("About the creators of Pos.it",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xffDCFCDD), fontWeight: FontWeight.bold, fontSize: 30)),
            ),
          ),
        ],
      ),
    );
  }
}